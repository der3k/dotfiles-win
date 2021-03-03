#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

Escape::Send {Blind}{Escape}

Escape & h::Send {Blind}{Left}
Escape & j::Send {Blind}{Down}
Escape & k::Send {Blind}{Up}
Escape & l::Send {Blind}{Right}

Escape & u::Send {Blind}^{Left}
Escape & i::Send {Blind}^{Right}

Escape & y::Send {Blind}{Home}
Escape & o::Send {Blind}{End}

Escape & `;::Send {Blind}{Backspace}
Escape & p::Send {Blind}{Del}

Escape & m::AltTab
Escape & n::WinMinimize, A
Escape & .::Send {Blind}^s

Escape & Space::Send {Blind}!{Space}
