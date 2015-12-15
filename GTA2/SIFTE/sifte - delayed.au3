
;~ HotKeySet("{TAB}", "_burpfart")
;~ HotKeySet("{1}", "_fart")
;~ HotKeySet("{2}", "_burp")


_wait()

Func _wait()
	While 1
;~ 		Sleep(Random(3*60*1000, 6*60*1000, 1))
		For $i = 1 To Random(3, 9, 1)
			_burpfart()
			Sleep(Random(333, 666, 1))
		Next
		Sleep(Random(3 * 60 * 1000, 6 * 60 * 1000, 1))
	WEnd
EndFunc   ;==>_wait

Func _burpfart()
	$a = Random(0, 1, 1)
	If $a = 0 Then
		SoundPlay("SFX_BURP.wav")
	Else
		SoundPlay("SFX_FART.wav")
	EndIf
;~ 	Return _wait()
EndFunc   ;==>_burpfart
Func _burp()
	SoundPlay("SFX_BURP.wav")
EndFunc   ;==>_burp
Func _fart()
	SoundPlay("SFX_FART.wav")
EndFunc   ;==>_fart

