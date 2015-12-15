

#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <NomadMemory.au3>
#include <tt6.au3>

$bot_title = "Pro's Chest Bot v2.9"

;// FUNCTIONS //
$identsellitems = 0
$firststart = 0
$stop = 0
$Radio1 = 0
$Radio2 = 0
$deposit = 0
$locks = 0
$percent = 0
$Status = "Putting Settings"
;// RUN MANAGEMENT //
$runtimes = 15
$stoptimes = 50
$run = 0
$Opened = 0
;// DEPOSIT //
$deposit_nr = 250
;// KEY BINDINGS //
$key_attack = "space"
$key_inventory = "F9"
$key_strafeleft = "q"
$key_runskill = "1"
$key_reverse = "x"
$key_guild = "g"
$key_worldmap = "m"
$key_foe = "c"
$key_item = "NUMPAD0"
$key_ally = "v"
$key_enter = "enter"
$key_run = "r"
$Client_x = 239
$Client_y = 150

Global $Secs, $Mins, $Hour, $Time, $aTime, $Hour2, $Mins2, $Secs2, $timer2, $Stuck, $Run, $Status

$Stuck = 0


; [INI READ]
;##################### RUN MANAGEMENT #############################################################
$runtimes_ini = IniRead ("Settings.ini", "Run Management", "$runtimes", "NotFound")
if $runtimes_ini == "NotFound" Then $runtimes = $runtimes
$stoptimes_ini = IniRead ("Settings.ini", "Run Management", "$stoptimes", "NotFound")
if $stoptimes_ini == "NotFound" Then $stoptimes = $stoptimes
;##################### Position ###################################################################
$Client_x_ini = IniRead ("Settings.ini","Position","$Client_x", "NotFound")
if $Client_x_ini == "NotFound" Then $Client_x_ini = $Client_x
$Client_y_ini = IniRead ("Settings.ini","Position","$Client_y", "NotFound")
if $Client_x_ini == "NotFound" Then $Client_y_ini = $Client_y
;##################### FUNCTIONS ##################################################################
$identsellitems_ini = IniRead ("Settings.ini", "Functions", "$identsellitems", "NotFound")
if $identsellitems_ini == "NotFound" Then $identsellitems_ini = $identsellitems
$stop_ini = IniRead ("Settings.ini", "Functions", "$stop", "NotFound")
if $stop_ini == "NotFound" Then $stop_ini = $stop
$Radio1_ini = IniRead ("Settings.ini", "Functions", "$Radio1", "NotFound")
if $Radio1_ini == "NotFound" Then $Radio1_ini = $Radio1
$Radio2_ini = IniRead ("Settings.ini", "Functions", "$Radio2", "NotFound")
if $Radio2_ini == "NotFound" Then $Radio2_ini = $Radio2
$locks_ini = IniRead ("Settings.ini", "Functions", "$locks", "NotFound")
if $locks_ini == "NotFound" Then $locks_ini = $locks
$percent_ini = IniRead ("Settings.ini", "Functions", "$percent", "NotFound")
if $percent_ini == "NotFound" Then $percent_ini = $percent
;##################### DEPOSIT ####################################################################
$deposit_ini = IniRead ("Settings.ini", "Deposit", "$deposit", "NotFound")
if $deposit_ini == "NotFound" Then $deposit_ini = $deposit
$deposit_nr_ini = IniRead ("Settings.ini", "Deposit", "$deposit_nr", "NotFound")
if $deposit_nr_ini == "NotFound" Then $deposit_nr_ini = $deposit_nr
;##################### KEY SETTINGS ###############################################################
$key_attack_ini = IniRead ("Settings.ini", "Key Bindings", "$key_attack", "NotFound")
if $key_attack_ini == "NotFound" Then $key_attack_ini = $key_attack
$key_inventory_ini = IniRead ("Settings.ini", "Key Bindings", "$key_inventory", "NotFound")
if $key_inventory_ini == "NotFound" Then $key_inventory_ini = $key_inventory
$key_reverse_ini = IniRead ("Settings.ini", "Key Bindings", "$key_reverse", "NotFound")
if $key_reverse_ini == "NotFound" Then $key_reverse_ini = $key_reverse
$key_strafeleft_ini = IniRead ("Settings.ini", "Key Bindings", "$key_strafeleft", "NotFound")
if $key_strafeleft_ini == "NotFound" Then $key_strafeleft_ini = $key_strafeleft
$key_runskill_ini = IniRead ("Settings.ini", "Key Bindings", "$key_straferight", "NotFound")
if $key_runskill_ini == "NotFound" Then $key_runskill_ini = $key_runskill
$key_item_ini = IniRead ("Settings.ini", "Key Bindings", "$key_item", "NotFound")
if $key_item_ini == "NotFound" Then $key_item_ini = $key_item
$key_ally_ini = IniRead ("Settings.ini", "Key Bindings", "$key_ally", "NotFound")
if $key_ally_ini == "NotFound" Then $key_ally_ini = $key_ally
$key_enter_ini = IniRead ("Settings.ini", "Key Bindings", "$key_enter", "NotFound")
if $key_enter_ini == "NotFound" Then $key_enter_ini = $key_enter
$key_run_ini = IniRead ("Settings.ini", "Key Bindings", "$key_run", "NotFound")
if $key_run_ini == "NotFound" Then $key_run_ini = $key_run

	
;##################### GUI START ##################################################################
GUICreate($bot_title, 327, 325, $Client_x_ini, $Client_y_ini)
GUICtrlCreatePic("gw001.jpg", 0, 8, 120, 312, BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS))
GUICtrlCreateTab(125, 8, 200, 280)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlCreateTabItem("Settings")
	GUICtrlCreateGroup("Sell after", 134, 33, 88, 57)
		GUICtrlCreateLabel("Chests", 185, 57, 40, 17)
		$runtimes_GUI = GUICtrlCreateInput($runtimes_ini, 150, 56, 30, 17)
		GUICtrlCreateGroup("Go out:", 229, 33, 88, 57)
		$Radio1_GUI = GUICtrlCreateRadio("Normal", 240, 45, 50, 20)
			GUICtrlSetState(-3, $GUI_UNCHECKED)
		$Radio2_GUI = GUICtrlCreateRadio("Fast", 240, 65, 50, 20)
			GUICtrlSetState(-3, $GUI_UNCHECKED)
	GUICtrlCreateGroup("Functions", 134, 92, 183, 190)
		$identsellitems_GUI = GUICtrlCreateCheckbox("Ident/ Sell ", 150, 110, 70, 17)
		$stop_GUI = GUICtrlCreateCheckbox("Stop Bot after:", 150, 150, 85, 17)
		$Chest_GUI = GUICtrlCreateLabel("Chests", 273, 153, 35, 17)
		$stoptimes_GUI = GUICtrlCreateInput($stoptimes_ini, 240, 150, 30, 17)
		$deposit_GUI = GUICtrlCreateCheckbox("Deposit after:", 150, 130, 80, 17)
		$after_GUI = GUICtrlCreateLabel("Runs", 273, 133, 35, 17)
		$deposit_nr_GUI = GUICtrlCreateInput($deposit_nr_ini, 240, 130, 30, 17)
			GUICtrlCreateGroup("Estimate Runs", 145, 180, 160, 80)
				GUICtrlCreateLabel("Amount of Locks:", 150, 200, 90, 17)
				$locks_GUI = GUICtrlCreateInput($locks_ini, 240, 200, 30, 17)
				GUICtrlCreateLabel("Chance to retain:", 150, 220, 90, 17)
				$percent_GUI = GUICtrlCreateInput($percent_ini, 240, 220, 30, 17)	
		$button_estimate = GUICtrlCreateButton("Estimate", 250, 240, 50, 17)
GUICtrlCreateTabItem("Keys")
	GUICtrlCreateGroup("Controls", 134, 33, 183, 248)
		GUICtrlCreateLabel("Attack/Interact", 142, 57, 76, 17)
		$Key_Attack_GUI = GUICtrlCreateInput($key_attack_ini, 246, 53, 65, 21)
		GUICtrlCreateLabel("Toggle all Bags", 142, 81, 77, 17)
		$Key_Inventory_GUI = GUICtrlCreateInput($key_inventory_ini, 246, 77, 65, 21)
		GUICtrlCreateLabel("Strafe Left", 142, 105, 53, 17)
		$Key_StrafeLeft_GUI = GUICtrlCreateInput($Key_StrafeLeft_ini, 246, 101, 65, 21)
		GUICtrlCreateLabel("Runskill", 142, 129, 60, 17)
		$Key_runskill_GUI = GUICtrlCreateInput($Key_runskill_ini, 246, 125, 65, 21)
		GUICtrlCreateLabel("Reverse Direction", 142, 153, 89, 17)
		$Key_Reverse_GUI = GUICtrlCreateInput($key_reverse_ini, 246, 149, 65, 21)
		GUICtrlCreateLabel("Target nearest Item", 142, 177, 97, 17)
		$Key_Item_GUI = GUICtrlCreateInput($key_item_ini, 246, 173, 65, 21)
		GUICtrlCreateLabel("Target nearest Ally", 142, 201, 92, 17)
		$Key_Ally_GUI = GUICtrlCreateInput($key_ally_ini, 246, 197, 65, 21)
		GUICtrlCreateLabel("Open Chat", 142, 225, 92, 17)
		$Key_enter_GUI = GUICtrlCreateInput($key_enter_ini, 246, 221, 65, 21)
		GUICtrlCreateLabel("Toggle Run", 142, 249, 92, 17)
		$Key_run_GUI = GUICtrlCreateInput($key_run_ini, 246, 245, 65, 21)
$Statistics = GUICtrlCreateTabItem("Statistics")
	GUICtrlCreateGroup("Runtime", 134, 33, 88, 50)
		$RunningTime = GUICtrlCreateLabel("00:00:00", 155, 55, 80, 30)
	GUICtrlCreateGroup("Average", 225, 33, 88, 50)
		$Average = GUICtrlCreateLabel("00:00:00", 245, 55, 80, 30)
	GUICtrlCreateGroup("Chests opened", 134, 88, 88, 50)
		$Opened_Chests = GUICtrlCreateLabel($Opened, 175, 110, 30, 30)
	GUICtrlCreateGroup("Chests left", 225, 88, 88, 50)
		$Label_RunsLeft = GUICtrlCreateLabel($runtimes_ini, 265, 110, 30, 30)
	GUICtrlCreateGroup("Run Nr.", 134, 143, 88, 50)
		$RunNr = GUICtrlCreateLabel($run, 175, 165, 30, 30)
	GUICtrlCreateGroup("Got Stuck", 225, 143, 88, 50)
		$Got_Stuck = GUICtrlCreateLabel("0", 265, 165, 30, 30)	
	GUICtrlCreateGroup("Progress", 134, 198, 174, 50)
		$stuck_progress = GUICtrlCreateLabel($Status, 150, 220, 160, 30)	
GUICtrlCreateTabItem("Info")
	GUICtrlCreateLabel("Notice the following Stuff:", 134, 33, 150, 30)
	$myedit = GUICtrlCreateEdit("  ::::::::::: INSTRUCTIONS :::::::::::" & @CRLF, 130, 50, 190, 230, $WS_VSCROLL + $ES_READONLY)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "::: INTERFACE:::" & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Inventory bags top left corner." & @CRLF, 1)	
	GUICtrlSetData($myedit, @CRLF, 1)	
	GUICtrlSetData($myedit, "Put small Ident-Kit in 1 row 1 col." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Merchant-window smallest width, largest hight, top left corner." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Storage-window right bottom corner." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)	
	GUICtrlSetData($myedit, "::: TIPPS :::" & @CRLF, 1)	
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Put in 3 Heros with Fall Back or/and Charge to run faster." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)	
	GUICtrlSetData($myedit, "Take Charge or Fall Back as runskill." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "If you run Hardmode then you should also take two Healer-Henchman." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)		
	GUICtrlSetData($myedit, "::: INFORMATION :::" & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Bot is for Boreal Station only." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Activate Backpack only at Merchant." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Put your Lockpicks in one of the Bags." & @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "Use the stop function if you want to stop the bot after a certain amout of runs" & @CRLF, 1)	
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "The deposit function will deposit your money to the storage after (default) 100 runs." & @CRLF, 1)	
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, @CRLF, 1)
	GUICtrlSetData($myedit, "::: Thx for using " & $bot_title & " :::" & @CRLF, 1)	
GUICtrlCreateTabItem("")
$button_start = GUICtrlCreateButton("Start Bot", 248, 293, 75, 25)
$button_save = GUICtrlCreateButton("Save", 170, 293, 75, 25)

	
GUISetState(@SW_SHOW)
;##################### GUI END ####################################################################

if $identsellitems_ini == 1 Then GUICtrlSetState($identsellitems_GUI, $GUI_CHECKED)
if $stop_ini == 1 Then GUICtrlSetState($stop_GUI, $GUI_CHECKED)
If $Radio1_ini == 1 Then GUICTrlSetState($Radio1_GUI, $GUI_CHECKED)
If $Radio2_ini == 1 Then GUICTrlSetState($Radio2_GUI, $GUI_CHECKED)
If $deposit_ini == 1 Then GUICtrlSetState($deposit_GUI, $GUI_CHECKED)	


Func _GUI()
	While 1
	$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $Button_Save
				save()
			Case $Button_Start
				endisable("dis")
				save()
				checkGW()
				ExitLoop
			Case $button_estimate
				save()
				Estimate()
		EndSwitch
	WEnd
	GUICtrlSetData ($BUTTON_START, "Exit = 'F8'")
EndFunc

Func endisable($mode)
	
	if $mode = "en" Then $endisable = $GUI_ENABLE
	if $mode = "dis" Then $endisable = $GUI_DISABLE
	
	GUICtrlSetState ($runtimes_GUI, $endisable)
	GUICtrlSetState ($stoptimes_GUI, $endisable)
	GUICtrlSetState ($locks_GUI, $endisable)
	GUICtrlSetState ($percent_GUI, $endisable)
	GUICtrlSetState ($identsellitems_GUI, $endisable)
	GUICtrlSetState ($stop_GUI, $endisable)
	GUICtrlSetState ($Radio1_GUI, $endisable)
	GUICtrlSetState ($Radio2_GUI, $endisable)
	GUICtrlSetState ($deposit_GUI, $endisable)
	GUICtrlSetState ($deposit_nr_GUI, $endisable)
	
	GUICtrlSetState ($Key_Attack_GUI, $endisable)
	GUICtrlSetState ($Key_Inventory_GUI, $endisable)
	GUICtrlSetState ($Key_StrafeLeft_GUI, $endisable)
	GUICtrlSetState ($Key_Runskill_GUI, $endisable)
	GUICtrlSetState ($Key_Reverse_GUI, $endisable)
	GUICtrlSetState ($Key_Item_GUI, $endisable)
	GUICtrlSetState ($Key_Ally_GUI, $endisable)
	GUICtrlSetState ($Key_enter_GUI, $endisable)
	GUICtrlSetState ($Key_run_GUI, $endisable)
	
	GUICtrlSetState ($Button_Save, $endisable)
	GUICtrlSetState ($Button_Start, $endisable)
	GUICtrlSetState ($button_estimate, $endisable)
	
EndFunc           

func save()

	Global $identsellitems = GUICtrlRead ($identsellitems_GUI)
	Global $stop = GUICtrlRead ($stop_GUI)
	Global $Radio1 = GUICtrlRead ($Radio1_GUI)
	Global $Radio2 = GUICtrlRead ($Radio2_GUI)
	Global $deposit = GUICtrlRead ($deposit_GUI)
	Global $deposit_nr = GUICtrlRead ($deposit_nr_GUI)
	Global $runtimes = GUICtrlRead ($runtimes_GUI)	
	Global $stoptimes = GUICtrlRead ($stoptimes_GUI)
	Global $locks = GUICtrlRead ($locks_GUI)
	Global $percent = GUICtrlRead ($percent_GUI)
	Global $key_attack = GUICtrlRead ($Key_Attack_GUI)
	Global $key_inventory = GUICtrlRead ($key_inventory_GUI)
	Global $key_reverse = GUICtrlRead ($key_reverse_GUI)
	Global $key_strafeleft = GUICtrlRead ($key_strafeleft_GUI)
	Global $key_runskill = GUICtrlRead ($key_runskill_GUI)
	Global $key_item = GUICtrlRead ($key_item_GUI)
	Global $key_ally = GUICtrlRead ($key_ally_GUI)
	Global $key_enter = GUICtrlRead ($key_enter_GUI)
	Global $key_run = GUICtrlRead ($key_run_GUI)
	
	IniWrite ("settings.ini", "Run Management", "$runtimes", "" & $runtimes & "")
	IniWrite ("settings.ini", "Run Management", "$stoptimes", "" & $stoptimes & "")
	IniWrite ("settings.ini", "Functions", "$identsellitems", "" & $identsellitems & "")
	IniWrite ("settings.ini", "Functions", "$stop", "" & $stop & "")
	IniWrite ("settings.ini", "Functions", "$Radio1", "" & $Radio1 & "")
	IniWrite ("settings.ini", "Functions", "$Radio2", "" & $Radio2 & "")
	IniWrite ("settings.ini", "Functions", "$locks", "" & $locks & "")
	IniWrite ("settings.ini", "Functions", "$percent", "" & $percent & "")
	IniWrite ("settings.ini", "Deposit", "$deposit", "" & $deposit & "")
	IniWrite ("settings.ini", "Deposit", "$deposit_nr", "" & $deposit_nr & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_attack", "" & $key_attack & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_inventory", "" & $key_inventory & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_reverse", "" & $key_reverse & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_strafeleft", "" & $key_strafeleft & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_runskill", "" & $key_runskill & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_item", "" & $key_item & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_ally", "" & $key_ally & "")
	IniWrite ("settings.ini", "Key Bindings", "$key_enter", "" & $key_enter & "")
	$xy = WinGetPos($bot_title)
	IniWrite ("settings.ini", "Position", "$Client_x", "" & $xy[0] & "")
	IniWrite ("settings.ini", "Position", "$Client_y", "" & $xy[1] & "")
	ControlSetText($bot_title, "", $Label_Runsleft, $runtimes)
	
EndFunc

Func fit()
	If ProcessExists ("Gw.exe") Then 
		Sleep(250)
		ControlMove($client, "", "", 0, 0, 600, 450)
	Else 
		endisable("dis")
		MsgBox (16, "Pro's Chest Bot ERROR", "Please start Guild Wars first!       ")
		endisable("en")
	EndIf
	
EndFunc

Func Estimate()
	
	$locks_ini = IniRead ("Settings.ini", "Functions", "$locks", "NotFound")
	$percent_ini = IniRead ("Settings.ini", "Functions", "$percent", "NotFound")
	
	$open_chests = $locks_ini
			
	While $locks_ini > 1
		
		$rest = $locks_ini * $percent_ini / 100
		$locks_ini = Int($rest)
		$open_chests = $open_chests + $locks_ini
		
	WEnd	
	
	ControlSetText($bot_title, "",$stoptimes_GUI, $open_chests)
		
EndFunc

Func checkGW()
	if ProcessExists ("Gw.exe") Then
		$PID0 = WinGetProcess("Guild Wars")
		$PROCESS0 = _MemoryOpen($PID0)
		Sleep (100)
		$a = 0
	Else
		GUICtrlSetState ($Button_Start, $GUI_DISABLE)
		MsgBox (16, "Pro's Chest Bot ERROR", "Please start Guild Wars first!       ")
;~ 		GUICtrlSetData ($BUTTON_START, "Start")
		GUICtrlSetState ($Button_Start, $GUI_ENABLE)
		endisable("en")
		_GUI()
	EndIf
EndFunc

Func SetRun()
	$Run = $Run + 1
	ControlSetText($bot_title,"", $RunNr, $Run)
	GUICtrlSetState($Statistics, $GUI_SHOW)
EndFunc
	
_GUI()
ConsoleWrite ($firststart)