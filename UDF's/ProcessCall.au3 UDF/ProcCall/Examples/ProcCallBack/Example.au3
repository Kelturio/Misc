#AutoIt3Wrapper_UseX64=n
#include "..\..\ProcessCall.au3"

#cs
This illustrates how callbacks can be usefull for polling a function many times.
#ce

Global $Child_Proc,$sReturn,$i,$Ptr

$Child_Proc = _RunAu3AsExe(@AutoItExe,@ScriptDir & "\ChildProc.au3","",@WorkingDir,@SW_HIDE,0x2)

While NOT $PTR
	$Ptr = Ptr(StdoutRead($Child_Proc)) ;Get callback address from stdout
WEnd

;We time how long it takes to call the function each time, using proccall
$Time = TimerInit()
For $i = 0 to 40
	$sReturn = ProcCall($Child_Proc,"stdcall",$Ptr,"bool","int",20)
Next
ConsoleWrite("Time taken for a ProcCall: " & (TimerDiff($Time)/40)-0.03 & @CRLF)

;We time how long it takes to call the function each time, using callbacks
$Time = TimerInit()
$CallBack = ProcCallBackRegister($Child_Proc,"stdcall",$Ptr,"bool","int",20)
For $i = 0 to 40
	ProcCallBack($CallBack)
Next
ProcCallBackFree($CallBack)
ConsoleWrite("Time taken for a Callback: " & (TimerDiff($Time)/40)-0.03 & @CRLF)


$sReturn = ProcCall($Child_Proc,"stdcall",$Ptr,"bool","int",60) ;Needed to close other process


Func _RunAu3AsExe($hAutoItExe, $hFileIn, $strParams = "", $sWorkingDir = "", $sShowHide = @SW_HIDE, $nSTDOut = 0);Returns PID of newly spawned exe
    Return Run('"' & $hAutoItExe & '" /AutoIt3ExecuteScript "' & _
                $hFileIn & '"' & $strParams, $sWorkingDir, $sShowHide, $nSTDOut)
EndFunc
