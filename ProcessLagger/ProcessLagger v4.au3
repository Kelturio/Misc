#cs ----------------------------------------------------------------------------
 Author:			Searinox
 Script Function:	ProcessLagger
#ce ----------------------------------------------------------------------------
Opt("OnExitFunc", "resume")
Opt("TrayAutoPause",0)          ;0=no pause, 1=Pause
Opt("TrayIconDebug", 1)         ;0=no info, 1=debug line info
Opt("TrayIconHide", 0)          ;0=show, 1=hide tray icon
#include <array.au3>

HotKeySet("{PAUSE}", "resume")	;hotkey zum closen der laufenden LCUs + resume

Local $pidresume[1] = [0]		;PIDs die vor exit fortgesetzt werden müssen
Local $t1 = 99					;timer1 für die wartezeit zwischen den shellexecutes
Local $t2 = 444					;timer2 für die wartezeit zwischen den processkills
Local $downtime = InputBox("Downtime", "Process-Downtime zwischen 0-100ms", "", " M3")	;die haltezeit von 0-100ms!

Local $list = ProcessList()		;erstellt ein array mit namen und PIDs
ReDim $list[UBound($list)][3]	;dritte spalte hinzufügen
$list[0][0] = "Bildname"
$list[0][1] = "PID"
$list[0][2] = "Location"
For $i = 1 to UBound($list) - 1	;bildpfade in dritte spalte
	$list[$i][2] = _ProcessGetLocation($list[$i][1])
Next
_ArrayDisplay($list, "$list")
For $i = 1 to UBound($list) - 1	;LCU startparameter und run. . .
	If StringRight( $list[$i][2], 4) = ".exe" Then		;prüft rechten 4 zeichen auf .exe
		_ArrayAdd( $pidresume, $list[$i][1])			;fügt die fortzusetzenden PIDs hinzu
		$runparameter =  """" & $list[$i][2] & """"		;teil des parameterstrings
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
