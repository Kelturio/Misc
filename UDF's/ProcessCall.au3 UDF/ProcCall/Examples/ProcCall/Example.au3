#AutoIt3Wrapper_UseX64=n
#include "..\..\ProcessCall.au3"

#cs
This example spawns a new process which sends back a pointer to a callback function.
This process keeps calling the callback in the other function untill it returns true.
#ce

Global $Child_Proc,$sReturn,$i,$Ptr

$Child_Proc = _RunAu3AsExe(@AutoItExe,@ScriptDir & "\ChildProc.au3","",@WorkingDir,@SW_HIDE,0x2)

While NOT $PTR
	$Ptr = Ptr(StdoutRead($Child_Proc)) ;Get callback address from stdout
WEnd


For $i = 0 to 80 step 10
	$sReturn = ProcCall($Child_Proc,"stdcall",$Ptr,"bool","int",$i)
	ConsoleWrite("Calling with parameter " & $i & ". Succes = " & $sReturn & "." & @CRLF)
	If $sReturn Then ExitLoop
Next


Msgbox(0,"Example",$i & " was the correct parameter!")


Func _RunAu3AsExe($hAutoItExe, $hFileIn, $strParams = "", $sWorkingDir = "", $sShowHide = @SW_HIDE, $nSTDOut = 0);Returns PID of newly spawned exe
    Return Run('"' & $hAutoItExe & '" /AutoIt3ExecuteScript "' & _
                $hFileIn & '"' & $strParams, $sWorkingDir, $sShowHide, $nSTDOut)
EndFunc
