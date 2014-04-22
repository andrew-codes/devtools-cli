;=======================================================================================
;Keyboard shortcuts
;
;Description:
;  Shortcuts for Visual Studio/ReSharper and WebStorm to match WebStorm in OSX.
;=======================================================================================
vsModeEnabledIcon := "icon-visual-studio-mode.ico"
webStormEnabledIcon := "icon-webstorm-mode.ico"
noModeEnabledIcon := "icon-no-mode.ico"
IsInVisualStudioMode := false
IsInWebStormModel := false
SetNoMode()

;==========================
;Set no tool mode
;==========================
SetNoMode() {
  IsInVisualStudioMode := false
  IsInWebStormModel := false
  Menu, Tray, Icon, %noModeEnabledIcon%,
  Menu, Tray, Tip, No tool mode enabled
}

;==========================
;Set Visual Studio mode
;==========================
SetVisualStudioMode() {
  SetNoMode()
  IsInVisualStudioMode := true
  Menu, Tray, Icon, %vsModeEnabledIcon%,
  Menu, Tray, Tip, Visual Studio mode enabled
}

;==========================
;Set WebStorm mode
;==========================
SetWebStormMode() {
  SetNoMode()
  IsInWebStormMode := true
  Menu, Tray, Icon, %webStormModeEnabledIcon%,
  Menu, Tray, Tip, WebStorm mode enabled
}

;==========================
;Enable Visual Studio mode
;==========================
RWin & F3::
  SetVisualStudioMode()
return

;==========================
;Enable WebStorm mode
;==========================
RWin & F4::
  SetWebStormMode()
return

;==========================
;Escape tooling mode
;==========================
;Map to escape or shift + escape
RWin & F2::
  SetNoMode()
return

;==========================
;Windows Key
;==========================
LWin::
  if (IsInVisualStudioMode) {
    Send {Ctrl}
  } else if (IsInWebStormMode){
    Send {Ctrl}
  } else {
    Send {LWin}
  }
return

;==========================
;Insert new file template
;==========================
LWin & n::
  if (IsInVisualStudioMode) {
    Send {Ctrl}{Alt}{Ins}
  } else if (IsInWebStormMode){
    Send {Alt}{Ins}
  } else {
    Send {LWin}n
  }
return

;==========================
;Search everywhere
;==========================
LShift & LShift::
  if (IsInVisualStudioMode) {
    Send {Ctrl}t
  } else {
    Send, {LShift 2}
  }
return

;==========================
;Search by class name
;==========================
LWin & o::
  if (IsInVisualStudioMode) {
    Send {Shift}{Alt}t
  } else if (IsInWebStormMode){
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
    if (IsInVisualStudioMode) {
      Send {Alt}\
    } else if (IsInWebStormMode){
      Send {Ctrl}{Alt}{Shift}n
    } else {
      Send {LWin}{LAlt}o
    }
  }
return

;==========================
;Search by file name
;==========================
LShift & o::
  if GetKeyState("LWin","P") {
    if (IsInVisualStudioMode) {
      Send  {Ctrl}{Shift}t
    } else if (IsInWebStormMode){
      Send {Ctrl}{Shift}n
    } else {
      Send {LWin}{LShift}o
    }
  }
return

;==========================
;Line comment
;==========================
LWin & /::
  if (IsInVisualStudioMode) {
    Send {Ctrl}{Alt}/
  } else {
    Send {LWin}/
  }
return

;==========================
;Reformat code
;==========================
LAlt & l::
  if GetKeyState("LWin","P") {
    if (IsInVisualStudioMode) {
      Send {Ctrl down}{e down}{Ctrl up}{e up}d
    } else {
      Send {LWin}{LAlt}l
    }
  }
return

;==========================
;Refactor rename
;==========================
Shift & F6::
  if (IsInVisualStudioMode) {
    Send {Ctrl down}{r down}{Ctrl up}{r up}r
  } else {
    Send {Shift}{F6}
  }
return

;==========================
;Refactor move
;==========================
F6::
  if (IsInVisualStudioMode) {
    Send {Ctrl down}{r down}{Ctrl up}{r up}o
  } else {
    Send {F6}
  }
return

;==========================
;Refactor this
;==========================
Ctrl & t::
  if (IsInVisualStudioMode) {
    Send {Ctrl}{Shift}r
  } else {
    Send {Ctrl}t
  }
return

;==========================
;Navigate backwards
;==========================
LWin & [::
  if (IsInVisualStudioMode) {
    Send {Ctrl}{Shift}{BS}
  } else {
    Send {LWin}[
  }
return

;==========================
;Move Line up
;==========================
Shift & Up::
  if GetKeyState("LWin","P") {
    if (IsInVisualStudioMode) {
      Send {Ctrl}{Shift}{Alt}{Up}
    } else {
      Send {Shift}{LWin}{Up}
    }
  }
return

;==========================
;Move Line down
;==========================
Shift & Down::
  if GetKeyState("LWin","P") {
if (IsInVisualStudioMode) {
      Send {Ctrl}{Shift}{Alt}{Down}
    } else {
      Send {Shift}{LWin}{Down}
    }
  }
return

;==========================
;Move Line left
;==========================
Shift & Left::
  if GetKeyState("LWin","P") {
    if (IsInVisualStudioMode) {
      Send {Ctrl}{Shift}{Alt}{Left}
    } else {
      Send {Shift}{LWin}{Left}
    }
  }
return

;==========================
;Move Line right
;==========================
Shift & Right::
  if GetKeyState("LWin","P") {
  if (IsInVisualStudioMode) {
      Send {Ctrl}{Shift}{Alt}{Right}
    } else {
      Send {Shift}{LWin}{Right}
    }
  }
return
