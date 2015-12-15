#cs ----------------------------------------------------------------------------
 Author:			Searinox
 Script Function:	ProcessLagger
#ce ----------------------------------------------------------------------------
#include <array.au3>

HotKeySet("{PAUSE}", "resume")	;hotkey zum closen der laufenden LCUs + resume

Local $name[1] = [0]			;bildnamen aus der processlist
Local $pid[1] = [0]				;PIDs aus der processlist
Local $location[1] = [0]		;bildpfade aus der ProcessGetLocation
Local $pidresume[1] = [0]		;PIDs die vor exit fortgesetzt werden müssen
Local $t1 = 99					;timer1 für die wartezeit zwischen den shellexecutes
Local $t2 = 444					;timer2 für die wartezeit zwischen den processkills
Local $downtime = InputBox("Downtime", "Process-Downtime zwischen 0-100ms", "", " M3")	;die haltezeit von 0-100ms!

Local $list = ProcessList()			;erstellt ein array mit namen und PIDs
For $i = 1 to UBound($list) - 1	;die drei arrays werden gefüllt
	_ArrayAdd( $name, $list[$i][0])							;namen hinzufügen
	_ArrayAdd( $pid, $list[$i][1])							;PIDs hinzufügen
	_ArrayAdd( $location, _ProcessGetLocation($pid[$i]))	;bildpfade hinzufügen
Next

For $i = 1 to UBound($list) - 1	;LCU startparameter und run. . .
	If StringRight( $location[$i], 4) = ".exe" Then		;prüft rechten 4 zeichen auf .exe
		_ArrayAdd( $pidresume, $pid[$i])				;fügt die fortzusetzenden PIDs hinzu
		$runparameter =  """" & $location[$i] & """"	;teil des parameterstrings
		ShellExecute("LCU.EXE", $runparameter & " " & $downtime  & " " & "-h", @ScriptDir, "open")	;fügt den rest an parametern hinzu und startet
		Sleep($t1)
	EndIf		
Next

While 1							;while damit der script läuft
	Sleep(60 * 1000)
WEnd

Func resume()					;func zum LCUs clossen + prozesse fortsetzen + exit
	For $i = 1 to UBound($pidresume) - 1		;die LCUs werden geclosed
		$PIDk = ProcessExists("LCU.exe")	;PID aus namen bekommen
		If $PIDk Then ProcessClose($PIDk)	;killen per PID
		Sleep($t1)
	Next
	For $i = 1 to UBound($pidresume) - 1		;prozesse werden fortgesetzt
		_ProcessResume($pidresume[$i])		;resume durch PID
		If @error Then MsgBox(4096,"Error", "Error bei _ProcessResume")
	Next
	Exit
EndFunc

Func _ProcessGetLocation($iPID)	;func für bildpfad
    Local $aProc = DllCall('kernel32.dll', 'hwnd', 'OpenProcess', 'int', BitOR(0x0400, 0x0010), 'int', 0, 'int', $iPID)
    If $aProc[0] = 0 Then Return SetError(1, 0, '')
    Local $vStruct = DllStructCreate('int[1024]')
    DllCall('psapi.dll', 'int', 'EnumProcessModules', 'hwnd', $aProc[0], 'ptr', DllStructGetPtr($vStruct), 'int', DllStructGetSize($vStruct), 'int_ptr', 0)
    Local $aReturn = DllCall('psapi.dll', 'int', 'GetModuleFileNameEx', 'hwnd', $aProc[0], 'int', DllStructGetData($vStruct, 1), 'str', '', 'int', 2048)
    If StringLen($aReturn[3]) = 0 Then Return SetError(2, 0, '')
    Return $aReturn[3]
EndFunc

Func _ProcessSuspend($process)	;func um prozess anzuhalten
$processid = ProcessExists($process)
If $processid Then
    $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $processid)
    $i_sucess = DllCall("ntdll.dll","int","NtSuspendProcess","int",$ai_Handle[0])
    DllCall('kernel32.dll', 'ptr', 'CloseHandle', 'ptr', $ai_Handle)
    If IsArray($i_sucess) Then 
        Return 1
    Else
        SetError(1)
        Return 0
    Endif
Else
    SetError(2)
    Return 0
Endif
EndFunc

Func _ProcessResume($process)	;func um prozess fortzusetzen
$processid = ProcessExists($process)
If $processid Then
    $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $processid)
    $i_sucess = DllCall("ntdll.dll","int","NtResumeProcess","int",$ai_Handle[0])
    DllCall('kernel32.dll', 'ptr', 'CloseHandle', 'ptr', $ai_Handle)
    If IsArray($i_sucess) Then 
        Return 1
    Else
        SetError(1)
        Return 0
    Endif
Else
    SetError(2)
    Return 0
Endif
EndFunc
