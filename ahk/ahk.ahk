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

:?:lh::localhost
:O:rsi,::rsi.news@quick.cz
:O:739,::739524873
:O:sl,::Slezská 1851/40
:O:ct,::Český Těšín
:O:psc,::73701
:O:op,::012846595

*<!h:: ; LEFT
  WinGetPos, x, y, w, h, A
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (x <= 0)
  { ; left padded
     if (relWidth<= 25)
     { ; on 25% or less => 33.33% left padded 
        WinMove A,, 0, y, A_ScreenWidth / 3, h
     }
     else if (relWidth <= 33.33)
     { ; on 33.33% or less => 50% left padded 
        WinMove A,, 0, y, A_ScreenWidth / 2, h
     }
     else if (relWidth <= 50)
     { ; on 50% or less => 66.66% left padded 
        WinMove A,, 0, y, A_ScreenWidth * 0.66, h
     }
     else
     { ; ? => 25% left padded 
        WinMove A,, 0, y, A_ScreenWidth / 4, h
     }
  }
  else if (x + w >= (A_ScreenWidth - 5))
  { ; right padded + pad_left => center
    if (relWidth <= 25)
    {
       WinMove A,, A_ScreenWidth / 4, 0, A_ScreenWidth / 2, A_ScreenHeight
    }
    else
    {
       WinMove A,, A_ScreenWidth / 3, 0, A_ScreenWidth / 3, A_ScreenHeight
    }
  }
  else
  { ; ? + pad_left => pad_left
     WinMove A,, 0, y, A_ScreenWidth / 3, h
  }
return

*<!l::
  WinGetPos, x, y, w, h, A
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (x <= 0)
  { ; left padded + pad_right => center
    if (relWidth <= 25)
    {
      WinMove A,, A_ScreenWidth / 4, 0, A_ScreenWidth / 2, A_ScreenHeight
    }
    else
    {
      WinMove A,, A_ScreenWidth / 3, 0, A_ScreenWidth / 3, A_ScreenHeight
    }
  }
  else if (x + w >= (A_ScreenWidth - 5))
  { ; right padded
     if (relWidth <= 25)
     { ; on 25% or less => 33.33% right padded 
       WinMove A,, A_ScreenWidth - A_ScreenWidth / 3, y, A_ScreenWidth / 3, h
     }
     else if (relWidth <= 33.33)
     { ; on 33.33% or less => 50% right padded 
       WinMove A,, A_ScreenWidth - A_ScreenWidth / 2, y, A_ScreenWidth / 2, h
     }
     else if (relWidth <= 50)
     { ; on 50% or less => 66.66% right padded 
       WinMove A,, A_ScreenWidth - A_ScreenWidth * 0.66, y, A_ScreenWidth * 0.66, h
     }
     else
     { ; ? => 25% right padded 
       WinMove A,, A_ScreenWidth - A_ScreenWidth / 4, y, A_ScreenWidth / 4, h
     }
  }
  else
  { ; ? => 33.33% right padded 
     WinMove A,, A_ScreenWidth - A_ScreenWidth / 3, y, A_ScreenWidth / 3, h
  }
return

*<!i::
  WinGetPos, x, y, w, h, A
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (relWidth > 33.33 || (x <=0 && relWidth > 25) || ((x + w >= (A_ScreenWidth - 5) && relWidth > 25)))
  { 
    WinMove A,, A_ScreenWidth / 3, 0, A_ScreenWidth / 3, A_ScreenHeight
  }
  else
  { 
    WinMove A,, A_ScreenWidth / 4, 0, A_ScreenWidth / 2, A_ScreenHeight
  }
return

*<!k::
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

*<!j::
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

#+r::
  Reload
return

^#l::
  selection := getSelection()
  FileGetAttrib, attribs, %selection%
  If attribs = ""
     return
  IfInString, attribs, D
  { 
    StringGetPos, i, selection, `\,R
    StringMid, name, selection, i + 2
   }
  else
  {
    SplitPath, selection, name
  }
  FileCreateShortcut, %selection%,  C:\etc\links\%name%.lnk
return

#a::
  selection := Clipboard
  Clipboard := selection
return

#^t::
  FormatTime, timeStamp, , yyyy-MM-dd hh:mm:ss
  SendInput %timeStamp%
return

; Desktop
#IfWinActive, ahk_class Progman
F3::openSelectionInViewer()
F4::openSelection()
+F4::createFileOnPath(desktop)
F7::createDirOnPath(desktop)
^d::Run, %console%, desktop
#IfWinActive

; Desktop of Win7
#IfWinActive, ahk_class WorkerW
F3::openSelectionInViewer()
+F4::createFileOnPath(desktop)
F7::createDirOnPath(desktop)
^d::Run, %console%, desktop
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


#+b::
  WinGetTitle wTitle, A
  WinSet Transparent, 100, %wTitle%
  Sleep 1000
  WinSet Transparent, Off, %wTitle%
return

#+q::WinSet AlwaysOnTop, Toggle, A

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
      WinMinimize
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
