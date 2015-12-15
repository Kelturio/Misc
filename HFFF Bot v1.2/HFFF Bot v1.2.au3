#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         MasteR GunneR

 Script Function:
	HFFF.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

HotKeySet("{NUMPADSUB}","_decreasemousespeed")
HotKeySet("{NUMPADADD}", "_increasemousespeed")
HotKeySet("^{NUMPADSUB}","_decreasedelayreward")
HotKeySet("^{NUMPADADD}", "_increasedelayreward")
HotKeySet("!{NUMPADSUB}","_decreasedelayrecovery")
HotKeySet("!{NUMPADADD}", "_increasedelayrecovery")
HotKeySet("{END}","_exitit")
HotKeySet("{PAUSE}", "_TogglePause")
HotKeySet("{HOME}", "_startrun")

traytip("elitepvpers.com","Your best is our worst!"&@crlf&"It's all for free!"&@crlf&"Just join and get all the latest hacks/bots/exploits!"&@crlf&""&@crlf&"www.elitepvpers.com",11,1)
SplashImageOn("http://www.elitepvpers.de/","logo.gif" , 243, 252, -1, -1, 17)
Sleep(5000)
SplashOff() 

Global $emotes = IniRead("settings.ini", "misc", "$emotes", "NotFound")
Global $npcs = IniRead("settings.ini", "$run", "$run", "NotFound")
Global $mousespeed = IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound")
Global $delayreward = IniRead("settings.ini", "$delay", "$delayreward", "NotFound")
Global $delayrecovery = IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound")
Global $Paused
Global $faction = InputBox("Faction", "Enter ""1"" in the box below to gain [KURZICK] faction points or enter ""2"" to gain [LUXON] faction points!" , "Insert here!")
Global $mode = InputBox("Mode", "Enter ""1"" in the box below to use [AUTOMATIC] mode or enter ""2"" to use [SEMI-AUTOMATIC] mode!" , "Insert here!")
If $mode = 1 Then
Global $exchange = InputBox("Exchange", "Enter ""1"" in the box below to boost your alliance's faction or enter ""2"" to get Amber Chunks / Jadeite Shards!" , "Insert here!")
EndIf

If $mode = 1 Then
Select
	Case $exchange = 1
	Global $name = InputBox("Name", "Please enter your character's name in the box below!" , "Insert here!")
	Case $exchange = 2
	Sleep(0)
	Case Else
	MsgBox(0, "D'OH!", "Try again ...")
	_exitit()
EndSelect
EndIf

If $mode = 1 Then
Global $break = MsgBox(36, "Break", "Do you want to activate the ""Break"" function (recommended)?")
Global $shutdown = MsgBox(36, "Shutdown", "Do you want to shutdown your system at a specific time?")
EndIf

Global $countercheck = 100
Global $counter = 0
Global $gonewrongcounter = 0
Global $gonewrongcountercheck = 1

If $mode = 1 Then
Select
	Case $shutdown = 6
	Global $hour = InputBox("Time", "I want to shutdown my system at [TIME] (24-hour clock: 5am = ""5"" ; 7pm = ""19"" and so on ...). BASED ON YOUR SYSTEM'S CLOCK!" , "Insert [TIME] here!")
	Case $shutdown = 7
	Global $hour = "NO SHUTDOWN"
EndSelect
EndIf

Func _increasemousespeed()
	$current = IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound")
	IniWrite("settings.ini", "$mousespeed", "$mousespeed", $current + 0.25)
	ToolTip("$mousespeed was set to:" & @CRLF & IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound"),0,0)
	Global $mousespeed = IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound")
EndFunc

Func _decreasemousespeed()
	$current = IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound")
	IniWrite("settings.ini", "$mousespeed", "$mousespeed", $current - 0.25)
	ToolTip("$mousespeed was set to:" & @CRLF & IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound"),0,0)
	Global $mousespeed = IniRead("settings.ini", "$mousespeed", "$mousespeed", "NotFound")
EndFunc

Func _increasedelayreward()
	$current = IniRead("settings.ini", "$delay", "$delayreward", "NotFound")
	IniWrite("settings.ini", "$delay", "$delayreward", $current + 1000)
	ToolTip("$delayreward was set to:" & @CRLF & IniRead("settings.ini", "$delay", "$delayreward", "NotFound"),0,0)
	Global $delayreward = IniRead("settings.ini", "$delay", "$delayreward", "NotFound")
EndFunc

Func _decreasedelayreward()
	$current = IniRead("settings.ini", "$delay", "$delayreward", "NotFound")
	IniWrite("settings.ini", "$delay", "$delayreward", $current - 1000)
	ToolTip("$delayreward was set to:" & @CRLF & IniRead("settings.ini", "$delay", "$delayreward", "NotFound"),0,0)
	Global $delayreward = IniRead("settings.ini", "$delay", "$delayreward", "NotFound")
EndFunc

Func _increasedelayrecovery()
	$current = IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound")
	IniWrite("settings.ini", "$delay", "$delayrecovery", $current + 1000)
	ToolTip("$delayrecovery was set to:" & @CRLF & IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound"),0,0)
	Global $delayrecovery = IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound")
EndFunc

Func _decreasedelayrecovery()
	$current = IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound")
	IniWrite("settings.ini", "$delay", "$delayrecovery", $current - 1000)
	ToolTip("$delayrecovery was set to:" & @CRLF & IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound"),0,0)
	Global $delayrecovery = IniRead("settings.ini", "$delay", "$delayrecovery", "NotFound")
EndFunc

Func _exitit()
exit 0
EndFunc

Func _TogglePause()
    $Paused = NOT $Paused
    While $Paused
        Sleep(100)
		ToolTip("Script is 'Paused'" & @CRLF & @CRLF & "$mousespeed is:" & @CRLF & $mousespeed & @CRLF & @CRLF & "$delayreward is:" & @CRLF & $delayreward & @CRLF & @CRLF & "$delayrecovery is:" & @CRLF & $delayrecovery,0,0)
    WEnd
    ToolTip("Script is running")
		If Not WinActivate("Guild Wars") Then
			WinActivate("Guild Wars")
		EndIf
		Sleep(2000)
EndFunc

Func _travelcheck1kurzick()	
	$travelcheck1 = Hex(PixelGetColor(640, 512),6)
	Select
		Case $travelcheck1 <> "FF0000" And $counter <> $countercheck And $gonewrongcounter <> $gonewrongcountercheck
			Sleep(200)
			$counter = $counter + 1
			_travelcheck1kurzick();
		Case $travelcheck1 <> "FF0000" And $counter <> $countercheck And $gonewrongcounter = $gonewrongcountercheck	
			Sleep(200)
			$counter = $counter + 1
			_travelcheck1kurzick();			
		Case $travelcheck1 = "FF0000" And $counter <> $countercheck And $gonewrongcounter <> $gonewrongcountercheck
			$counter = 0
			_travelcheck2kurzick();		
		Case $travelcheck1 = "FF0000" And $counter <> $countercheck And $gonewrongcounter = $gonewrongcountercheck
			$counter = 0
			_travelcheck2kurzick();				
		Case $counter = $countercheck And $gonewrongcounter <> $gonewrongcountercheck
			$gonewrongcounter = $gonewrongcounter + 1
			$counter = 0
			_checkkurzick();
		Case $counter = $countercheck And $gonewrongcounter = $gonewrongcountercheck
			$gonewrongcounter = 0
			$counter = 0
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)				
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			MouseClick("left", Random(299, 414), Random(62, 75), 1, $mousespeed)	
			Sleep(15000 + $delayrecovery)
			Send("m")
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(734, 744), Random(744, 754), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			Send("{Space}")
			Sleep(15000 + $delayrecovery)
			Send("m")
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)			
			MouseClickDrag("right", Random(720, 725), Random(185, 190), Random(1020, 1025), Random(485, 490), $mousespeed)
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(361, 371), Random(381, 391), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(475, 525), Random(481, 483), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			Send("{Space}")
			Sleep(15000 + $delayrecovery)
			Send("m")
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(100, 200), Random(100, 200), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)	
			MouseClick("left", 830, 681, 1, $mousespeed)					
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)	
			MouseClick("left", Random(624, 634), Random(551, 561), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			Send("{Space}")	
			Sleep(15000 + $delayrecovery)
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)			
			Send("u")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(200, 400)
			MouseClick("left", Random(114, 179), Random(144, 154), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$a = Random(35, 661)
			$bb = IniRead("settings.ini", "$heroes", "$sousuke", "NotFound")
			$b = Random($bb - 5, $bb + 5)
			MouseClick("left", $a, $b, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $a, $b, 1, $mousespeed)	
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$c = Random(35, 661)
			$dd = IniRead("settings.ini", "$heroes", "$zhed", "NotFound")
			$d = Random($dd - 5, $dd + 5)
			MouseClick("left", $c, $d, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $c, $d, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$e = Random(35, 661)
			$ff = IniRead("settings.ini", "$heroes", "$vekk", "NotFound")
			$f = Random($ff - 5, $ff + 5)
			MouseClick("left", $e, $f, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $e, $f, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			MouseClick("left", Random(198, 295), Random(147, 157), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$g = Random(35, 661)
			$h = Random(327, 337)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$i = Random(35, 661)
			$j = Random(411, 421)
			MouseClick("left", $i, $j, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $i, $j, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$k = Random(35, 661)
			$l = Random(495, 505)
			MouseClick("left", $k, $l, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $k, $l, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("p")	
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			_runkurzick();
	EndSelect
EndFunc	
		
Func _travelcheck2kurzick()
	$travelcheck2 = Hex(PixelGetColor(640, 512),6)
	If $travelcheck2 = "FF0000" Then
		Sleep(200)
		_travelcheck2kurzick();
	ElseIf $travelcheck2 <> "FF0000" Then
		$rndnumber = Random(4500, 5000)
		Sleep($rndnumber)	
		$gonewrongcounter = 0
		$counter = 0
	EndIf
EndFunc	

Func _runkurzick()
	$rndnumber = Random(1, 25, 1)
		Select 
		Case $rndnumber = 1 And $break = 6
				$rndnumber = Random(30000, 60000)
				Sleep($rndnumber)
		EndSelect
	
	$run1 = Random(1, 25, 1)
	$run2 = Random(1, 3, 1)
	
	$south = Hex(PixelGetColor(597, 338),6)
	$middle = Hex(PixelGetColor(570, 398),6)
	$north = Hex(PixelGetColor(570, 420),6)

	Select
		Case $run1 < 21 
			Select
				Case $south = "FFFFFF"
						Send("{d down}")
						$rndnumber = Random(421, 424)
						Sleep($rndnumber)
						Send("{d up}")
						$rndnumber = Random(900, 1000)
						Sleep($rndnumber)						
						Send("{a down}")
						$rndnumber = Random(121, 124)
						Sleep($rndnumber)
						Send("{a up}")
						$rndnumber = Random(900, 1000)
						Sleep($rndnumber)	
						Send("{NUMPAD0}")
						$rndnumber = Random(200, 400)
						Sleep($rndnumber)						
						Send("{NUMPAD0}")
						$rndnumber = Random(200, 400)
						Sleep($rndnumber)
						Send("{Space}")
						$rndnumber = Random(7410, 7415)
						Sleep($rndnumber)	
						Send("r")
						$rndnumber = Random(390, 400)
						Sleep($rndnumber)							
						Send("{a down}")
						$rndnumber = Random(101, 104)
						Sleep($rndnumber)
						Send("{a up}")
				Case $middle = "FFFFFF"
						Send("{a down}")
						$rndnumber = Random(1420, 1425)
						Sleep($rndnumber)
						Send("{a up}")
						$rndnumber = Random(900, 1000)
						Sleep($rndnumber)						
						Send("{d down}")
						$rndnumber = Random(400, 405)
						Sleep($rndnumber)
						Send("{d up}")
						$rndnumber = Random(900, 1000)
						Sleep($rndnumber)	
						Send("{NUMPAD0}")
						$rndnumber = Random(200, 400)
						Sleep($rndnumber)						
						Send("{NUMPAD0}")
						$rndnumber = Random(200, 400)
						Sleep($rndnumber)
						Send("{Space}")
						$rndnumber = Random(8000, 8225)
						Sleep($rndnumber)	
						Send("r")
				Case $north = "FFFFFF"
						Send("{a down}")
						$rndnumber = Random(1420, 1425)
						Sleep($rndnumber)
						Send("{a up}")
						$rndnumber = Random(900, 1000)
						Sleep($rndnumber)						
						Send("{d down}")
						$rndnumber = Random(300, 305)
						Sleep($rndnumber)
						Send("{d up}")
						$rndnumber = Random(900, 1000)
						Sleep($rndnumber)	
						Send("{NUMPAD0}")
						$rndnumber = Random(200, 400)
						Sleep($rndnumber)						
						Send("{NUMPAD0}")
						$rndnumber = Random(200, 400)
						Sleep($rndnumber)
						Send("{Space}")
						$rndnumber = Random(12200, 12225)
						Sleep($rndnumber)	
						Send("r")
						$rndnumber = Random(390, 400)
						Sleep($rndnumber)							
						Send("{d down}")
						$rndnumber = Random(121, 124)
						Sleep($rndnumber)
						Send("{d up}")
				Case Else
					Select
						Case $npcs = 1
							MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)	
							Send("{Space}")
							$rndnumber = Random(15000, 15500)
							Sleep($rndnumber)
							MouseClick("left", Random(1074, 1253), Random(206, 225), 1, $mousespeed)
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{Space}")
							$rndnumber = Random(1200, 1300)
							Sleep($rndnumber)
							MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)	
							Send("{Space}")
							$rndnumber = Random(1400, 1500)
							Sleep($rndnumber)	
							Send("{a down}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{a up}")
							$rndnumber = Random(950, 1000)
							Sleep($rndnumber)
							Send("{d down}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{d up}")
							$rndnumber = Random(900, 1000)
							Sleep($rndnumber)							
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{Space}")
							$rndnumber = Random(10000, 10010)
							Sleep($rndnumber)	
							Send("r")
							$rndnumber = Random(5, 10)
							Sleep($rndnumber)	
							Send("{a down}")
							$rndnumber = Random(998, 1008)
							Sleep($rndnumber)
							Send("{a up}")	
							$rndnumber = Random(1390, 1400)
							Sleep($rndnumber)
							Send("{a down}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{a up}")	
						Case Else
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{Space}")
							$rndnumber = Random(13750, 14250)
							Sleep($rndnumber)
							Send("{a down}")
							$rndnumber = Random(300, 310)
							Sleep($rndnumber)
							Send("{a up}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{d down}")
							$rndnumber = Random(10, 20)
							Sleep($rndnumber)
							Send("{d up}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{r}")	
							
							$run11 = Random(1, 2, 1)
							$run22 = Random(1, 3, 1)
								Select 
									Case $run11 = 1 
										$rndnumber = Random(1400, 1500)
										Sleep($rndnumber)	

										Send("{e down}")
										$rndnumber = Random(400, 500)
										Sleep($rndnumber)
										Send("{e up}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										
										Send("{q down}")
										$rndnumber = Random(400, 500)
										Sleep($rndnumber)
										Send("{q up}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										
										Select
											Case $run22 = 1
												Send("{a down}")
												$rndnumber = Random(200, 220)
												Sleep($rndnumber)
												Send("{a up}")
											Case $run2 = 2
												Send("{d down}")
												$rndnumber = Random(200, 220)
												Sleep($rndnumber)
												Send("{d up}")	
												Case $run2 = 3
												$rndnumber = Random(400, 440)
												Sleep($rndnumber)			
										EndSelect
										
										$rndnumber = Random(8700, 9000)
										Sleep($rndnumber)

									Case $run11 <> 1
										$rndnumber = Random(12000, 13000)
										Sleep($rndnumber)	
								EndSelect
					EndSelect
			EndSelect		
						_travelcheck1kurzick();
		Case $run1 > 20
			Select
				Case $run2 <> 1
					Select
						Case $south = "FFFFFF"
								Send("{NUMPAD0}")
								$rndnumber = Random(200, 400)
								Sleep($rndnumber)
								Send("{Space}")
								$rndnumber = Random(7400, 7600)
								Sleep($rndnumber)				
								Send("{a down}")
								$rndnumber = Random(103, 106)
								Sleep($rndnumber)
								Send("{a up}")
								$rndnumber = Random(450, 500)
								Sleep($rndnumber)
								Send("{d down}")
								$rndnumber = Random(103, 106)
								Sleep($rndnumber)
								Send("{d up}")
								$rndnumber = Random(1450, 1500)
								Sleep($rndnumber)				
								Send("{d down}")
								$rndnumber = Random(852, 854)
								Sleep($rndnumber)
								Send("{d up}")
								$rndnumber = Random(1450, 1500)
								Sleep($rndnumber)	
								Send("{NUMPAD0}")
								$rndnumber = Random(200, 400)
								Sleep($rndnumber)
								Send("{Space}")
								$rndnumber = Random(10000, 10010)
								Sleep($rndnumber)	
								Send("r")
								$rndnumber = Random(5, 10)
								Sleep($rndnumber)	
								Send("{a down}")
								$rndnumber = Random(900, 904)
								Sleep($rndnumber)
								Send("{a up}")
								$rndnumber = Random(1390, 1400)
								Sleep($rndnumber)
								Send("{d down}")
								$rndnumber = Random(140, 150)
								Sleep($rndnumber)
								Send("{d up}")	
						Case $middle = "FFFFFF"
								Select
									Case $npcs = 1
										MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)	
										Send("{Space}")
										$rndnumber = Random(7000, 7500)
										Sleep($rndnumber)
										MouseClick("left", Random(1074, 1253), Random(206, 225), 1, $mousespeed)
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										Send("{Space}")
										$rndnumber = Random(1200, 1300)
										Sleep($rndnumber)
										MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)	
										Send("{Space}")
										$rndnumber = Random(1400, 1500)
										Sleep($rndnumber)	
										Send("{a down}")
										$rndnumber = Random(100, 110)
										Sleep($rndnumber)
										Send("{a up}")
										$rndnumber = Random(950, 1000)
										Sleep($rndnumber)
										Send("{d down}")
										$rndnumber = Random(100, 110)
										Sleep($rndnumber)
										Send("{d up}")
										$rndnumber = Random(900, 1000)
										Send("{NUMPAD0}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										Send("{NUMPAD0}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										Send("{Space}")
										$rndnumber = Random(10000, 10010)
										Sleep($rndnumber)	
										Send("r")
										$rndnumber = Random(5, 10)
										Sleep($rndnumber)	
										Send("{a down}")
										$rndnumber = Random(998, 1008)
										Sleep($rndnumber)
										Send("{a up}")	
										$rndnumber = Random(1390, 1400)
										Sleep($rndnumber)
										Send("{a down}")
										$rndnumber = Random(100, 110)
										Sleep($rndnumber)
										Send("{a up}")	
									Case Else
										Send("{NUMPAD0}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										Send("{NUMPAD0}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										Send("{Space}")
										$rndnumber = Random(13750, 14250)
										Sleep($rndnumber)
										Send("{a down}")
										$rndnumber = Random(300, 310)
										Sleep($rndnumber)
										Send("{a up}")
										$rndnumber = Random(100, 110)
										Sleep($rndnumber)
										Send("{d down}")
										$rndnumber = Random(10, 20)
										Sleep($rndnumber)
										Send("{d up}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										Send("{r}")	
										
										$run11 = Random(1, 2, 1)
										$run22 = Random(1, 3, 1)

											Select 
											Case $run11 = 1 
												$rndnumber = Random(1400, 1500)
												Sleep($rndnumber)	

												Send("{e down}")
												$rndnumber = Random(400, 500)
												Sleep($rndnumber)
												Send("{e up}")
												$rndnumber = Random(200, 400)
												Sleep($rndnumber)
												
												Send("{q down}")
												$rndnumber = Random(400, 500)
												Sleep($rndnumber)
												Send("{q up}")
												$rndnumber = Random(200, 400)
												Sleep($rndnumber)
												
												Select
													Case $run22 = 1
													Send("{a down}")
													$rndnumber = Random(200, 220)
													Sleep($rndnumber)
													Send("{a up}")
													Case $run2 = 2
													Send("{d down}")
													$rndnumber = Random(200, 220)
													Sleep($rndnumber)
													Send("{d up}")	
													Case $run2 = 3
													$rndnumber = Random(400, 440)
													Sleep($rndnumber)			
												EndSelect
												
												$rndnumber = Random(8700, 9000)
												Sleep($rndnumber)

											Case $run11 <> 1
											$rndnumber = Random(12000, 13000)
											Sleep($rndnumber)	
											EndSelect
								EndSelect	
						Case $north = "FFFFFF"
							Select
								Case $npcs = 1
									MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)	
									Send("{Space}")
									$rndnumber = Random(2000, 2200)
									Sleep($rndnumber)
									MouseClick("left", Random(1074, 1253), Random(206, 225), 1, $mousespeed)
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{Space}")
									$rndnumber = Random(1200, 1300)
									Sleep($rndnumber)
									MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)	
									Send("{Space}")
									$rndnumber = Random(1400, 1500)
									Sleep($rndnumber)	
									Send("{a down}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{a up}")
									$rndnumber = Random(950, 1000)
									Sleep($rndnumber)
									Send("{d down}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{d up}")
									$rndnumber = Random(900, 1000)
									Send("{NUMPAD0}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{NUMPAD0}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{Space}")
									$rndnumber = Random(10000, 10010)
									Sleep($rndnumber)	
									Send("r")
									$rndnumber = Random(5, 10)
									Sleep($rndnumber)	
									Send("{a down}")
									$rndnumber = Random(998, 1008)
									Sleep($rndnumber)
									Send("{a up}")	
									$rndnumber = Random(1390, 1400)
									Sleep($rndnumber)
									Send("{a down}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{a up}")	
								Case Else
									Send("{NUMPAD0}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{NUMPAD0}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{Space}")
									$rndnumber = Random(13750, 14250)
									Sleep($rndnumber)
									Send("{a down}")
									$rndnumber = Random(300, 310)
									Sleep($rndnumber)
									Send("{a up}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{d down}")
									$rndnumber = Random(10, 20)
									Sleep($rndnumber)
									Send("{d up}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{r}")	
									
									$run11 = Random(1, 2, 1)
									$run22 = Random(1, 3, 1)

										Select 
										Case $run11 = 1 
											$rndnumber = Random(1400, 1500)
											Sleep($rndnumber)	

											Send("{e down}")
											$rndnumber = Random(400, 500)
											Sleep($rndnumber)
											Send("{e up}")
											$rndnumber = Random(200, 400)
											Sleep($rndnumber)
											
											Send("{q down}")
											$rndnumber = Random(400, 500)
											Sleep($rndnumber)
											Send("{q up}")
											$rndnumber = Random(200, 400)
											Sleep($rndnumber)
											
											Select
												Case $run22 = 1
												Send("{a down}")
												$rndnumber = Random(200, 220)
												Sleep($rndnumber)
												Send("{a up}")
												Case $run2 = 2
												Send("{d down}")
												$rndnumber = Random(200, 220)
												Sleep($rndnumber)
												Send("{d up}")	
												Case $run2 = 3
												$rndnumber = Random(400, 440)
												Sleep($rndnumber)			
											EndSelect
											
											$rndnumber = Random(8700, 9000)
											Sleep($rndnumber)

										Case $run11 <> 1
										$rndnumber = Random(12000, 13000)
										Sleep($rndnumber)	
										EndSelect
							EndSelect										
						Case Else
							Select
								Case $npcs = 1
									MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)	
									Send("{Space}")
									$rndnumber = Random(15000, 15500)
									Sleep($rndnumber)
									MouseClick("left", Random(1074, 1253), Random(206, 225), 1, $mousespeed)
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{Space}")
									$rndnumber = Random(1200, 1300)
									Sleep($rndnumber)
									MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)	
									Send("{Space}")
									$rndnumber = Random(1400, 1500)
									Sleep($rndnumber)	
									Send("{a down}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{a up}")
									$rndnumber = Random(950, 1000)
									Sleep($rndnumber)
									Send("{d down}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{d up}")
									$rndnumber = Random(900, 1000)
									Sleep($rndnumber)							
									Send("{NUMPAD0}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{NUMPAD0}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									Send("{Space}")
									$rndnumber = Random(10000, 10010)
									Sleep($rndnumber)	
									Send("r")
									$rndnumber = Random(5, 10)
									Sleep($rndnumber)	
									Send("{a down}")
									$rndnumber = Random(998, 1008)
									Sleep($rndnumber)
									Send("{a up}")	
									$rndnumber = Random(1390, 1400)
									Sleep($rndnumber)
									Send("{a down}")
									$rndnumber = Random(100, 110)
									Sleep($rndnumber)
									Send("{a up}")	
								Case Else
								Send("{NUMPAD0}")
								$rndnumber = Random(200, 400)
								Sleep($rndnumber)
								Send("{NUMPAD0}")
								$rndnumber = Random(200, 400)
								Sleep($rndnumber)
								Send("{Space}")
								$rndnumber = Random(13750, 14250)
								Sleep($rndnumber)
								Send("{a down}")
								$rndnumber = Random(300, 310)
								Sleep($rndnumber)
								Send("{a up}")
								$rndnumber = Random(100, 110)
								Sleep($rndnumber)
								Send("{d down}")
								$rndnumber = Random(10, 20)
								Sleep($rndnumber)
								Send("{d up}")
								$rndnumber = Random(200, 400)
								Sleep($rndnumber)
								Send("{r}")	
								
								$run11 = Random(1, 2, 1)
								$run22 = Random(1, 3, 1)

									Select 
									Case $run11 = 1 
										$rndnumber = Random(1400, 1500)
										Sleep($rndnumber)	

										Send("{e down}")
										$rndnumber = Random(400, 500)
										Sleep($rndnumber)
										Send("{e up}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										
										Send("{q down}")
										$rndnumber = Random(400, 500)
										Sleep($rndnumber)
										Send("{q up}")
										$rndnumber = Random(200, 400)
										Sleep($rndnumber)
										
										Select
											Case $run22 = 1
											Send("{a down}")
											$rndnumber = Random(200, 220)
											Sleep($rndnumber)
											Send("{a up}")
											Case $run2 = 2
											Send("{d down}")
											$rndnumber = Random(200, 220)
											Sleep($rndnumber)
											Send("{d up}")	
											Case $run2 = 3
											$rndnumber = Random(400, 440)
											Sleep($rndnumber)			
										EndSelect
										
										$rndnumber = Random(8700, 9000)
										Sleep($rndnumber)

									Case $run11 <> 1
									$rndnumber = Random(12000, 13000)
									Sleep($rndnumber)	
									EndSelect
						EndSelect												
					EndSelect
					_travelcheck1kurzick();
					
				Case $run2 = 1
					Select
						Case $npcs = 1
							MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)	
							Send("{Space}")
							$rndnumber = Random(15000, 15500)
							Sleep($rndnumber)
							MouseClick("left", Random(1074, 1253), Random(206, 225), 1, $mousespeed)
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{Space}")
							$rndnumber = Random(1200, 1300)
							Sleep($rndnumber)
							MouseClick("left", Random(1074, 1253), Random(232, 249), 1, $mousespeed)	
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)	
							Send("{Space}")
							$rndnumber = Random(1400, 1500)
							Sleep($rndnumber)	
							Send("{a down}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{a up}")
							$rndnumber = Random(950, 1000)
							Sleep($rndnumber)
							Send("{d down}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{d up}")
							$rndnumber = Random(900, 1000)
							Sleep($rndnumber)							
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{Space}")
							$rndnumber = Random(10000, 10010)
							Sleep($rndnumber)	
							Send("r")
							$rndnumber = Random(5, 10)
							Sleep($rndnumber)	
							Send("{a down}")
							$rndnumber = Random(998, 1008)
							Sleep($rndnumber)
							Send("{a up}")	
							$rndnumber = Random(1390, 1400)
							Sleep($rndnumber)
							Send("{a down}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{a up}")	
						Case Else
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{NUMPAD0}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{Space}")
							$rndnumber = Random(13750, 14250)
							Sleep($rndnumber)
							Send("{a down}")
							$rndnumber = Random(300, 310)
							Sleep($rndnumber)
							Send("{a up}")
							$rndnumber = Random(100, 110)
							Sleep($rndnumber)
							Send("{d down}")
							$rndnumber = Random(10, 20)
							Sleep($rndnumber)
							Send("{d up}")
							$rndnumber = Random(200, 400)
							Sleep($rndnumber)
							Send("{r}")	
							
							$run11 = Random(1, 2, 1)
							$run22 = Random(1, 3, 1)

								Select 
								Case $run11 = 1 
									$rndnumber = Random(1400, 1500)
									Sleep($rndnumber)	

									Send("{e down}")
									$rndnumber = Random(400, 500)
									Sleep($rndnumber)
									Send("{e up}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									
									Send("{q down}")
									$rndnumber = Random(400, 500)
									Sleep($rndnumber)
									Send("{q up}")
									$rndnumber = Random(200, 400)
									Sleep($rndnumber)
									
									Select
										Case $run22 = 1
										Send("{a down}")
										$rndnumber = Random(200, 220)
										Sleep($rndnumber)
										Send("{a up}")
										Case $run2 = 2
										Send("{d down}")
										$rndnumber = Random(200, 220)
										Sleep($rndnumber)
										Send("{d up}")	
										Case $run2 = 3
										$rndnumber = Random(400, 440)
										Sleep($rndnumber)			
									EndSelect
									
									$rndnumber = Random(8700, 9000)
									Sleep($rndnumber)

								Case $run11 <> 1
								$rndnumber = Random(12000, 13000)
								Sleep($rndnumber)	
								EndSelect
					EndSelect	
							_travelcheck1kurzick();
			EndSelect	
	EndSelect					
EndFunc

Func _checkkurzick()
	$check = Hex(PixelGetColor(547, 302),6)
	
	If $check <> "FFFFFF" Then
			$rndnumber = Random(5000, 5500)
			Sleep($rndnumber)			
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			MouseClick("left", Random(299, 414), Random(62, 75), 1, $mousespeed)	
			Sleep(15000 + $delayrecovery)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)			
			MouseClick("left", Random(299, 414), Random(62, 75), 1, $mousespeed)	
			Sleep(15000 + $delayrecovery)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			Send("g")
			$rndnumber = Random(400, 500)			
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			MouseClick("left", Random(198, 295), Random(147, 157), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$g = Random(35, 661)
			$h = Random(327, 337)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$i = Random(35, 661)
			$j = Random(411, 421)
			MouseClick("left", $i, $j, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $i, $j, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$k = Random(35, 661)
			$l = Random(495, 505)
			MouseClick("left", $k, $l, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $k, $l, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)			
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)	
			_runkurzick();
	ElseIf $check = "FFFFFF" Then
		$rndnumber = Random(200, 250)
		Sleep($rndnumber)
	EndIf
EndFunc	
	
Func _questkurzick()
	
If $mode = 1 Then
	$emote = Random(1, 50, 1)
	Select
	Case $emote = 1 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7guitar{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case $emote = 2 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7violin{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case $emote = 3 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7flute{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)	
	Case $emote = 4 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7drum{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case $emote = 5 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7dance{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case Else
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	EndSelect
ElseIf $mode = 2 Then
	Send("u")
	$rndnumber = Random(1500, 2000)
	Sleep($rndnumber)
EndIf
	
	Send("{NUMPAD3}")										
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	MouseClick("left", Random(620, 624), Random(224, 226), 2, $mousespeed)
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD1}")										
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	MouseClick("left", Random(511, 515), Random(221, 225), 2, $mousespeed)
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD2}")										
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	MouseClick("left", Random(785, 795), Random(305, 315), 2, $mousespeed)
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPADDOT}")										
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	MouseClick("left", Random(741, 743), Random(656, 658), 2, $mousespeed)
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD7}")
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD8}")
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD9}")
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	$rndnumber = Random(900, 1100)
	Sleep($rndnumber)
	Send("{NUMPAD4}")
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD5}")
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("{NUMPAD6}")
	$rndnumber = Random(100, 150)
	Sleep($rndnumber)
	Send("0")
	$rndnumber = Random(8000, 8100)
	Sleep($rndnumber)
	Send("0")
	$rndnumber = Random(8000, 8100)
	Sleep($rndnumber)
	Send("0")
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	Send("{NUMPAD6}")
	$rndnumber = Random(200, 250)
	Sleep($rndnumber)
	Send("{NUMPAD3}")										
	$rndnumber = Random(200, 250)
	Sleep($rndnumber)
	MouseClick("left", Random(678, 679), Random(120, 122), 2, $mousespeed)
	$rndnumber = Random(7000, 7100)
	Sleep($rndnumber)
	Send("0")
	$rndnumber = Random(8000, 8100)
	Sleep($rndnumber)
	Send("0")
	$rndnumber = Random(8000, 8100)
	Sleep($rndnumber)
	Send("0")
	$rndnumber = Random(500, 1000)
	Sleep($rndnumber)
EndFunc

Func _rewardkurzick()
	
	Sleep($delayreward)
	
	Send("{e down}")
	$rndnumber = Random(1500, 1800)
	Sleep($rndnumber)
	Send("{e up}")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)

	Send("v")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{SPACE}")
	$rndnumber = Random(1450, 1550)
	Sleep($rndnumber)
	Send("v")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{SPACE}")
	$rndnumber = Random(1450, 1550)
	Sleep($rndnumber)

	$a = Random(482, 773)
	$b = Random(732, 734)
	MouseClick("left", $a, $b, 1, $mousespeed)
	$rndnumber = Random(2500, 2700)
	Sleep($rndnumber)
	Send("{Space}")
	$rndnumber = Random(1000, 1500)
	Sleep($rndnumber)
	$c = Random(503, 777)
	$d = Random(595, 628)
	MouseClick("left", $c, $d, 1, $mousespeed)
	$rndnumber = Random(1000, 2000)
	Sleep($rndnumber)
	
	If $mode = 1 Then
		Sleep(0)
	ElseIf $mode = 2 Then
		Send("u")
	EndIf
	
EndFunc

Func _travelkurzick()
	Send("m")										
	$rndnumber = Random(700, 1000)
	Sleep($rndnumber)
	$a = Random(576, 621)
	$b = Random(508, 567)
	MouseClick("left", $a, $b, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{Space}")
	_travelcheck1kurzick();
EndFunc

Func _exchangekurzick()
	$coinflip = Random(1, 2, 1)
	$emote = Random(1, 4, 1)
	
	Select
	Case $emote = 1 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7roar{SHIFTUP}{ENTER}")
		$rndnumber = Random(3000, 3100)
		Sleep($rndnumber)
	Case $emote = 2 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7cheer{SHIFTUP}{ENTER}")
		$rndnumber = Random(3000, 3100)
		Sleep($rndnumber)
	Case Else
		$rndnumber = Random(3000, 3100)
		Sleep($rndnumber)
	EndSelect
	
	Select 
		Case $coinflip = 1	; The Jade Quarry
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(996, 1036), Random(90, 130), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1kurzick();
			Send("{NUMPAD0}")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(13000, 14000)
			Sleep($rndnumber)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(4000, 4500)
			Sleep($rndnumber)
			Send("{a down}")
			$rndnumber = Random(300, 310)
			Sleep($rndnumber)
			Send("{a up}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d down}")
			$rndnumber = Random(300, 310)
			Sleep($rndnumber)
			Send("{d up}")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			Send("{e down}")
			$rndnumber = Random(4600, 5000)
			Sleep($rndnumber)
			Send("{e up}")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(2000, 2500)
			Sleep($rndnumber)
		Case $coinflip = 2	; Fort Aspenwood
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClickDrag("right", Random(720, 725), Random(185, 190), Random(720, 725), Random(455, 460), $mousespeed)
			$a = Random(625, 629)
			$b = Random(129, 133)
			MouseClick("left", $a, $b, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1kurzick();
			Send("{NUMPAD0}")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{SPACE}")
			$rndnumber = Random(9500, 10500)
			Sleep($rndnumber)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(2700, 3000)
			Sleep($rndnumber)
			Send("{a down}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{a up}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d down}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d up}")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			Send("{q down}")
			$rndnumber = Random(2400, 2500)
			Sleep($rndnumber)
			Send("{q up}")
			$rndnumber = Random(500, 1000)
			Send("{w down}")
			$rndnumber = Random(2000, 2050)
			Sleep($rndnumber)
			Send("{w up}")
			$rndnumber = Random(500, 1000)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(2000, 2500)
			Sleep($rndnumber)
	EndSelect

	Select
		Case $exchange = 1	; Boost your alliance's faction
			MouseClick("left", Random(502, 778), Random(639, 664), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(354, 924), Random(588, 594), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			Send($name, 1)
			
			MouseClick("left", Random(666, 790), Random(733, 750), 1, $mousespeed)
			
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(354, 924), Random(588, 594), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			
			MouseClick("left", Random(666, 790), Random(733, 750), 1, $mousespeed)
			
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
		Case $exchange = 2	; Get Amber Chunks
			MouseClick("left", Random(498, 777), Random(505, 534), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(497, 780), Random(564, 593), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
	EndSelect
		
	Select
		Case $coinflip = 1	; The Jade Quarry
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(221, 262), Random(850, 899), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1kurzick();
		Case $coinflip = 2	; Fort Aspenwood
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClickDrag("right", Random(720, 725), Random(605, 610), Random(720, 725), Random(185, 190), $mousespeed)	
			$a = Random(643, 653)
			$b = Random(738, 748)
			MouseClick("left", $a, $b, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1kurzick();
	EndSelect
	
	Send("p")
	$rndnumber = Random(200, 400)
	MouseClick("left", Random(114, 179), Random(144, 154), 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$a = Random(35, 661)
	$bb = IniRead("settings.ini", "$heroes", "$sousuke", "NotFound")
	$b = Random($bb - 5, $bb + 5)
	MouseClick("left", $a, $b, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $a, $b, 1, $mousespeed)	
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$c = Random(35, 661)
	$dd = IniRead("settings.ini", "$heroes", "$zhed", "NotFound")
	$d = Random($dd - 5, $dd + 5)
	MouseClick("left", $c, $d, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $c, $d, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$e = Random(35, 661)
	$ff = IniRead("settings.ini", "$heroes", "$vekk", "NotFound")
	$f = Random($ff - 5, $ff + 5)
	MouseClick("left", $e, $f, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $e, $f, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	MouseClick("left", Random(198, 295), Random(147, 157), 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$g = Random(35, 661)
	$h = Random(327, 337)
	MouseClick("left", $g, $h, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $g, $h, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$i = Random(35, 661)
	$j = Random(411, 421)
	MouseClick("left", $i, $j, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $i, $j, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$k = Random(35, 661)
	$l = Random(495, 505)
	MouseClick("left", $k, $l, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $k, $l, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("p")
	$rndnumber = Random(500, 1000)
	Sleep($rndnumber)
EndFunc

Func _travelcheck1luxon()	
	$travelcheck1 = Hex(PixelGetColor(640, 512),6)
	Select
		Case $travelcheck1 <> "FF0000" And $counter <> $countercheck And $gonewrongcounter <> $gonewrongcountercheck
			Sleep(200)
			$counter = $counter + 1
			_travelcheck1luxon();
		Case $travelcheck1 <> "FF0000" And $counter <> $countercheck And $gonewrongcounter = $gonewrongcountercheck	
			Sleep(200)
			$counter = $counter + 1
			_travelcheck1luxon();			
		Case $travelcheck1 = "FF0000" And $counter <> $countercheck And $gonewrongcounter <> $gonewrongcountercheck
			$counter = 0
			_travelcheck2luxon();		
		Case $travelcheck1 = "FF0000" And $counter <> $countercheck And $gonewrongcounter = $gonewrongcountercheck
			$counter = 0
			_travelcheck2luxon();				
		Case $counter = $countercheck And $gonewrongcounter <> $gonewrongcountercheck
			$gonewrongcounter = $gonewrongcounter + 1
			$counter = 0
			_checkluxon();
		Case $counter = $countercheck And $gonewrongcounter = $gonewrongcountercheck
			$gonewrongcounter = 0
			$counter = 0
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)				
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			MouseClick("left", Random(299, 414), Random(62, 75), 1, $mousespeed)	
			Sleep(15000 + $delayrecovery)
			Send("m")
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(734, 744), Random(744, 754), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			Send("{Space}")
			Sleep(15000 + $delayrecovery)
			Send("m")
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)			
			MouseClickDrag("right", Random(720, 725), Random(185, 190), Random(1020, 1025), Random(485, 490), $mousespeed)
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(361, 371), Random(381, 391), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(475, 525), Random(481, 483), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			Send("{Space}")
			Sleep(15000 + $delayrecovery)
			Send("m")
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			MouseClick("left", Random(100, 200), Random(100, 200), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)	
			MouseClick("left", 889, 515, 1, $mousespeed)					
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)	
			MouseClick("left", Random(615, 655), Random(483, 523), 1, $mousespeed)			
			$rndnumber = Random(1900, 2000)
			Sleep($rndnumber)
			Send("{Space}")
			Sleep(15000 + $delayrecovery)		
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)	
			Send("{ESC}")
			$rndnumber = Random(250, 300)
			Sleep($rndnumber)			
			Send("u")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(200, 400)
			MouseClick("left", Random(114, 179), Random(144, 154), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$a = Random(35, 661)
			$bb = IniRead("settings.ini", "$heroes", "$zenmai", "NotFound")
			$b = Random($bb - 5, $bb + 5)
			MouseClick("left", $a, $b, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $a, $b, 1, $mousespeed)	
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$c = Random(35, 661)
			$dd = IniRead("settings.ini", "$heroes", "$anton", "NotFound")
			$d = Random($dd - 5, $dd + 5)
			MouseClick("left", $c, $d, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $c, $d, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$e = Random(35, 661)
			$ff = IniRead("settings.ini", "$heroes", "$kahmu", "NotFound")
			$f = Random($ff - 5, $ff + 5)
			MouseClick("left", $e, $f, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $e, $f, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			MouseClick("left", Random(198, 295), Random(147, 157), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$g = Random(35, 661)
			$h = Random(468, 478)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			_runluxon();
	EndSelect
EndFunc	
		
Func _travelcheck2luxon()
	$travelcheck2 = Hex(PixelGetColor(640, 512),6)
	If $travelcheck2 = "FF0000" Then
		Sleep(200)
		_travelcheck2luxon();
	ElseIf $travelcheck2 <> "FF0000" Then
		$rndnumber = Random(4500, 5000)
		Sleep($rndnumber)	
		$gonewrongcounter = 0
		$counter = 0		
	EndIf
EndFunc	

Func _checkluxon()
	
	$check = Hex(PixelGetColor(444, 574),6)
	
	If $check <> "FFFFFF" Then
			$rndnumber = Random(5000, 5500)
			Sleep($rndnumber)			
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			MouseClick("left", Random(299, 414), Random(62, 75), 1, $mousespeed)	
			Sleep(15000 + $delayrecovery)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)		
			MouseClick("left", Random(299, 414), Random(62, 75), 1, $mousespeed)	
			Sleep(15000 + $delayrecovery)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			Send("g")
			$rndnumber = Random(400, 500)
			Sleep($rndnumber)
			Send("g")
			$rndnumber = Random(400, 500)			
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			MouseClick("left", Random(198, 295), Random(147, 157), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			$g = Random(35, 661)
			$h = Random(468, 478)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(100, 200)
			Sleep($rndnumber)
			MouseClick("left", $g, $h, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("p")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)	
			_runluxon();
	ElseIf $check = "FFFFFF" Then
		$rndnumber = Random(200, 250)
		Sleep($rndnumber)
	EndIf
EndFunc	

Func _questluxon()
	
If $mode = 1 Then
	$emote = Random(1, 50, 1)
	Select
	Case $emote = 1 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7guitar{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case $emote = 2 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7violin{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case $emote = 3 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7flute{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)	
	Case $emote = 4 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7drum{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case $emote = 5 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7dance{SHIFTUP}{ENTER}")
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	Case Else
		$rndnumber = Random(200, 400)
		Sleep($rndnumber)
	EndSelect
ElseIf $mode = 2 Then
	Send("u")
	$rndnumber = Random(1500, 2000)
	Sleep($rndnumber)
EndIf
	
	$1a = Random(440, 442)
	$1b = Random(407, 409)
	$2a = Random(337, 339)
	$2b = Random(597, 599)
	$3a = Random(389, 391)
	$3b = Random(379, 381)
	$4a = Random(187, 189)
	$4b = Random(589, 591)
	$5a = Random(254, 256)
	$5b = Random(579, 581)
	$6a = Random(183, 185)
	$6b = Random(461, 463)
	$7a = Random(79, 81)
	$7b = Random(564, 566)
	$8a = Random(44, 46)
	$8b = Random(618, 620)
	$9a = Random(151, 153)
	$9b = Random(397, 399)
	
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)		
	Send("{NUMPAD7}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD8}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD9}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD1}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $1a, $1b, 2, $mousespeed)
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)	
	Send("{NUMPADDOT}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $2a, $2b, 2, $mousespeed)
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)	
	Send("{NUMPAD2}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $2a, $2b, 2, $mousespeed)
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)	
	Send("{NUMPAD3}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $2a, $2b, 2, $mousespeed)
	_runsequence1();
	_runsequence2();
	_runsequence1();
	_runsequence2();
	_runsequence1();
	_runsequence2();
	_runsequence1();
	Send("{NUMPAD1}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $3a, $3b, 2, $mousespeed)
	_runsequence2();
	Send("{NUMPAD2}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $4a, $4b, 2, $mousespeed)
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD3}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $4a, $4b, 2, $mousespeed)
	_runsequence1();
	_runsequence2();
	Send("{NUMPADDOT}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $5a, $5b, 2, $mousespeed)
	_runsequence1();
	_runsequence2();
	_runsequence1();
	_runsequence2();
	_runsequence1();
	_runsequence2();
	_runsequence1();
	Send("{NUMPAD2}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $6a, $6b, 2, $mousespeed)
	_runsequence2();
	Send("{NUMPAD3}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $7a, $7b, 2, $mousespeed)
	_runsequence1();
	_runsequence2();
	_runsequence1();
	_runsequence2();
	_runsequence1();
	_runsequence2();
	Send("{NUMPAD3}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $8a, $8b, 2, $mousespeed)
	_runsequence1();
	Send("{NUMPAD2}")
	$rndnumber = Random(150, 160)
	Sleep($rndnumber)
	MouseClick("left", $9a, $9b, 2, $mousespeed)
	_runsequence2();
	_runsequence1();
	_runsequence2();
	_runsequence1();
EndFunc

Func _rewardluxon()
	
	Sleep($delayreward)
	
	Send("{q down}")
	$rndnumber = Random(2450, 2550)
	Sleep($rndnumber)	
	Send("{q up}")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)	
	Send("v")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{SPACE}")
	$rndnumber = Random(4000, 4100)
	Sleep($rndnumber)		
	MouseClick("left", Random(486, 765), Random(669, 707), 1, $mousespeed)	
	Send("{SPACE}")
	$rndnumber = Random(900, 1000)
	Sleep($rndnumber)
	MouseClick("left", Random(496, 780), Random(576, 613), 1, $mousespeed)	

	If $mode = 1 Then
		Sleep(0)
	ElseIf $mode = 2 Then
		Send("u")
	EndIf
	
EndFunc

Func _travelluxon()
	Send("{NUMPAD0}")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{Space}")
	$rndnumber = Random(4590, 4610)
	Sleep($rndnumber)
	Send("x")
	$rndnumber = Random(900, 1000)
	Sleep($rndnumber)
	Send("r")
	_travelcheck1luxon();
EndFunc

Func _runluxon()
	Send("{NUMPAD0}")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{Space}")
	$rndnumber = Random(5800, 6000)
	Sleep($rndnumber)
	Send("x")
	$rndnumber = Random(900, 1000)
	Sleep($rndnumber)
	Send("r")
	_travelcheck1luxon();
EndFunc

Func _runsequence1()
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)		
	Send("{NUMPAD7}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD8}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD9}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)
	$rndnumber = Random(4570, 4575)
	Sleep($rndnumber)			
EndFunc

Func _runsequence2()
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)		
	Send("{NUMPAD4}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD5}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)	
	Send("{NUMPAD6}")
	$rndnumber = Random(10, 12)
	Sleep($rndnumber)
	$rndnumber = Random(2570, 2575)
	Sleep($rndnumber)			
EndFunc

Func _exchangeluxon()
	$coinflip = Random(1, 2, 1)
	$emote = Random(1, 4, 1)
	
	Select
	Case $emote = 1 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7roar{SHIFTUP}{ENTER}")
		$rndnumber = Random(3000, 3100)
		Sleep($rndnumber)
	Case $emote = 2 And $emotes = 1
		Send("{ENTER}{SHIFTDOWN}7cheer{SHIFTUP}{ENTER}")
		$rndnumber = Random(3000, 3100)
		Sleep($rndnumber)
	Case Else
		$rndnumber = Random(3000, 3100)
		Sleep($rndnumber)
	EndSelect
	
	Send("{NUMPAD0}")
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("{Space}")
	$rndnumber = Random(5800, 6000)
	Sleep($rndnumber)

	Select 
		Case $coinflip = 1	; The Jade Quarry
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(787, 837), Random(890, 940), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1luxon();
			Send("{NUMPAD0}")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(13000, 14000)
			Sleep($rndnumber)
			Send("{a down}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{a up}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d down}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d up}")
			$rndnumber = Random(500, 1000)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(4000, 4500)
			Sleep($rndnumber)
			Send("{s down}")
			$rndnumber = Random(3950, 4050)
			Sleep($rndnumber)
			Send("{s up}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(20000, 21000)
			Sleep($rndnumber)
			Send("{ESC}")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{s down}")
			$rndnumber = Random(4000, 4200)
			Sleep($rndnumber)
			Send("{s up}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(4000, 4500)
		Case $coinflip = 2	; Fort Aspenwood
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			$a = Random(365, 405)
			$b = Random(680, 720)
			MouseClick("left", $a, $b, 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1luxon();
			Send("{NUMPAD0}")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{SPACE}")
			$rndnumber = Random(9500, 10500)
			Sleep($rndnumber)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(2700, 3000)
			Sleep($rndnumber)
			Send("{a down}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{a up}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d down}")
			$rndnumber = Random(100, 110)
			Sleep($rndnumber)
			Send("{d up}")
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			Send("{q down}")
			$rndnumber = Random(4500, 4550)
			Sleep($rndnumber)
			Send("{q up}")
			$rndnumber = Random(500, 1000)
			Send("{w down}")
			$rndnumber = Random(4500, 4550)
			Sleep($rndnumber)
			Send("{w up}")
			$rndnumber = Random(500, 1000)
			Send("v")
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			$rndnumber = Random(3500, 4000)
			Sleep($rndnumber)
	EndSelect

	Select
		Case $exchange = 1	; Boost your alliance's faction
			MouseClick("left", Random(502, 778), Random(639, 664), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(354, 924), Random(588, 594), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			Send($name, 1)
			
			MouseClick("left", Random(666, 790), Random(733, 750), 1, $mousespeed)
			
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(354, 924), Random(588, 594), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			
			MouseClick("left", Random(666, 790), Random(733, 750), 1, $mousespeed)
			
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
		Case $exchange = 2	; Get Jadeite Shards
			MouseClick("left", Random(498, 777), Random(505, 534), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(497, 780), Random(564, 593), 1, $mousespeed)
			$rndnumber = Random(500, 1000)
			Sleep($rndnumber)
	EndSelect
		
	Select
		Case $coinflip = 1	; The Jade Quarry
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(466, 496), Random(176, 206), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1luxon();
		Case $coinflip = 2	; Fort Aspenwood
			Send("m")										
			$rndnumber = Random(700, 1000)
			Sleep($rndnumber)
			MouseClick("left", Random(894, 924), Random(325, 355), 1, $mousespeed)
			$rndnumber = Random(200, 400)
			Sleep($rndnumber)
			Send("{Space}")
			_travelcheck1luxon();
	EndSelect
	
	Send("p")
	$rndnumber = Random(200, 400)
	MouseClick("left", Random(114, 179), Random(144, 154), 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$a = Random(35, 661)
	$bb = IniRead("settings.ini", "$heroes", "$zenmai", "NotFound")
	$b = Random($bb - 5, $bb + 5)
	MouseClick("left", $a, $b, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $a, $b, 1, $mousespeed)	
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$c = Random(35, 661)
	$dd = IniRead("settings.ini", "$heroes", "$anton", "NotFound")
	$d = Random($dd - 5, $dd + 5)
	MouseClick("left", $c, $d, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $c, $d, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$e = Random(35, 661)
	$ff = IniRead("settings.ini", "$heroes", "$kahmu", "NotFound")
	$f = Random($ff - 5, $ff + 5)
	MouseClick("left", $e, $f, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $e, $f, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	MouseClick("left", Random(198, 295), Random(147, 157), 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	$g = Random(35, 661)
	$h = Random(468, 478)
	MouseClick("left", $g, $h, 1, $mousespeed)
	$rndnumber = Random(100, 200)
	Sleep($rndnumber)
	MouseClick("left", $g, $h, 1, $mousespeed)
	$rndnumber = Random(200, 400)
	Sleep($rndnumber)
	Send("p")
	$rndnumber = Random(500, 1000)
	Sleep($rndnumber)
EndFunc

Func _shutdown()
		Shutdown(1)
EndFunc
	
Func _sleep()
		Sleep(500)
EndFunc
	
Func _startrun()
	Select
		Case $faction = 1 And $mode = 2
			_questkurzick();
			_rewardkurzick();
		Case $faction = 2 And $mode = 2
			_questluxon();
			_rewardluxon();
		Case Else
			Sleep(1000)
	EndSelect
EndFunc	

If Not WinActivate("Guild Wars") Then
	WinActivate("Guild Wars")
EndIf

Sleep(6000)

$runstotal = 27
$runs = 0
While True
Select 
	Case $faction = 1
		If $mode = 1 Then	
			Select 
				Case $runstotal <> $runs And @HOUR <> $hour
					$runs = $runs + 1
					_runkurzick();
					_questkurzick();
					_rewardkurzick();
					_travelkurzick();
				Case $runstotal = $runs And @HOUR <> $hour
					$runs = $runs - 27
					_exchangekurzick();
				Case Else
					_shutdown();
			EndSelect
		ElseIf $mode = 2 Then
			_sleep();
		EndIf
	Case $faction = 2
		If $mode = 1 Then	
			Select 
				Case $runstotal <> $runs And @HOUR <> $hour
					$runs = $runs + 1
					_runluxon();
					_questluxon();
					_rewardluxon();
					_travelluxon();
				Case $runstotal = $runs And @HOUR <> $hour
					$runs = $runs - 27
					_exchangeluxon();
				Case Else
					_shutdown();
			EndSelect
		ElseIf $mode = 2 Then
			_sleep();
		EndIf
EndSelect		
WEnd