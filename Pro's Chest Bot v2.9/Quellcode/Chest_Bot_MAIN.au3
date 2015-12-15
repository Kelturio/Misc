#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Pro

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <Chest_Bot_GUI.au3>
#include <Date.au3>

$Opened2 = 0

HotKeySet("{F8}", "_exit")

Global $gw = "Guild Wars"
Global $PID = WinGetProcess($gw)
Global $Prcs = _MemoryOpen($PID)
Global $Hwnd1 = WinGetHandle($gw)
Global $timer, $runs, $Status, $Opened

;==============================================================================================>

func RS($min, $max)
	$time = Random($min, $max)
	Sleep($time)
endfunc

Func _exit()
	Exit
EndFunc

;==============================================================================================>

Func GetReady()
	
	If GUICtrlRead($Radio2_GUI)=$GUI_CHECKED Then
		
		$Status = "Prepearing for Fastmode"
		wayout1()
		wayin()		
		
	EndIf
		
EndFunc


Func wayin()
	
	PrepMoveTo()
	
		MoveTo(1,4510+(Random(-5,5)),-27835+(Random(-5,5)))

	KeepMoveTo()
	
	While (_memoryread($memmap,$hprocess)) <> 0
		RS(3000,4100)
	WEnd
	RS(1000,2000)
	
EndFunc

;==============================================================================================>

Func randomwayout()
	
	$Status = "Random normal wayout"
	$wayout = Random(1,3,1)
	If $wayout = 1 Then
		wayout1()
	ElseIf $wayout = 2 Then
		wayout2()
	Else
		wayout3()
	EndIf
	
EndFunc

Func wayout1()
	
	PrepMoveTo()
	
		MoveTo(1, 7748 + (Random(-5, 5)), -27368 + (Random(-5, 5)))
		MoveTo(1, 7378 + (Random(-5, 5)), -27853 + (Random(-5, 5)))
		MoveTo(1, 6899 + (Random(-5, 5)), -27893 + (Random(-5, 5)))
		MoveTo(1, 6568 + (Random(-5, 5)), -27893 + (Random(-5, 5)))
		MoveTo(1, 4901 + (Random(-5, 5)), -27849 + (Random(-5, 5)))
	
	KeepMoveTo()

	While (_memoryread($memmap,$hprocess)) <> 1
		Sleep(500)
	WEnd
	RS(2000,2300)
EndFunc	

Func wayout2()
	
	PrepMoveTo()
		
		MoveTo(1,7215+(Random(-5,5)),-26044+(Random(-5,5)))
		MoveTo(1,6578+(Random(-5,5)),-25916+(Random(-5,5)))
		MoveTo(1,5815+(Random(-5,5)),-26680+(Random(-5,5)))
		MoveTo(1,5732+(Random(-5,5)),-27674+(Random(-5,5)))
		MoveTo(1,5293+(Random(-5,5)),-27979+(Random(-5,5)))
		MoveTo(1,4834+(Random(-5,5)),-27968+(Random(-5,5)))
	
	KeepMoveTo()

	While (_memoryread($memmap,$hprocess)) <> 1
		Sleep(500)
	WEnd
	RS(2000,2300)
	
EndFunc	

Func wayout3()
	
	PrepMoveTo()
	
		MoveTo(1,7741+(Random(-5,5)),-27024+(Random(-5,5)))
		MoveTo(1,7176+(Random(-5,5)),-27553+(Random(-5,5)))
		MoveTo(1,6222+(Random(-5,5)),-28146+(Random(-5,5)))
		MoveTo(1,5360+(Random(-5,5)),-27919+(Random(-5,5)))

	KeepMoveTo()

	While (_memoryread($memmap,$hprocess)) <> 1
		Sleep(500)
	WEnd
	RS(2000,2300)
EndFunc

;==============================================================================================>

Func randomfastwayout()
	
	$Status = "Random fast wayout"
	$fastwayout = Random(1,3,1)
	If $fastwayout = 1 Then
		fastwayout1()
	ElseIf $fastwayout = 2 Then
		fastwayout2()
	Else
		fastwayout3()
	EndIf
	
EndFunc

Func fastwayout1()

RS(500, 1300)
ControlSend($gw, "", "", "{" & $key_reverse & "}")
RS(400, 1200)
ControlSend($gw, "", "", "{" & $key_run & "}")
	While (_memoryread($memmap,$hprocess)) <> 1
		Sleep(500)
	WEnd
	RS(2000,2300)
	
EndFunc

Func fastwayout2()

RS(500, 1300)
	PrepMoveTo()
		MoveTo(1,5295+(Random(-5,5)),-27826+(Random(-5,5)))
		MoveTo(1,5006+(Random(-5,5)),-27825+(Random(-5,5)))
	KeepMoveTo()
		
	While (_memoryread($memmap,$hprocess)) <> 1
		Sleep(500)
	WEnd
	RS(2000,2300)
	
EndFunc

Func fastwayout3()

RS(500, 1300)
	PrepMoveTo()
		MoveTo(1,5177+(Random(-5,5)),-28055+(Random(-5,5)))
		MoveTo(1,4918+(Random(-5,5)),-27978+(Random(-5,5)))
	KeepMoveTo()
		
	While (_memoryread($memmap,$hprocess)) <> 1
		Sleep(500)
	WEnd
	RS(2000,2300)
	
EndFunc


;==============================================================================================>

Func wayout()
	
	If GUICtrlRead($Radio1_GUI)=$GUI_CHECKED Then randomwayout()
	If GUICtrlRead($Radio2_GUI)=$GUI_CHECKED Then randomfastwayout()
	
EndFunc

;==============================================================================================>

Func after()
	
	If GUICtrlRead($Radio2_GUI)=$GUI_CHECKED Then
		
		$Status = "Taking position for Fastmode"	
		PrepMoveTo()
		MoveTo(1,7396+(Random(-5,5)),-27879+(Random(-5,5)))
		MoveTo(1,5549+(Random(-5,5)),-27883+(Random(-5,5)))
		StopMoveTo()
		RS(300, 500)
		ControlSend($gw, "", "", "{" & $key_reverse & "}")
		RS(300,500)
		
	EndIf

EndFunc

;==============================================================================================>

Func deposit()
	
	$Status = "Deposing money at Storage"
	$add = IniRead ("Settings.ini", "Deposit", "$deposit", "NotFound")
	
	If $deposit == 1 and $Run = $deposit_nr_ini then
	$deposit_nr_ini = $deposit_nr_ini + $add
	PrepMoveTo()
	MoveTo(1,7618+(Random(-5,5)),-24240+(Random(-5,5)))
	StopMoveTo()
	RS(500, 600)
	ControlSend($gw, "", "", "{" & $key_ally & "}")
	RS(500, 600)
	ControlSend($gw, "", "", "{" & $key_attack & "}")
	RS(1000, 1200)
	ControlClick($gw, "", "", "left", 1, 500, 204)
	RS(500, 600)
	ControlClick($gw, "", "", "left", 1, 292, 217)
	RS(500, 600)
	ControlClick($gw, "", "", "left", 1, 247, 243)
	RS(500, 600)
	ControlSend($gw, "", "", "{ESC}")
	RS(500, 600)
	If GUICtrlRead($Radio2_GUI)=$GUI_CHECKED Then after()
	EndIf

EndFunc

;==============================================================================================>

Func Stoptimes()
	
	If $Stop == 1 and $Opened >= $stoptimes_ini then _exit()
		
EndFunc

;==============================================================================================>

Func Chest()
	
	ControlSend($gw, "", "", "{" & $key_item & "}")
	RS(200,300)
	$sel = _memoryread($memnpcidselect,$hprocess)
	If $sel > 0 Then
		$Status = "Opening chest"
		StopmoveTo()
		ControlSend($gw, "", "", "{" & $key_runskill & "}")
		RS(100, 200)
		ControlSend($gw, "", "", "{" & $key_attack & "}")
		RS(15000,15500)
		$Opened = $Opened + 1
		$Opened2 = $Opened2 + 1
		$runtimes = $runtimes - 1
		ControlSetText($bot_title, "", $Opened_Chests, $Opened)
		ControlSetText($bot_title, "", $Label_RunsLeft, $runtimes)
		RS(100, 200)
		ControlClick($gw, "", "", "left", 1, 286, 240)
		RS(2500,3500)
		ControlSend($gw, "", "", "{" & $key_item & "}")
		RS(250,300)
		ControlSend($gw, "", "", "{" & $key_attack & "}")
		RS(800,1000)
		controlsend($gw, "", "", "{" & $key_strafeleft & " down}")
		RS(1500,2000)
		controlsend($gw, "", "", "{" & $key_strafeleft & " up}")
		$Status = "Random Chestrun"
	EndIf
	
EndFunc

Func ChestLast()
	
	ControlSend($gw, "", "", "{" & $key_item & "}")
	RS(200,300)
	$sel = _memoryread($memnpcidselect,$hprocess)
	If $sel > 0 Then
		$Status = "Opening chest"
		ControlSend($gw, "", "", "{" & $key_runskill & "}")
		RS(100, 200)
		ControlSend($gw, "", "", "{" & $key_attack & "}")
		RS(15000,15500)
		$Opened = $Opened + 1
		$Opened2 = $Opened2 + 1
		$runtimes = $runtimes - 1
		ControlSetText($bot_title, "", $Opened_Chests, $Opened)
		ControlSetText($bot_title, "", $Label_RunsLeft, $runtimes)
		RS(100, 200)
		ControlClick($gw, "", "", "left", 1, 286, 240)
		RS(2500,3500)
		ControlSend($gw, "", "", "{" & $key_item & "}")
		RS(250,300)
		ControlSend($gw, "", "", "{" & $key_attack & "}")
		RS(800,1000)
		$Status = "Random Chestrun"
	EndIf
	
EndFunc


Func randomchestrun()
	
	$Status = "Random Chestrun"
	$chestrun = Random(1,3,1)
	If $chestrun = 1 Then
		randomchestrun1()
	ElseIf $chestrun = 2 Then
		randomchestrun2()
	Else
		randomchestrun3()
	EndIf
	
EndFunc


Func randomchestrun1()
	
	$timer2 = TimerDiff($timer)
	SetRun()	
	PrepMoveTo()
	MoveTo(1, 3526 + (Random(-5, 5)), -26956 + (Random(-5, 5)))
	MoveTo(1, 2800 + (Random(-5, 5)), -25494 + (Random(-5, 5)))
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	MoveTo(1, 3185 + (Random(-5, 5)), -24549 + (Random(-5, 5)))
	MoveTo(1, 3954 + (Random(-5, 5)), -23703 + (Random(-5, 5)))
	MoveTo(1, 3985 + (Random(-5, 5)), -23075 + (Random(-5, 5)))
	MoveTo(1, 3604 + (Random(-5, 5)), -22764 + (Random(-5, 5)))
	MoveTo(1, 1447 + (Random(-5, 5)), -21321 + (Random(-5, 5)))
	RS(200,250)
	Chest()
	PrepMoveTo()
	MoveTo(1, -383 + (Random(-5, 5)), -20068 + (Random(-5, 5)))
	MoveTo(1, -1912 + (Random(-5, 5)), -18994 + (Random(-5, 5)))
	MoveTo(1, -2820 + (Random(-5, 5)), -18843 + (Random(-5, 5)))
	MoveTo(1, -3324 + (Random(-5, 5)), -18064 + (Random(-5, 5)))
	RS(200,500)
	Chest()
	PrepMoveTo()
	MoveTo(1, -5297 + (Random(-5, 5)), -14335 + (Random(-5, 5)))
	MoveTo(1, -5687 + (Random(-5, 5)), -12758 + (Random(-5, 5)))
	MoveTo(1, -5645 + (Random(-5, 5)), -11404 + (Random(-5, 5)))
	StopMoveTo()
	RS(200,320)
	ChestLast()
	randomsign()
	$timer2 = TimerDiff($timer)
	average()
	
EndFunc


Func randomchestrun2()
	
	$timer2 = TimerDiff($timer)
	SetRun()
	RS(300,500)
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	PrepMoveTo()
	MoveTo(1,2797+(Random(-5,5)),-25578+(Random(-5,5)))
	MoveTo(1,3095+(Random(-5,5)),-24458+(Random(-5,5)))
	MoveTo(1,3809+(Random(-5,5)),-23619+(Random(-5,5)))
	MoveTo(1,3359+(Random(-5,5)),-22594+(Random(-5,5)))
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	MoveTo(1,-1308+(Random(-5,5)),-19543+(Random(-5,5)))
	MoveTo(1,-3217+(Random(-5,5)),-18306+(Random(-5,5)))
	RS(200,250)
	Chest()
	PrepMoveto()
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	MoveTo(1,-5371+(Random(-5,5)),-14319+(Random(-5,5)))
	StopMoveTo()
	RS(200, 500)
	ChestLast()	
	randomsign()
	$timer2 = TimerDiff($timer)
	average()
	
EndFunc


Func randomchestrun3()
	
	$timer2 = TimerDiff($timer)
	SetRun()
	RS(300,500)
	PrepMoveTo()
	MoveTo(1,2845+(Random(-5,5)),-25721+(Random(-5,5)))
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	MoveTo(1,3024+(Random(-5,5)),-24608+(Random(-5,5)))
	MoveTo(1,3853+(Random(-5,5)),-23199+(Random(-5,5)))
	MoveTo(1,2944+(Random(-5,5)),-21870+(Random(-5,5)))
	MoveTo(1,-922+(Random(-5,5)),-19837+(Random(-5,5)))
	MoveTo(1,-3243+(Random(-5,5)),-18261+(Random(-5,5)))
	RS(200,250)
	Chest()
	PrepMoveto()
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	MoveTo(1,-5508+(Random(-5,5)),-14445+(Random(-5,5)))
	StopMoveTo()
	ChestLast()
	RS(500,590)		
	randomsign()
	$timer2 = TimerDiff($timer)
	average()
	
EndFunc



;==============================================================================================>

Func Solve()
	
	wayout()
	$timer2 = TimerDiff($timer)
	PrepMoveTo()
	MoveTo(1, 3526 + (Random(-5, 5)), -26956 + (Random(-5, 5)))
	MoveTo(1, 2800 + (Random(-5, 5)), -25494 + (Random(-5, 5)))
	ControlSend($gw, "", "", "{" & $key_runskill & "}")
	MoveTo(1, 3185 + (Random(-5, 5)), -24549 + (Random(-5, 5)))
	MoveTo(1, 3954 + (Random(-5, 5)), -23703 + (Random(-5, 5)))
	MoveTo(1, 3985 + (Random(-5, 5)), -23075 + (Random(-5, 5)))
	MoveTo(1, 3604 + (Random(-5, 5)), -22764 + (Random(-5, 5)))
	MoveTo(1, 1447 + (Random(-5, 5)), -21321 + (Random(-5, 5)))
	MoveTo(1, -383 + (Random(-5, 5)), -20068 + (Random(-5, 5)))
	MoveTo(1, -1912 + (Random(-5, 5)), -18994 + (Random(-5, 5)))
	MoveTo(1, -2820 + (Random(-5, 5)), -18843 + (Random(-5, 5)))
	MoveTo(1, -3324 + (Random(-5, 5)), -18064 + (Random(-5, 5)))
	MoveTo(1, -4697 + (Random(-5, 5)), -16983 + (Random(-5, 5)))
	MoveTo(1, -5255 + (Random(-5, 5)), -16515 + (Random(-5, 5)))
	MoveTo(1, -5297 + (Random(-5, 5)), -14335 + (Random(-5, 5)))	
	ControlSetText($bot_title, "", $stuck_progress, "running")
	
EndFunc
	
;==============================================================================================>

Func randomsign()
	$Status = "Resigning"
	If $run = 1 then 
		Resign()
	Else
		giveup()
	EndIf
	
EndFunc

Func giveup()
	$Status = "Resigning"
	ControlSend($gw, "", "", "{ESC}")
	RS(500,1000)
	ControlSend($gw, "", "", "{" & $key_enter & "}")
	RS(200,1000)
	ControlSend($gw, "", "", "{up}")
	RS(90,100)
	ControlSend($gw, "", "", "{" & $key_enter & "}")
	RS(4000,4600)
	ControlClick($gw, "", "", "left", 1, 310, 223)
	RS(4000,5000)
	While (_memoryread($memmap,$hprocess)) <> 0
		RS(3000,4100)
	WEnd
	RS(1000,2000)
	
EndFunc

;==============================================================================================>

Func ident()
	$Status = "Identifying Items"
ControlSend($gw, "", "", "{" & $key_inventory & "}")
	RS(500,800)
		IdentItems(0, 3, 0, 0)
	RS(500,800)
ControlSend($gw, "", "", "{" & $key_inventory & "}")
	RS(500,800)
	
EndFunc


;==============================================================================================>

func sell()
	$Status = "Selling Items"
	RS(1000,1100)
	PrepMoveTo()
	MoveTo(1, 7363 + (Random(-5, 5)), -24941 + (Random(-5, 5)))
	StopMoveTo()
	ControlSend($gw, "", "", "{" & $key_ally & "}")
	RS(550,650)
	ControlSend($gw, "", "", "{" & $key_attack & "}")
	RS(1000,1100)
	ControlClick($gw, "", "", "left", 1, 70, 30)
	RS(500,750)
	for $i = 1 to ($runs + 1)
		RS(600, 700)
		ControlClick($client, "", "", "left", 1, 199, 386)
	next
	$Status = "Buying Ident-kit"
	RS(3000,3300)
	ControlClick($gw, "", "", "left", 1, 31, 31)
	RS(1000,1200)
	ControlClick($gw, "", "", "left", 1, 62, 174)
	RS(1000,1200)
	ControlClick($gw, "", "", "left", 1, 195, 387)
	RS(1400,2000)
	ControlSend($gw, "", "", "{ESC}")
EndFunc

;==============================================================================================>

Func stuck()
	RS(1000,2000)
	$timer = TimerInit()
	AdlibEnable("Check", 1000)

EndFunc

Func Check()
	
	ControlSetText($bot_title, "", $stuck_progress, $Status)

	_TicksToTime(Int(TimerDiff($timer)), $Hour, $Mins, $Secs)
	Local $sTime = $Time
	$Time = StringFormat("%02i:%02i:%02i", $Hour, $Mins, $Secs)
	If $sTime <> $Time Then ControlSetText($bot_title, "", $RunningTime, $Time)	
	GUICtrlSetState($Statistics, $GUI_SHOW)
	
	If TimerDiff($timer) - $timer2 > 3 * 1000 * 60 Then
		$stuck = $stuck + 1
		ControlSetText($bot_title, "", $Got_stuck, $stuck)
		ControlSetText($bot_title, "", $stuck_progress, "Anti-Stuck function is solving")
		GUICtrlSetState($Statistics, $GUI_SHOW)
		RS(200,300)
		StopMoveTo()
		RS(200,400)
		randomsign()
		RS(200,400)
		solve()
	EndIf
	
EndFunc

Func Average()
	
	_TicksToTime(Int(TimerDiff($timer) / $Run), $Hour2, $Mins2, $Secs2)
	Local $bTime = $aTime
	$aTime = StringFormat("%02i:%02i:%02i", $Hour2, $Mins2, $Secs2)
	If $bTime <> $aTime Then ControlSetText($bot_title, "", $average, $aTime)
	RS(1000,1400)
	
EndFunc

;==============================================================================================>

Func main()
	stuck()
	fit()
	GetReady()
	while 1		
		$runs = $runtimes
			while $Opened2 < $runs
				wayout()
				randomchestrun()
				deposit()
				stoptimes()
			WEnd
				$Opened2 = 0
					If $identsellitems == 1 Then 
						ident()
						sell()
					Endif
				$runtimes = IniRead ("Settings.ini", "Run Management", "$runtimes", "NotFound")
		after()
	WEnd
EndFunc

main()
