#UseHook
SendMode("Input")


#HotIf WinActive("Trusted Vendor")
#MaxThreads 255
#MaxThreadsPerHotkey 255
Escape & m::
{
  Send("^q")
  ;Send("{LCtrl down}q")
  ;Keywait("{LAlt}")
  ;Send("{LCtrl up}")
}
#MaxThreadsPerHotkey
#HotIf
