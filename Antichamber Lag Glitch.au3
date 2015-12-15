
Opt("SendKeyDelay", 33) ;5 milliseconds
Opt("SendKeyDownDelay", 33) ;1 millisecond

HotKeySet("{r}", "Toggle")

While 1
	Sleep(100)
WEnd

Func Toggle()
	Send("{ALT down}")
	Send("{TAB}")
	Send("{ALT up}")

	Sleep(250)

	Send("{ALT down}")
	Send("{TAB}")
	Send("+{TAB}")
	Send("+{TAB}")
	Send("{ALT up}")
EndFunc   ;==>Toggle





