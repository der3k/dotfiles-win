#InstallKeybdHook
#Persistent
#HotkeyInterval,100
#NoEnv

SetKeyDelay, -1

Menu, TRAY, Icon, ahk.ico

EnvGet, home, USER_HOME
EnvGet, desktop, USER_DESKTOP
EnvGet, console, USER_CONSOLE
EnvGet, editor, USER_EDITOR
EnvGet, viewer, USER_VIEWER

SetWorkingDir %desktop%

:O*:e,,::rsi.news@quick.cz
:O*:eg,,::richard.sikora@gmail.com
:O*:et,,::richard.sikora@tietoevry.com
:O*:t,,::739524873
:O*:s,,::Slezská 1851/40
:TO*:n,,::Nádražní 42/4
:O*:c,,::Český Těšín
:O*:p,,::73701
:O*:o,,::012846595

+<^h:: ; PAD LEFT
  WinGetPos, x, y, w, h, A
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (x <= 0)
  { ; active window is left padded
     if (relWidth<= 25)
     { ; on 25% or less => PAD LEFT 33.33%
        WinMove A,, -4, y, A_ScreenWidth / 3, h
     }
     else if (relWidth <= 33.33)
     { ; on 33.33% or less => PAD LEFT 50%
        WinMove A,, -4, y, A_ScreenWidth / 2, h
     }
     else if (relWidth <= 50)
     { ; on 50% or less => PAD LEFT 66.66%
        WinMove A,, -4, y, A_ScreenWidth * 0.66, h
     }
     else
     { ; ? => 25% left padded => PAD LEFT 25% 
        WinMove A,, -4, y, A_ScreenWidth / 4, h
     }
  }
  else
  { ; PAD LEFT 33.33%
     WinMove A,, -4, 0, A_ScreenWidth / 3, A_ScreenHeight + 7
  }
return

+<^l:: ; PAD RIGHT
  WinGetPos, x, y, w, h, A
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (x + w >= (A_ScreenWidth - 5))
  { ; active window is right padded
     if (relWidth <= 25)
     { ; on 25% or less => PAD RIGHT 33.33%
       WinMove A,, A_ScreenWidth - A_ScreenWidth / 3, y, A_ScreenWidth / 3, h
     }
     else if (relWidth <= 33.33)
     { ; on 33.33% or less => PAD RIGHT 50%
       WinMove A,, A_ScreenWidth - A_ScreenWidth / 2, y, A_ScreenWidth / 2, h
     }
     else if (relWidth <= 50)
     { ; on 50% or less => PAD RIGHT 66.66%
       WinMove A,, A_ScreenWidth - A_ScreenWidth * 0.66, y, A_ScreenWidth * 0.66, h
     }
     else
     { ; ? => PAD RIGHT 25%
       WinMove A,, A_ScreenWidth - A_ScreenWidth / 4, y, A_ScreenWidth / 4, h
     }
  }
  else
  { ; ? => PAD RIGHT 33.33%
     WinMove A,, A_ScreenWidth - A_ScreenWidth / 3, 0, A_ScreenWidth / 3 + 14, A_ScreenHeight + 7
  }
return

+<^i:: ; CENTER
  WinGet, maximized, MinMax, A
  if (maximized = 1)
  {
    WinRestore, A
    return
  }
  WinGetPos, x, y, w, h, A
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (relWidth > 33.33 || (x <=0 && relWidth > 25) || ((x + w >= (A_ScreenWidth - 5) && relWidth > 25)))
  { 
    WinMove A,, A_ScreenWidth / 3 - 18, 0, A_ScreenWidth / 3 + 36, A_ScreenHeight + 7
  }
  else
  { 
    WinMove A,, A_ScreenWidth / 4 - 18, 0, A_ScreenWidth / 2 + 36, A_ScreenHeight + 7
  }
return

+<^k:: ; UP
  WinGetPos, x, y, w, h, A
  if (h < A_ScreenHeight)
  { ; ? + up => full height
    WinMove A,, x, 0, w, A_ScreenHeight
  }
  else
  { ; full height + up => top half height
    WinMove A,, x, 0, w, A_ScreenHeight / 2
  }
return

+<^j:: ; DOWN
  WinGetPos, x, y, w, h, A
  if (h < A_ScreenHeight)
  { ; ? + down => full height
    WinMove A,, x, 0, w, A_ScreenHeight
  }
  else
  { ; full height + down => bottom half height
    WinMove A,, x, A_ScreenHeight / 2, w, A_ScreenHeight / 2
  }
return

*<!n::WinMinimize, A

*<!m::
  if WinActive("ahk_exe CDViewer.exe")
  {
    SendInput {Ctrl down}q{Ctrl up}
  }
  else
  {
    Send {Alt down}{Tab}
  }
return

+<^r::
  Reload
return

#a::
  selection := Clipboard
  Clipboard := selection
return

#^t::
  FormatTime, timeStamp, , yyyy-MM-dd hh:mm:ss
  SendInput %timeStamp%
return

#IfWinActive, ahk_exe alacritty.exe
<^k::^b
<^Space::^b
#IfWinActive

; Directory window
#IfWinActive, ahk_class CabinetWClass
F3::openSelectionInViewer()
F4::openSelection()
+F4::createFileFromWinTitle()
F7::createDirFromWinTitle()
^d::openDosFromWinTitle()
#IfWinActive

; Explorer
#IfWinActive, ahk_class ExploreWClass
F3::openSelectionInViewer()
F4::openSelection()
+F4::createFileFromWinTitle()
F7::createDirFromWinTitle()
^d::openDosFromWinTitle()
#IfWinActive

openDosFromWinTitle() {
  global
  WinGetTitle dird
  Run, %console% -d "%dir%"
}

openSelection() {
  global
  selection := getSelection()
  FileGetAttrib, attribs, %selection%
  If attribs = ""
     return
  IfInString, attribs, D
    openDir(selection)
  else
    Run %editor% "%selection%"
}

openDir(path) {
  Run, explorer /n`,%path%
}

getDirFromWinTitle() {
  WinGetTitle dir
	return dir
}

createDirFromWinTitle() {
  WinGetTitle dir
  createDirOnPath(dir)
}

createDirOnPath(dir) {
  InputBox, name, New folder name, , , 300, 100
  if ErrorLevel
    return
  path = %dir%\%name%\
  FileCreateDir, %path%
;  RunWait, cmd /c md %path%, , Hide
  openDir(path)
}

createFileFromWinTitle() {
  WinGetTitle dir
  createFileOnPath(dir)
}

createFileOnPath(dir) {
  global
  InputBox, name, New file name, , , 300, 100
  if ErrorLevel
    return
  path = %dir%\%name%
  FileAppend, , %path%
  Run %editor% "%path%"
}

createDir() {
;  SplitPath, selection, , dir, , name
;  FileCreateDir %dir%\NewFolder
;  PostMessage, 0x111, 30743
;  Send {AppsKey}wf
;  Send {AppsKey}wf

;  Send {f5}{AppsKey}wf
;  PostMessage, 0x111, 41504, 0 ; refresh
;  PostMessage, 0x111, 28697, 0 ; copy to clippboard

  PostMessage, 0x111, 41504, 0 ; refresh
  SendInput {AppsKey}wf

}

openSelectionInNotepadP() {
	global
  selection := getSelection()
  Run "%editor%" "%selection%"
}

openSelectionInViewer() {
	global
  selection := getSelection()
  Run "%viewer%" "%selection%"
}

#+q::WinSet AlwaysOnTop, Toggle, A

+<^;::
  showHideAppWin("ahk_exe alacritty.exe", "C:\Program Files\Alacritty\alacritty.exe --config-file C:\home\etc\dotfiles\alacritty\alacritty.toml")
return

; ------------------------------------------------------------------------
; Functions
; ------------------------------------------------------------------------

getSelection()
{
  theClipboard := ClipboardAll
  Clipboard =
  Send ^c
  ClipWait,,
  selection := Clipboard
  Clipboard := theClipboard
  Return %selection%
}


showHideAppWin(winTitle, appPath) {
  if WinExist(winTitle) {
    if WinActive() {
      Send !{Tab}
    } else  {
      WinActivate
    }
  } else {
    Run %appPath%
  }
}

showAppWin(winTitle, appPath) {
  if WinExist(winTitle)
  {
    WinActivate
  }
  else
  {
    Run %appPath%
  }
}

;---
; Vim layer
;---

Escape::Send {Blind}{Escape}

Escape & h::Send {Blind}{Left}
Escape & j::Send {Blind}{Down}
Escape & k::Send {Blind}{Up}
Escape & l::Send {Blind}{Right}

Escape & y::Send {Blind}^{Left}
Escape & o::Send {Blind}^{Right}

Escape & u::Send {Blind}{Home}
Escape & i::Send {Blind}{End}

Escape & `;::Send {Blind}{Backspace}
Escape & p::Send {Blind}{Del}

Escape & '::Send {Blind}^{Backspace}

^;::Send {Blind}^b
Escape & [::Send {Blind}^b

Escape & m::AltTab
Escape & n::WinMinimize, A
Escape & .::Send {Blind}^s

Escape & Space::Send {Blind}!{Space}
