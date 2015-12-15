#include <HotKeySetEx.au3>
#include <ToolTipTimer.au3>

HotKeySet("{ESC}", "_Quit") ; panic button - can disable if you use the 'ESC' key for something else

_ToolTipTimer('HotKeySetEx example ' &  @CRLF &  ' ESC panic button.' &  @CRLF & 			' test F1 and Mouse Right Click and Right Double Click - see code' & @CRLF & 'Message goes after 10 secs' & @CRLF , 10000)

; note if you set a hot key for double click the single click is blocked (bug)
HotKeySetEx("{RCLICK}", "myfun") ; Right Click mouse hot key
HotKeySetEx("{RDCLICK}", "myfun") ; Right double click mouse hot key
HotKeySetEx("{F1}", "myfun") ; normal hot key

While 1

	sleep(10)

WEnd


func myfun() ; user defined function for hot key
   dim $hotkey
   $hotkey = getLastHotKey()
   $hotkeyType = getLastHotKeyType() ; Optional
   ConsoleWrite("hotkey  " &  $hotkey & " " & $hotkeyType  & @CRLF)
   _ToolTipTimer($hotkey & " " & $hotkeyType  , 1000, default, default, default, default,  1 )
endfunc



Func _Quit()

	;HotKeySetEx("{RCLICK}", "") ; deregister
	ToolTip('Quiting -  Good bye')
	sleep(2000)
	Exit
EndFunc