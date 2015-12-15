
; version 2
; used PhoenixXL suggested code


; Display a tool tip (usually at mouse pointer)
; for an arbitary amount of time without the need of a sleep() 
; Adds a timeout parameter to the tooltip command so it works like tray tips.
; Useful when dislaying a tooltip at the mouse pointer 
; when you don't want to halt the program eg. when handling Mouse events
;
; returns - the same as tooltip()
;
; see example
Func _ToolTipTimer($sTooltipText, $iTimer, $x = Default, $y = Default, $title = Default, $icon = Default, $options = Default)

Local $iRet = ToolTip($sTooltipText, $x, $y, $title, $icon, $options);

AdlibRegister("_ToolTipTimer_Blank", $iTimer) ; create timer

Return $iRet

EndFunc   ;==>_ToolTipTimer

Func _ToolTipTimer_Blank( )

ToolTip('')

AdlibUnRegister("_ToolTipTimer_Blank")

EndFunc   ;==>_ToolTipTimer_Blank