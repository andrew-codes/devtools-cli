;=======================================================================================
;Keyboard shortcuts
;
;Description:
;  Shortcuts for Visual Studio/ReSharper and WebStorm to match WebStorm in OSX.
;=======================================================================================
vsModeEnabledIcon := "icon-visual-studio-mode.png"
webStormEnabledIcon = "icon-webstorm-mode.png"
noModeEnabledIcon := "icon-no-mode.png"
IsInVisualStudioMode := false
IsInWebStormModel := false
SetNoMode()

;==========================
;Set no tool mode
;==========================
SetNoMode() {
  local iconFile := noModeEnabledIcon

  IsInVisualStudioMode := false
  IsInWebStormModel := false
  Menu, Tray, Icon, %iconFile%,
  Menu, Tray, Tip, No tool mode enabled
}

;==========================
;Set Visual Studio mode
;==========================
SetVisualStudioMode() {
  SetNoMode()
  local iconFile := vsModeEnabledIcon

  IsInVisualStudioMode := true
  Menu, Tray, Icon, %iconFile%,
  Menu, Tray, Tip, Visual Studio mode enabled
}

;==========================
;Set WebStorm mode
;==========================
SetWebStormMode() {
  SetNoMode()
  local iconFile := webStormModeEnabledIcon

  IsInWebStormMode := true
  Menu, Tray, Icon, %iconFile%,
  Menu, Tray, Tip, WebStorm mode enabled
}

;==========================
;Enable Visual Studio mode
;==========================
RWin & v::
  SetVisualStudioMode()
return

;==========================
;Enable WebStorm mode
;==========================
RWin & w::
  SetWebStormMode()
return

;==========================
;Escape tooling mode
;==========================
;Map to escape or shift + escape
RWin & e::
  SetNoMode()
return

;==========================
;Windows Key
;==========================
LWin::
  if (IsInVisualStudioMode) {
    Send, Ctrl
  } else if (IsInWebStormMode){
    Send, Ctrl
  } else {
    Send, LWin
  }
return

;==========================
;Insert new file template
;==========================
LWin & n::
  if (IsInVisualStudioMode) {
    Send, Ctrl Alt Ins
  } else if (IsInWebStormMode){
    Send, Alt Ins
  } else {
    Send, LWin n
  }
return

;==========================
;Search everywhere
;==========================
LShift & LShift::
  if (IsInVisualStudioMode) {
    Send, Ctrl T
  } else {
    Send, LShift LShift
  }
return

;==========================
;Search by class name
;==========================
LWin & o::
  if (IsInVisualStudioMode) {
    Send, Shift Alt t
  } else if (IsInWebStormMode){
    Send, Ctrl n
  } else {
    Send, LWin o
  }
return

;==========================
;Search by symbol name
;==========================
LWin & LAlt & o::
  if (IsInVisualStudioMode) {
    Send, Alt \
  } else if (IsInWebStormMode){
    Send, Ctrl Alt Shift n
  } else {
    Send, LWin LAlt o
  }
return

;==========================
;Search by file name
;==========================
LWin & LShift & o::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift T
  } else if (IsInWebStormMode){
    Send, Ctrl Shift n
  } else {
    Send, LWin LShift o
  }
return

;==========================
;Line comment
;==========================
LWin & /::
  if (IsInVisualStudioMode) {
    Send, Ctrl Alt /
  } else {
    Send, LWin /
  }
return

;==========================
;Reformat code
;==========================
LWin & LAlt & l::
  if (IsInVisualStudioMode) {
    Send, Ctrl e, d
  } else {
    Send, LWin LAlt l
  }
return

;==========================
;Refactor rename
;==========================
Shift & F6::
  if (IsInVisualStudioMode) {
    Send, Ctrl r, r
  } else {
    Send, Shift F6
  }
return

;==========================
;Refactor move
;==========================
F6::
  if (IsInVisualStudioMode) {
    Send, Ctrl r, o
  } else {
    Send, F6
  }
return

;==========================
;Refactor this
;==========================
Ctrl t::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift r
  } else {
    Send, Ctrl t
  }
return

;==========================
;Navigate backwards
;==========================
LWin & [::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift BS
  } else {
    Send, LWin [
  }
return

;==========================
;Move Line up
;==========================
Shift & LWin & Up::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift Alt Up
  } else {
    Send, Shift & LWin & Up
  }
return

;==========================
;Move Line down
;==========================
Shift & LWin & Down::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift Alt Down
  } else {
    Send, Shift & LWin & Down
  }
return

;==========================
;Move Line left
;==========================
Shift & LWin & Left::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift Alt Left
  } else {
    Send, Shift & LWin & Left
  }
return

;==========================
;Move Line right
;==========================
Shift & LWin & Right::
  if (IsInVisualStudioMode) {
    Send, Ctrl Shift Alt Right
  } else {
    Send, Shift & LWin & Right
  }
return
