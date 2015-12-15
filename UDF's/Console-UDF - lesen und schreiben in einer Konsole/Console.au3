#cs
	Put the following two lines in your Script to use CMD-Funtions:

	#include <Console.au3>
	; These two lines, if the existing Console should be used, if possible
	#AutoIt3Wrapper_Change2CUI=y
	Global Const $_Console_USEWINDOW = True
	; This line, if always a new Console should be created:
	;~ 		Global Const $_Console_USEWINDOW = False

#ce

#include<WinAPI.au3>
Global $GLOBAL_hConsole, $GLOBAL_hConsoleIn, $CMD_INFINITE = 0xFFFFFFFF
; Initialize the CMD Funcs
; Parameter: [Opt] $ExitOnFatal - If True, The App exits with Fatal error if an error occurs in this Function (Default: False)
; Return values: Success: 1
;                          Error: 0 and @error:
;                                    1 - Could not allocate Console -> no In or outuput-Handle
;                                    2 - GetStdHandle for Output failed -> No Output-Handle, too
;                                    3 - GetStdHandle for Input failed, but we have an Ouput-Handle
;Author: Prog@ndy
Func _Console_STARTUP($ExitOnFatal = 0)
	If Not @Compiled Then
		If Not IsDeclared("_Console_USEWINDOW") Then
			#Region --- CodeWizard generated code Start ---
			;MsgBox features: Title=Yes, Text=Yes, Buttons=Yes and No, Default Button=Second, Icon=Critical
			If 6 = MsgBox(276, "No Console App specified!", "You hav to copy these lines to your main-Script, just before you call _Console_STARTUP:" & @CRLF & "; These two lines, if the CMD-Console should be used, if possible" & @CRLF & "	#AutoIt3Wrapper_Change2CUI=y" & @CRLF & "	Global $_Console_USEWINDOW = True" & @CRLF & "; This line, if always a new Console should be created:" & @CRLF & "	Global $_Console_USEWINDOW = False" & @CRLF & @CRLF & "		COPY TO CLIPBOARD?") Then
				ClipPut("; These two lines, if the CMD-Console should be used, if possible" & @CRLF & _
						"#AutoIt3Wrapper_Change2CUI=y" & @CRLF & _
						"Global Const $_Console_USEWINDOW = True" & @CRLF & _
						"; This line, if always a new Console should be created:" & @CRLF & _
						";~ Global Const $_Console_USEWINDOW = False")
			EndIf
		EndIf
		MsgBox(16, 'Console UDF error', "Console does not work in uncompiled scripts.")
		Exit
	EndIf
	If Not IsDeclared("_Console_USEWINDOW") Then Local $_Console_USEWINDOW = True
	If Not $_Console_USEWINDOW Or ($_Console_USEWINDOW And (Not _WinAPI_AttachConsole())) Then
		$ret = DllCall("Kernel32.dll", "long", "FreeConsole")
		$ret = DllCall("Kernel32.dll", "long", "AllocConsole")
		If $ret = 0 Then
			If $ExitOnFatal Then _WinAPI_FatalAppExit("Could not allocate Console")
			Return SetError(1, 0, 0)
		EndIf
		$HWND = DllCall("kernel32.dll", "hwnd", "GetConsoleWindow")
		WinSetState($HWND[0], "", @SW_SHOW)
	EndIf
	Global $GLOBAL_hConsole = _WinAPI_GetStdHandle(1)
	If $GLOBAL_hConsole = -1 Then
		If $ExitOnFatal Then _WinAPI_FatalAppExit("GetStdHandle for Output failed")
		Return SetError(2, 0, 0)
	EndIf
	DllCall("Kernel32.dll", "long", "SetConsoleActiveScreenBuffer", "handle", $GLOBAL_hConsole)
	Global $GLOBAL_hConsoleIn = _WinAPI_GetStdHandle(0)
	If $GLOBAL_hConsoleIn = -1 Then
		If $ExitOnFatal Then _WinAPI_FatalAppExit("GetStdHandle for Input failed")
		Return SetError(1, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_Console_STARTUP

; PASUES CMD, waits for any key
; Author: ProgAndy
Func _Console_Pause($iTime = -1)
	Local $ret, $Key_Event = False
	_Console_Write("PAUSE: Press any key to continue ")
	DllCall("Kernel32.dll", "long", "FlushConsoleInputBuffer", "handle", $GLOBAL_hConsoleIn)
	Local $tInp = DllStructCreate("long;uint64[4]")
	Do
		$ret = DllCall("Kernel32.dll", "long", "WaitForSingleObject", "handle", $GLOBAL_hConsoleIn, "dword", $iTime)
		If @error Then Return SetError(1, 0, 0)
		If $ret[0] = -1 Then Return SetError(2, 0, 0)
		Local $rce = DllCall("kernel32.dll", "bool", "ReadConsoleInput", "handle", $GLOBAL_hConsoleIn, "ptr", DllStructGetPtr($tInp), "dword", 1, "dword*", 0)
		$Key_Event = DllStructGetData($tInp, 1) = 1
	Until ($Key_Event And $rce[4]) Or $ret[0] = 0x00000102
	DllCall("Kernel32.dll", "long", "FlushConsoleInputBuffer", "handle", $GLOBAL_hConsoleIn)
	Return SetExtended($ret[0] = 0x00000102, 1)
EndFunc   ;==>_Console_Pause

Func _Console_Close()
	Local $ret = DllCall("Kernel32.dll", "int", "FreeConsole")
	If @error Then Return SetError(1, 0, 0)
	Return SetError($ret[0] <> 0, 0, $ret[0])
EndFunc   ;==>_Console_Close

;Writes Text to CMD
; Author: ProgAndy
Func _Console_Write($text)
	Local $temp = _WinAPI_WriteConsole($GLOBAL_hConsole, $text)
	Return SetError(@error, @extended, $temp)
EndFunc   ;==>_Console_Write

;Reads Text from CMD
; Author: ProgAndy
Func _Console_Read($pInputControl = 0)
	Local $tBuffer = DllStructCreate("wchar[4000]")
	Local $aResult = DllCall("Kernel32.dll", "int", "ReadConsoleW", "handle", $GLOBAL_hConsoleIn, "ptr", DllStructGetPtr($tBuffer), "DWORD", 4000, "dword*", 0, "ptr", $pInputControl)
	If @error Then Return SetError(1, @error, "")
	If $aResult[0] = 0 Then Return SetError(2, 0, "")
	Return StringLeft(DllStructGetData($tBuffer, 1), $aResult[4])
EndFunc   ;==>_Console_Read

; Writes the prompt and then reads Text from CMD
; Author: ProgAndy
Func _Console_Ask($sPrompt)
	_Console_Write($sPrompt)
	If @error Then Return SetError(1, @error, "")
	Local $sBuff = _Console_Read()
	If @error Then Return SetError(2, @error, "")
	Return $sBuff
EndFunc   ;==>_Console_Ask