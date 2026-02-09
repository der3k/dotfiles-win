#Requires AutoHotkey v2.0
InstallKeybdHook()
Persistent(true)
#HotkeyInterval 100

SetKeyDelay(-1)

TraySetIcon("ahk.ico")

home := EnvGet("USER_HOME")
desktop := EnvGet("USER_DESKTOP")
console := EnvGet("USER_CONSOLE")
editor := EnvGet("USER_EDITOR")
viewer := EnvGet("USER_VIEWER")

SetWorkingDir(desktop)

:O*:e,,::rsi.news@quick.cz
:O*:eg,,::richard.sikora@gmail.com
:O*:et,,::richard.sikora@tietoevry.com
:O*:t,,::739524873
:O*:s,,::Slezská 1851/40
:TO*:n,,::Nádražní 42/4
:O*:c,,::Český Těšín
:O*:p,,::73701
:O*:o,,::012846595

+<^h:: { ; PAD LEFT
  WinGetPos(&x, &y, &w, &h, "A")
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (x <= 0)
  { ; active window is left padded
    if (relWidth<= 25)
    { ; on 25% or less => PAD LEFT 33.33%
      WinMove("A",, -4, y, A_ScreenWidth / 3, h)
    }
    else if (relWidth <= 33.33)
    { ; on 33.33% or less => PAD LEFT 50%
      WinMove("A",, -4, y, A_ScreenWidth / 2, h)
    }
    else if (relWidth <= 50)
    { ; on 50% or less => PAD LEFT 66.66%
      WinMove("A",, -4, y, A_ScreenWidth * 0.66, h)
    }
    else
    { ; ? => 25% left padded => PAD LEFT 25%
      WinMove("A",, -4, y, A_ScreenWidth / 4, h)
    }
  }
  else
  { ; PAD LEFT 33.33%
    WinMove("A",, -4, 0, A_ScreenWidth / 3, A_ScreenHeight + 7)
  }
}

+<^l:: { ; PAD RIGHT
  WinGetPos(&x, &y, &w, &h, "A")
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (x + w >= (A_ScreenWidth - 5))
  { ; active window is right padded
    if (relWidth <= 25)
    { ; on 25% or less => PAD RIGHT 33.33%
      WinMove("A",, A_ScreenWidth - A_ScreenWidth / 3, y, A_ScreenWidth / 3, h)
    }
    else if (relWidth <= 33.33)
    { ; on 33.33% or less => PAD RIGHT 50%
      WinMove("A",, A_ScreenWidth - A_ScreenWidth / 2, y, A_ScreenWidth / 2, h)
    }
    else if (relWidth <= 50)
    { ; on 50% or less => PAD RIGHT 66.66%
      WinMove("A",, A_ScreenWidth - A_ScreenWidth * 0.66, y, A_ScreenWidth * 0.66, h)
    }
    else
    { ; ? => PAD RIGHT 25%
      WinMove("A",, A_ScreenWidth - A_ScreenWidth / 4, y, A_ScreenWidth / 4, h)
    }
  }
  else
  { ; ? => PAD RIGHT 33.33%
    WinMove("A",, A_ScreenWidth - A_ScreenWidth / 3, 0, A_ScreenWidth / 3 + 14, A_ScreenHeight + 7)
  }
}

+<^i:: { ; CENTER
  maximized := WinGetMinMax("A")
  if (maximized = 1)
  {
    WinRestore("A")
    return
  }
  WinGetPos(&x, &y, &w, &h, "A")
  relWidth := Round((w / A_ScreenWidth) * 100, 2)
  if (relWidth > 33.33 || (x <=0 && relWidth > 25) || ((x + w >= (A_ScreenWidth - 5) && relWidth > 25)))
  {
    WinMove("A",, A_ScreenWidth / 3 - 18, 0, A_ScreenWidth / 3 + 36, A_ScreenHeight + 7)
  }
  else
  {
    WinMove("A",, A_ScreenWidth / 4 - 18, 0, A_ScreenWidth / 2 + 36, A_ScreenHeight + 7)
  }
}

+<^k:: { ; UP
  WinGetPos(&x, &y, &w, &h, "A")
  if (h < A_ScreenHeight)
  { ; ? + up => full height
    WinMove("A",, x, 0, w, A_ScreenHeight)
  }
  else
  { ; full height + up => top half height
    WinMove("A",, x, 0, w, A_ScreenHeight / 2)
  }
}

+<^j:: { ; DOWN
  WinGetPos(&x, &y, &w, &h, "A")
  if (h < A_ScreenHeight)
  { ; ? + down => full height
    WinMove("A",, x, 0, w, A_ScreenHeight)
  }
  else
  { ; full height + down => bottom half height
    WinMove("A",, x, A_ScreenHeight / 2, w, A_ScreenHeight / 2)
  }
}

*<!n::WinMinimize("A")

*<!m:: {
  if WinActive("ahk_exe CDViewer.exe")
  {
    SendInput("{Ctrl down}q{Ctrl up}")
  }
  else
  {
    Send("{Alt down}{Tab}")
  }
}

+<^r:: {
  Reload()
}

#a:: {
  selection := A_Clipboard
  A_Clipboard := selection
}

#^t:: {
  timeStamp := FormatTime(, "yyyy-MM-dd hh:mm:ss")
  SendInput(timeStamp)
}

#HotIf WinActive("ahk_exe alacritty.exe")
<^k::^b
<^Space::^b
#HotIf

; Directory window
#HotIf WinActive("ahk_class CabinetWClass")
F3::openSelectionInViewer()
;F4::openSelection()
;+F4::createFileFromWinTitle()
F7::createDirFromWinTitle()
^d::openDosFromWinTitle()
#HotIf

; Explorer
#HotIf WinActive("ahk_class ExploreWClass")
F3::openSelectionInViewer()
;F4::openSelection()
;+F4::createFileFromWinTitle()
F7::createDirFromWinTitle()
^d::openDosFromWinTitle()
#HotIf

openDosFromWinTitle() {
  global
  dir := WinGetTitle("A")
  Run(console . ' -d "' . dir . '"')
}

openSelection() {
  global
  selection := getSelection()
  attribs := FileGetAttrib(selection)
  If attribs = ""
    return
  if InStr(attribs, "D")
    openDir(selection)
  else
    Run(editor . ' "' . selection . '"')
}

openDir(path) {
  Run("explorer /n`," . path)
}

getDirFromWinTitle() {
  dir := WinGetTitle("A")
  return dir
}

createDirFromWinTitle() {
  dir := WinGetTitle("A")
  createDirOnPath(dir)
}

createDirOnPath(dir) {
  name := InputBox("New folder name", , , 300, 100)
  if name.Result != "OK"
    return
  path := dir . "\" . name.Value . "\"
  DirCreate(path)
  ;  RunWait, cmd /c md %path%, , Hide
  openDir(path)
}

createFileFromWinTitle() {
  dir := WinGetTitle("A")
  createFileOnPath(dir)
}

createFileOnPath(dir) {
  global
  name := InputBox("New file name", , , 300, 100)
  if name.Result != "OK"
    return
  path := dir . "\" . name.Value
  FileAppend("", path)
  Run(editor . ' "' . path . '"')
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

  PostMessage(0x111, 41504, 0) ; refresh
  SendInput("{AppsKey}wf")

}

openSelectionInViewer() {
  global
  selection := getSelection()
  Run(viewer . ' "' . selection . '"')
}

#+q::WinSetAlwaysOnTop(-1, "A")

+<^;:: {
  showHideAppWin("ahk_exe alacritty.exe", "C:\Program Files\Alacritty\alacritty.exe --config-file C:\home\etc\dotfiles\alacritty\alacritty.toml")
}

; ------------------------------------------------------------------------
; Functions
; ------------------------------------------------------------------------

getSelection()
{
  theClipboard := ClipboardAll()
  A_Clipboard := ""
  Send("^c")
  ClipWait()
  selection := A_Clipboard
  A_Clipboard := theClipboard
  Return selection
}

showHideAppWin(winTitle, appPath) {
  if WinExist(winTitle) {
    if WinActive() {
      Send("!{Tab}")
    } else  {
      WinActivate()
    }
  } else {
    Run(appPath)
  }
}

showAppWin(winTitle, appPath) {
  if WinExist(winTitle)
  {
    WinActivate()
  }
  else
  {
    Run(appPath)
  }
}

;---
; Vim layer
;---

Escape::Send("{Blind}{Escape}")

Escape & h::Send("{Blind}{Left}")
Escape & j::Send("{Blind}{Down}")
Escape & k::Send("{Blind}{Up}")
Escape & l::Send("{Blind}{Right}")

Escape & u::Send("{Blind}^{Left}")
Escape & i::Send("{Blind}^{Right}")

Escape & y::Send("{Blind}{Home}")
Escape & o::Send("{Blind}{End}")

Escape & `;::Send("{Blind}{Backspace}")
Escape & p::Send("{Blind}{Del}")

Escape & '::Send("{Blind}^{Backspace}")

^;::Send("{Blind}^b")
Escape & [::Send("{Blind}^b")

Escape & m::AltTab
Escape & n::WinMinimize("A")
Escape & .::Send("{Blind}^s")

Escape & Space::Send("{Blind}!{Space}")
