
Global $Exit = False
$CallBack = DllCallBackRegister("_Callback","bool","int")

ConsoleWrite(DllCallBackGetPtr($CallBack))

Func _CallBack($Int)
	If $Int = 60 Then
		$Exit = True
		Return True
	Else
		Return False
	EndIf
EndFunc

While NOT $Exit
	Sleep(10)
Wend

DllCalLBackFree($CalLBack)

MsgBox(0,"ChildProc","Correct parameter was given! Exiting...")

Exit