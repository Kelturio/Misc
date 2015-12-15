
Opt("SendKeyDelay", 33) ;5 milliseconds
Opt("SendKeyDownDelay", 33) ;1 millisecond

HotKeySet("{f}", "Toggle")

Global $bActive = 0;
Global $nMin = 128 * 1.5;
Global $nMax = 256 * 1.5;

While 1
	Sleep(Random($nMin, $nMax))
	If $bActive = 1 Then Send("{c}")
	If $bActive = 1 Then Sleep(Random($nMin, $nMax) / 10)
	If $bActive = 1 Then Send("{SPACE}")
	If $bActive = 1 Then Sleep(Random($nMin, $nMax) / 10)
	If $bActive = 1 Then Send("{1}")
WEnd
Func Toggle()
	If $bActive = 1 Then
		$bActive = 0
	Else
		$bActive = 1
	EndIf
;~ 	Send("{ALT down
;~ 	Send("{TAB}")
;~ 	Send("{ALT up}")

;~ 	Sleep(250)

;~ 	Send("{ALT down}")
;~ 	Send("{TAB}")
;~ 	Send("+{TAB}")
;~ 	Send("+{TAB}")
;~ 	Send("{ALT up}")
EndFunc   ;==>Toggle





