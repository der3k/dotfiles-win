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

:O:lho::localhost
:O:rsi.::rsi.news@quick.cz
:O:739.::739524873
:O:sl.::Slezská 1851/40
:O:ct.::Èeský Tìšín
:O:psc.::73701
:O:op.::012846595

#+r::
  ;SendInput ^s
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
  WinGetTitle dir
  Run, %console% /K cd /D "%dir%"
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

