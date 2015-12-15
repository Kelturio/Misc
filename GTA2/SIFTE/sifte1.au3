
HotKeySet("{TAB}", "_burpfart")

_wait()

Func _wait()
	While 1
		Sleep(20)
	WEnd
EndFunc

Func _burpfart()
	$a = Random(0,1,1)
	If $a = 0 Then
		SoundPlay("SFX_BURP.wav")
	Else
		SoundPlay("SFX_FART.wav")
	EndIf
	Return _wait()
Endfunc

