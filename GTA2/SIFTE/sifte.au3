
HotKeySet("{TAB}", "_burpfart")
HotkeySet("{DEL}" , "_exit")
HotKeySet("{L}", "_BurpFartLoop")

_wait()

Func _wait()
	While 1
		_BurpFartLoop()
		Sleep(Random(300000,600000,1))
	WEnd
EndFunc

Func _burpfart()
	$a = Random(0,1,1)
	If $a = 0 Then
		SoundPlay("SFX_BURP.wav")
	Else
		SoundPlay("SFX_FART.wav")
	EndIf
Endfunc

Func _BurpFartLoop()
	$r = Random(6, 9, 1)
	For $i = 0 To $r Step 1
		_burpfart()
		Sleep(166)
	Next
EndFunc


Func _exit()
	Exit
EndFunc