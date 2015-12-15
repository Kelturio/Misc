;Examples of DllCallEx

;This is ofcourse only really usefull if you have your own dll without exported functions or something similar.
#AutoIt3Wrapper_UseX64=n
#include "..\..\ProcessCall.au3"

;Example 1 - calling a callback
$Function = DllCallBackRegister("_CallBack","bool","int")
$Pointer = DllCallBackGetPtr($Function)
;We created our own function _CallBack and call it now first with parameter 5, and then 6. Output should be 0 and 1
$iRet = DllCallEx($Pointer,"bool","int",5)
ConsoleWrite($iRet & @CRLF)
$iRet = DllCallEx($Pointer,"bool","int",6)
ConsoleWrite($iRet & @CRLF)

;Example 2 - Calling a function from address
$Pointer = _GetProcAddress(_WinApi_GetModuleHandle("User32.dll"),"MessageBoxA")
;Now we call Msgbox from its address in memory. Output should be 1 if user presses ok.
$iRet = DllCallEx($Pointer,"int","hwnd",0,"char*","Text goes here","char*","Title goes here","dword",0)
ConsoleWrite($iRet & @CRLF)

;Example 3 - calling own asm
$Opcode = 	"0x" & _
			"B8" & _SwapEndian(1337) & _ ;MOV EAX, 1337
			"C3"						 ;RETN

$Struct = DllStructCreate("byte[50]")
DllStructSetData($Struct,1,$Opcode)
$Pointer = DllStructGetPtr($Struct)

$iRet = DllCallEx($Pointer,"dword")
ConsoleWrite($iRet & @CRLF)


Func _CallBack($Int)
	If $Int > 5 Then Return True
	Return False
EndFunc