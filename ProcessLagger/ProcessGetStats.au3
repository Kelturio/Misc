#cs ----------------------------------------------------------------------------
 Author:			Searinox
 Script Function:	ProcessLagger
#ce ----------------------------------------------------------------------------

#include <array.au3>

Local $name[1] = [0]			;bildnamen aus der processlist
Local $pid[1] = [0]				;PIDs aus der processlist
Local $location[1] = [0]		;bildpfade aus der ProcessGetLocation
Local $pidresume[1] = [0]		;PIDs die vor exit fortgesetzt werden müssen
Local $downtime = 28			;die haltezeit von 0-100ms!
Local $t1 = 99					;timer1 für die wartezeit zwischen den shellexecutes
Local $t2 = 444					;timer2 für die wartezeit zwischen den processkills
HotKeySet("{PAUSE}", "resume")	;hotkey zum closen der laufenden LCUs + resume

$list = ProcessList()			;erstellt ein array mit namen und PIDs
For $i = 1 to $list[0][0]		;die drei arrays werden gefüllt
	_ArrayDisplay($list, "$myArray")
	$akk = UBound($list)
	MsgBox(4096,"ubound", $akk)
	MsgBox(4096,"list0", $list[0][0])
	_ArrayAdd( $name, $list[$i][0])							;namen hinzufügen
	_ArrayAdd( $pid, $list[$i][1])							;PIDs hinzufügen
	_ArrayAdd( $location, _ProcessGetLocation($pid[$i]))	;bildpfade hinzufügen
Next

For $i = 1 to UBound($list) - 1		;LCUs werden in dieser for gestartet. . .
;~ For $i = 1 to $list[0][0]		;LCUs werden in dieser for gestartet. . .
;~ 	$akk = UBound($list)
;~ 	MsgBox(4096,"ubound", $akk)
;~ 	MsgBox(4096,"list0", $list[0][0])
	$checkexe = StringRight( $location[$i], 4)			;schreibt die rechten vier zeichen des bildpfades in checkexe
	If $checkexe = ".exe" Then
		$pidresume[0] = $pidresume[0] + 1				;zähler für arrayelemente
		_ArrayAdd( $pidresume, $pid[$i])				;fügt die fortzusetzenden PIDs hinzu
		$runparameter =  """" & $location[$i] & """"	;teil des parameterstrings
		ShellExecute("LCU.EXE", $runparameter & " " & $downtime  & " " & "-h", @ScriptDir, "open")	;fügt den rest an parametern hinzu und startet
		Sleep($t1)
	Else
	EndIf		
Next

While 1							;while damit der script läuft
	Sleep(60 * 1000)
WEnd

Func resume()					;LCUs werden geclosed und prozesse werden fortgesetzt
	For $i = 1 to $pidresume[0]	;die LCUs werden geclosed
		$PIDk = ProcessExists("LCU.exe")	;PID aus namen bekommen
		If $PIDk Then ProcessClose($PIDk)	;killen per PID
		Sleep($t1)
	Next
;~ 	_ArrayDisplay($pidresume, "$pidresume")
	For $i = 1 to $pidresume[0]	;prozesse werden fortgesetzt
		_ProcessResume($pidresume[$i])	;resume durch PID
		If @error Then
			MsgBox(4096,"Error", "Error bei _ProcessResume")
		Else
;~ 			MsgBox(4096, "Else", "Else")
		EndIf
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
