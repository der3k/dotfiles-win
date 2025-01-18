#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

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
