Sleep(999)
Global $t1 = 99, $speed = 3
HotKeySet("{ESC}", "Terminate")

While 42 + 1
	Global $x = 42, $y = 515
	MouseClick("left", $x * 4, 464, 1, $speed)
	Sleep($t1)
	While 42
		$var = PixelGetColor($x, $y)
		If $var = Dec("D4D0C8") Then
			$x = $x + 1
		ElseIf $var = Dec("FFFFFF") Then
			MouseClick("left", $x + 32, $y, 1, $speed)
			Sleep($t1)
			ExitLoop
		Else
			MsgBox(0, "The decmial color is", $var)
			MsgBox(0, "The hex color is", Hex($var, 6))
		EndIf
	WEnd
WEnd

Func Terminate()
	Exit 0
EndFunc   ;==>Terminate