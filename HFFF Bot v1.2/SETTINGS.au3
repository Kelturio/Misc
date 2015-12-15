#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

Func _main()
	Global $sousuke = InputBox("Heroes", "Insert Sousuke's position in the party search window below (e.g. ""1"" if he's first)" , "Insert here!")
	Global $zhed = InputBox("Heroes", "Insert Zhed's position in the party search window below (e.g. ""1"" if he's first)" , "Insert here!")		
	Global $vekk = InputBox("Heroes", "Insert Vekk's position in the party search window below (e.g. ""1"" if he's first)" , "Insert here!")
	Global $zenmai = InputBox("Heroes", "Insert Zenmai's position in the party search window below (e.g. ""1"" if he's first)" , "Insert here!")		
	Global $anton = InputBox("Heroes", "Insert Anton's position in the party search window below (e.g. ""1"" if he's first)" , "Insert here!")		
	Global $kahmu = InputBox("Heroes", "Insert Kahmu's position in the party search window below (e.g. ""1"" if he's first)" , "Insert here!")		
	
	Global $npcs = InputBox("Run", "Enter ""1"" in the box below if you want to allow the bot to run to the NPC's to get out of Lutgarids. Otherwise, enter ""0""" , "Insert here!")		
	
	Global $mousespeed = InputBox("$mousespeed", "Insert the value for ""$mousespeed"" into the box below" , "Insert here!")
	Global $delayreward = InputBox("$delayreward", "Insert the value for ""$delayreward"" into the box below" , "Insert here!")
	Global $delayrecovery = InputBox("$delayrecovery", "Insert the value for ""$delayrecovery"" into the box below" , "Insert here!")

	Global $emotes = InputBox("Emotes", "Enter ""1"" in the box below to enable the use of emotes." , "Insert here!")

	If $sousuke = 1 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 194)
	ElseIf $sousuke = 2 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 221)		
	ElseIf $sousuke = 3 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 252)		
	ElseIf $sousuke = 4 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 277)		
	ElseIf $sousuke = 5 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 306)		
	ElseIf $sousuke = 6 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 333)	
	ElseIf $sousuke = 7 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 361)		
	ElseIf $sousuke = 8 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 390)
	ElseIf $sousuke = 9 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 417)
	ElseIf $sousuke = 10 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 445)
	ElseIf $sousuke = 11 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 473)		
	ElseIf $sousuke = 12 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 501)		
	ElseIf $sousuke = 13 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 530)		
	ElseIf $sousuke = 14 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 557)		
	ElseIf $sousuke = 15 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 586)		
	ElseIf $sousuke = 16 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 612)		
	ElseIf $sousuke = 17 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 642)		
	ElseIf $sousuke = 18 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 669)		
	ElseIf $sousuke = 19 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 697)		
	ElseIf $sousuke = 20 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 725)		
	ElseIf $sousuke = 21 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 754)	
	ElseIf $sousuke = 22 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 781)	
	ElseIf $sousuke = 23 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 809)	
	ElseIf $sousuke = 24 Then
		IniWrite("settings.ini", "$heroes", "$sousuke", 838)	
	EndIf
	
	If $zhed = 1 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 194)
	ElseIf $zhed = 2 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 221)		
	ElseIf $zhed = 3 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 252)		
	ElseIf $zhed = 4 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 277)		
	ElseIf $zhed = 5 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 306)		
	ElseIf $zhed = 6 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 333)	
	ElseIf $zhed = 7 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 361)		
	ElseIf $zhed = 8 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 390)
	ElseIf $zhed = 9 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 417)
	ElseIf $zhed = 10 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 445)
	ElseIf $zhed = 11 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 473)		
	ElseIf $zhed = 12 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 501)		
	ElseIf $zhed = 13 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 530)		
	ElseIf $zhed = 14 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 557)		
	ElseIf $zhed = 15 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 586)		
	ElseIf $zhed = 16 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 612)		
	ElseIf $zhed = 17 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 642)		
	ElseIf $zhed = 18 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 669)		
	ElseIf $zhed = 19 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 697)		
	ElseIf $zhed = 20 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 725)		
	ElseIf $zhed = 21 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 754)	
	ElseIf $zhed = 22 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 781)	
	ElseIf $zhed = 23 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 809)	
	ElseIf $zhed = 24 Then
		IniWrite("settings.ini", "$heroes", "$zhed", 838)		
	EndIf	
	
	If $vekk = 1 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 194)
	ElseIf $vekk = 2 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 221)		
	ElseIf $vekk = 3 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 252)		
	ElseIf $vekk = 4 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 277)		
	ElseIf $vekk = 5 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 306)		
	ElseIf $vekk = 6 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 333)	
	ElseIf $vekk = 7 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 361)		
	ElseIf $vekk = 8 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 390)
	ElseIf $vekk = 9 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 417)
	ElseIf $vekk = 10 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 445)
	ElseIf $vekk = 11 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 473)		
	ElseIf $vekk = 12 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 501)		
	ElseIf $vekk = 13 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 530)		
	ElseIf $vekk = 14 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 557)		
	ElseIf $vekk = 15 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 586)		
	ElseIf $vekk = 16 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 612)		
	ElseIf $vekk = 17 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 642)		
	ElseIf $vekk = 18 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 669)		
	ElseIf $vekk = 19 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 697)		
	ElseIf $vekk = 20 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 725)		
	ElseIf $vekk = 21 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 754)	
	ElseIf $vekk = 22 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 781)	
	ElseIf $vekk = 23 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 809)	
	ElseIf $vekk = 24 Then
		IniWrite("settings.ini", "$heroes", "$vekk", 838)		
	EndIf
	
	If $zenmai = 1 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 194)
	ElseIf $zenmai = 2 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 221)		
	ElseIf $zenmai = 3 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 252)		
	ElseIf $zenmai = 4 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 277)		
	ElseIf $zenmai = 5 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 306)		
	ElseIf $zenmai = 6 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 333)	
	ElseIf $zenmai = 7 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 361)		
	ElseIf $zenmai = 8 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 390)
	ElseIf $zenmai = 9 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 417)
	ElseIf $zenmai = 10 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 445)
	ElseIf $zenmai = 11 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 473)		
	ElseIf $zenmai = 12 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 501)		
	ElseIf $zenmai = 13 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 530)		
	ElseIf $zenmai = 14 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 557)		
	ElseIf $zenmai = 15 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 586)		
	ElseIf $zenmai = 16 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 612)		
	ElseIf $zenmai = 17 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 642)		
	ElseIf $zenmai = 18 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 669)		
	ElseIf $zenmai = 19 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 697)		
	ElseIf $zenmai = 20 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 725)		
	ElseIf $zenmai = 21 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 754)	
	ElseIf $zenmai = 22 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 781)	
	ElseIf $zenmai = 23 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 809)	
	ElseIf $zenmai = 24 Then
		IniWrite("settings.ini", "$heroes", "$zenmai", 838)		
	EndIf
	
	If $anton = 1 Then
		IniWrite("settings.ini", "$heroes", "$anton", 194)
	ElseIf $anton = 2 Then
		IniWrite("settings.ini", "$heroes", "$anton", 221)		
	ElseIf $anton = 3 Then
		IniWrite("settings.ini", "$heroes", "$anton", 252)		
	ElseIf $anton = 4 Then
		IniWrite("settings.ini", "$heroes", "$anton", 277)		
	ElseIf $anton = 5 Then
		IniWrite("settings.ini", "$heroes", "$anton", 306)		
	ElseIf $anton = 6 Then
		IniWrite("settings.ini", "$heroes", "$anton", 333)	
	ElseIf $anton = 7 Then
		IniWrite("settings.ini", "$heroes", "$anton", 361)		
	ElseIf $anton = 8 Then
		IniWrite("settings.ini", "$heroes", "$anton", 390)
	ElseIf $anton = 9 Then
		IniWrite("settings.ini", "$heroes", "$anton", 417)
	ElseIf $anton = 10 Then
		IniWrite("settings.ini", "$heroes", "$anton", 445)
	ElseIf $anton = 11 Then
		IniWrite("settings.ini", "$heroes", "$anton", 473)		
	ElseIf $anton = 12 Then
		IniWrite("settings.ini", "$heroes", "$anton", 501)		
	ElseIf $anton = 13 Then
		IniWrite("settings.ini", "$heroes", "$anton", 530)		
	ElseIf $anton = 14 Then
		IniWrite("settings.ini", "$heroes", "$anton", 557)		
	ElseIf $anton = 15 Then
		IniWrite("settings.ini", "$heroes", "$anton", 586)		
	ElseIf $anton = 16 Then
		IniWrite("settings.ini", "$heroes", "$anton", 612)		
	ElseIf $anton = 17 Then
		IniWrite("settings.ini", "$heroes", "$anton", 642)		
	ElseIf $anton = 18 Then
		IniWrite("settings.ini", "$heroes", "$anton", 669)		
	ElseIf $anton = 19 Then
		IniWrite("settings.ini", "$heroes", "$anton", 697)		
	ElseIf $anton = 20 Then
		IniWrite("settings.ini", "$heroes", "$anton", 725)		
	ElseIf $anton = 21 Then
		IniWrite("settings.ini", "$heroes", "$anton", 754)	
	ElseIf $anton = 22 Then
		IniWrite("settings.ini", "$heroes", "$anton", 781)	
	ElseIf $anton = 23 Then
		IniWrite("settings.ini", "$heroes", "$anton", 809)	
	ElseIf $anton = 24 Then
		IniWrite("settings.ini", "$heroes", "$anton", 838)		
	EndIf
	
	If $kahmu = 1 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 194)
	ElseIf $kahmu = 2 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 221)		
	ElseIf $kahmu = 3 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 252)		
	ElseIf $kahmu = 4 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 277)		
	ElseIf $kahmu = 5 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 306)		
	ElseIf $kahmu = 6 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 333)	
	ElseIf $kahmu = 7 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 361)		
	ElseIf $kahmu = 8 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 390)
	ElseIf $kahmu = 9 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 417)
	ElseIf $kahmu = 10 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 445)
	ElseIf $kahmu = 11 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 473)		
	ElseIf $kahmu = 12 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 501)		
	ElseIf $kahmu = 13 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 530)		
	ElseIf $kahmu = 14 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 557)		
	ElseIf $kahmu = 15 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 586)		
	ElseIf $kahmu = 16 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 612)		
	ElseIf $kahmu = 17 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 642)		
	ElseIf $kahmu = 18 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 669)		
	ElseIf $kahmu = 19 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 697)		
	ElseIf $kahmu = 20 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 725)		
	ElseIf $kahmu = 21 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 754)	
	ElseIf $kahmu = 22 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 781)	
	ElseIf $kahmu = 23 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 809)	
	ElseIf $kahmu = 24 Then
		IniWrite("settings.ini", "$heroes", "$kahmu", 838)		
	EndIf

	IniWrite("settings.ini", "$run", "$run", $npcs)

	IniWrite("settings.ini", "$mousespeed", "$mousespeed", $mousespeed)
	IniWrite("settings.ini", "$delay", "$delayreward", $delayreward)
	IniWrite("settings.ini", "$delay", "$delayrecovery", $delayrecovery)
	
	IniWrite("settings.ini", "misc", "$emotes", $emotes)
	
EndFunc

While 1
	_main();
	Exit
WEnd