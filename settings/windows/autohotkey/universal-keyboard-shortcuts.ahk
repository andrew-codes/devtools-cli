;=======================================================================================
;Keyboard shortcuts
;
;Description:
;  Shortcuts for Visual Studio/ReSharper and WebStorm to match WebStorm in OSX.
;=======================================================================================

;==========================
;Insert new file template
;==========================
LWin::
  Send ^
return

;==========================
;Insert new file template
;==========================
LWin & n::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send ^!{Ins}
  } else if (active_process_name = "WebStorm.exe") {
     SendEvent !{Ins}
  }
return

;==========================
;Search everywhere
;==========================
lastShift := 0
LShift::
if ((A_TickCount - lastShift) <= 250) {
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send ^t
  }
} else {
  Send {Shift}
}
lastShift := A_TickCount
return

;==========================
;Search by class name
;==========================
LWin & o::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send {Shift down}!t{Shift up}
  } else if (active_process_name = "WebStorm.exe") {
    Send {Ctrl}n
  } else {
    Send {LWin}o
  }
return

;==========================
;Search by symbol name
;==========================
LAlt & o::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send !\
    } else if (active_process_name = "WebStorm.exe") {
      Send ^!{Shift}n
    } else {
      Send {LWin}!o
    }
  }
return

;==========================
;Search by file name
;==========================
LShift & o::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send  {Shift down}^t{Shift up}
    } else if (active_process_name = "WebStorm.exe") {
      Send ^{Shift}n
    } else {
      Send {LWin}{LShift}o
    }
  }
return

;==========================
;Search by file name
;==========================
LWin & g::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send  ^g
  } else if (active_process_name = "WebStorm.exe") {
    Send ^g
  } else {
    Send {LWin}g
  }
return

;==========================
;Line comment
;==========================
LWin & /::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send ^!/
  } else if (active_process_name = "WebStorm.exe") {
    Send ^/
  } else {
    Send {LWin}/
  }
return

;==========================
;Reformat code
;==========================
LAlt & l::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send ^ed
    } else {
      Send {LWin}!l
    }
  }
return

;==========================
;Refactor rename
;==========================
Shift & F6::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send ^rr
  } else {
    Send {Shift}{F6}
  }
return

;==========================
;Refactor move
;==========================
F6::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send ^ro
  } else {
    Send {F6}
  }
return

;==========================
;Refactor this
;==========================
Ctrl & t::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send {Shift down}^r{Shift up}
  } else {
    Send ^t
  }
return

;==========================
;Navigate backwards
;==========================
LWin & [::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "devenv.exe") {
    Send {Shift down}^{BS}{Shift up}
  } else if (active_process_name = "WebStorm.exe") {
    Send ^[
  } else {
    Send {LWin}[
  }
return

;==========================
;Navigate forwards
;==========================
LWin & ]::
  WinGet, active_process_name, ProcessName, A
  if (active_process_name = "WebStorm.exe") {
    Send ^]
  } else {
    Send {LWin}]
  }
return

;==========================
;Move Line up
;==========================
Shift & Up::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send {Shift down}^!{Up}{Shift up}
    } else if (active_process_name = "WebStorm.exe") {
      Send {Shift down}^{Up}{Shift up}
    } else {
      Send {LWin}{Shift}{Up}
    }
  }
return

;==========================
;Move Line down
;==========================
Shift & Down::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send {Shift down}^!{Down}{Shift up}
    } else if (active_process_name = "WebStorm.exe") {
      Send {Shift down}^{Down}{Shift up}
    } else {
      Send {LWin}{Shift}{Down}
    }
  }
return

;==========================
;Move Line left
;==========================
Shift & Left::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send {Shift down}^!{Left}{Shift up}
    } else if (active_process_name = "WebStorm.exe") {
      Send {Shift down}^{Left}{Shift up}
    } else {
      Send {LWin}{Shift}{Left}
    }
  }
return

;==========================
;Move Line right
;==========================
Shift & Right::
  if GetKeyState("LWin","P") {
    WinGet, active_process_name, ProcessName, A
    if (active_process_name = "devenv.exe") {
      Send {Shift down}^!{Right}{Shift up}
    } else if (active_process_name = "WebStorm.exe") {
      Send {Shift down}^{Right}{Shift up}
    } else {
      Send {LWin}{Shift}{Right}
    }
  }
return
