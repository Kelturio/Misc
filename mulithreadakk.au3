$handle = DllCallbackRegister("_Threadstart","int","ptr")

; Struct to send to the Thread
$dll = DllStructCreate("Char[200];int")
DllStructSetData($dll,1,"hi")
DllStructSetData($dll,2,1234)


$ret = DllCall("kernel32.dll","hwnd","CreateThread","ptr",0,"dword",0,"long",DllCallbackGetPtr($handle),"ptr",DllStructGetPtr($dll),"long",0,"int*",0)
MsgBox(0, "Thread-Info", "Handle: " & $ret[0] & @CRLF & "Thread-ID: " & $ret[6])

Func _ThreadStart($x)
    For $i = 1 To 10
        ConsoleWrite("Thread 1 !!!"&@LF)
        Sleep(100)
    Next

    $y = DllStructCreate("char[200];int",$x)
    MsgBox(0, "Thread 1", DllStructGetData($y,1) & @CRLF & DllStructGetData($y,2)&@CRLF &"AutoIt can Multithreading !!!")
EndFunc