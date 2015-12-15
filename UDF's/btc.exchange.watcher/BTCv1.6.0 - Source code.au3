#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <Array.au3>
#NoTrayIcon
$debug = 0
$ini = @AppDataDir & '\btcwatch\btcwatch.ini'
If Not FileExists(@AppDataDir & '\btcwatch\btcwatch.ini') Then
	DirCreate(@AppDataDir & '\btcwatch')
	IniWrite($ini, 'Values', 'Buyalert', 0)
	IniWrite($ini, 'Values', 'Sellalert', 0)
	IniWrite($ini, 'Values', 'Chosendelay', 11)
EndIf
Global $loadedbuy
Global $loadedsell
Global $loadeddelay
Global $delaychoice
Global $delaychoice = $loadeddelay
Global $soundcount
Global $alarm
Global $alarm2
Global $delay
$delay = 0
Global $open
Global $clear[10]
Global $first[10]
Global $sell[10]
Global $sellprice[10]
Global $buy[10]
Global $buyprice[10]
Global $roundedbuy[10]
Global $roundedsell[10]
Global $audioallowed
Global $first = $clear
Global $sell = $clear
Global $sellprice = $clear
Global $buy = $clear
Global $buyprice = $clear
Global $roundedbuy = $clear
Global $roundedsell = $clear
Global $buyalertlevel
Global $sellalertlevel
Global $buyalert
Global $sellalert
Loadsettings()
$sound = @WindowsDir & "\media\tada.wav"
$errcount = 0
#Region ### START Koda GUI section ### Form=C:\Users\techwg\Documents\btc.kxf
Global $Form1 = GUICreate("Bitcoin Exchange Watcher V 1.5.2", 335, 155)
$Label1 = GUICtrlCreateLabel("Bitcoin Exchange Rate", 45, 8, 218, 28)
GUICtrlSetFont(-1, 15, 800, 0, "Arial")
$Label2 = GUICtrlCreateLabel("Ask rate:", 175, 40, 75, 20)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
$Label3 = GUICtrlCreateLabel("Bid rate:", 16, 40, 75, 20)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")
Global $selllabel = GUICtrlCreateLabel("0.00", 245, 40, 70, 28)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
Global $buylabel = GUICtrlCreateLabel("0.00", 88, 40, 70, 28)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
Global $sellalert = GUICtrlCreateInput($loadedsell, 262, 70, 49, 21)
Global $alerttoggle = GUICtrlCreateCheckbox("Audio Alerting", 5, 95, 97, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetState(-1, $GUI_CHECKED)
Global $toptoggle = GUICtrlCreateCheckbox("Always on top", 110, 95, 100, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$warn1 = GUICtrlCreateLabel("Ask Rate Alert:", 170, 70, 90, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $buyalert = GUICtrlCreateInput($loadedbuy, 100, 70, 49, 21)
$warn2 = GUICtrlCreateLabel("Bid Rate Alert:", 8, 70, 90, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $problem = GUICtrlCreateLabel("Problem connecting, Retrying...", 5, 118, 170, 20)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
GUICtrlSetState($problem, $GUI_HIDE)
$toolsmenu = GUICtrlCreateMenu("Tools")
$convertmenu = GUICtrlCreateMenuItem("Launch BTC Converter", $toolsmenu)
$minimenu = GUICtrlCreateMenuItem('Mini "on top" watcher', $toolsmenu)
$optionsmenu = GUICtrlCreateMenu("Options")
$MenuItem4 = GUICtrlCreateMenuItem("Refresh data delay", $optionsmenu)
$savemenu = GUICtrlCreateMenuItem("Save current settings", $optionsmenu)
$loadmenu = GUICtrlCreateMenuItem("Reload saved settings", $optionsmenu)
$clearmenu = GUICtrlCreateMenuItem("Clear saved settings", $optionsmenu)
$MenuItem1 = GUICtrlCreateMenu("Help")
$MenuItem2 = GUICtrlCreateMenuItem("About", $MenuItem1)
$MenuItem3 = GUICtrlCreateMenuItem("Donate", $MenuItem1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
While 1
	Global $nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $convertmenu
			convert()
		Case $MenuItem4
			settings()
		Case $savemenu
			Savesettings()
		Case $loadmenu
			Loadsettings()
		Case $minimenu
			mini()
		Case $clearmenu
			Resetsettings()
		Case $toptoggle
			If GUICtrlRead($toptoggle) = 1 Then
				WinSetOnTop('[TITLE:Bitcoin Exchange Watcher V 1.5.2; CLASS:AutoIt v3 GUI]', '', 1)
			Else
				WinSetOnTop('[TITLE:Bitcoin Exchange Watcher V 1.5.2; CLASS:AutoIt v3 GUI]', '', 0)
			EndIf
		Case 0
			If $delay = 0 Then Getrates()
			If $delay = $delaychoice Then Getrates()
			If $nMsg = -3 Then Exit
			If $nMsg = 9 Then about()
			Sleep(1000)
			If $nMsg = -3 Then Exit
			If $nMsg = 9 Then about()
			$delay = $delay + 1
			Global $buyalertlevel = GUICtrlRead($buyalert)
			Global $sellalertlevel = GUICtrlRead($sellalert)
			Global $alarm = 0
			Global $alarm2 = 0
			If $buyalertlevel + $sellalertlevel <> 0 Then
				If $buyalertlevel <> 0 Then
					If $buyalertlevel >= $roundedbuy Then $alarm = 1
				EndIf
				If $sellalertlevel <> 0 Then
					If $sellalertlevel <= $roundedsell Then $alarm2 = 1
				EndIf
				If $first[0] > 5 Then
					If $alarm = 1 Then
						$audioallowed = GUICtrlRead($alerttoggle)
						If $audioallowed = 1 Then
							Beep(500, 500)
							Beep(740, 500)
						EndIf
					EndIf
					If $alarm2 = 1 Then
						$audioallowed = GUICtrlRead($alerttoggle)
						If $audioallowed = 1 Then
							Beep(740, 500)
							Beep(500, 500)
						EndIf
					EndIf
				EndIf
			EndIf
		Case $MenuItem2
			about()
		Case $MenuItem3
			GUISetState(@SW_DISABLE, $Form1)
			$donateanswer = MsgBox(4, 'Donate', 'To donate to me, press "Yes" and my bitcoin address will copy to your clipboard. Thank you!')
			GUISetState(@SW_ENABLE, $Form1)
			If $donateanswer = 6 Then ClipPut('1MTkF9ZTcXtgvQX245TwTL2Ko3NMvJHz6P')
	EndSwitch
WEnd
Func about()
	GUISetState(@SW_DISABLE, $Form1)
	MsgBox(0, 'Bitcoin Exchange Watcher V 1.5.2', 'Created by Morthawt ( www.morthawt.com )' & @CRLF & 'Close this about screen to continue checking the rates.')
	GUISetState(@SW_ENABLE, $Form1)
EndFunc   ;==>about
Func Getrates()
	Global $delay = 1
	Global $first = $clear
	Global $sell = $clear
	Global $sellprice = $clear
	Global $buy = $clear
	Global $buyprice = $clear
	Global $roundedbuy = $clear
	Global $roundedsell = $clear
	Global $buyalertlevel = GUICtrlRead($buyalert)
	Global $sellalertlevel = GUICtrlRead($sellalert)
	If $nMsg = -3 Then Exit
	If $nMsg = 9 Then about()
	$file = @ScriptDir & '\BTCrates.txt'
	$get = InetGet('https://data.mtgox.com/api/2/BTCUSD/money/ticker', $file, 2)
	ConsoleWrite('>Error code: ' & @error & @crlf & @crlf & '@@ Trace(197) :    	If $get <> 0 Then' & $get   & @crlf) ;### Trace Console
	If $get = 0 Then
		GUICtrlSetState($problem, $GUI_SHOW)
		Sleep(1000)
		$errcount = $errcount + 1
		If $errcount = 5 Then
			GUISetState(@SW_DISABLE, $Form1)
			MsgBox(0, 'Error', 'There was an error downloading the exchange rates.')
			GUISetState(@SW_ENABLE, $Form1)
			Exit
		EndIf
	EndIf
	If $get > 0 Then $errcount = 0
	Global $open = FileRead($file)
	If $debug = 1 Then
		FileWrite('debug.txt', $open & @CRLF)
	EndIf
	FileDelete($file)
	If $nMsg = -3 Then Exit
ConsoleWrite('>Error code: ' & @error & @crlf & @crlf & '@@ Trace(197) :    	If $get <> 0 Then' & $open   & @crlf) ;### Trace Console
	If $get <> 0 Then
		GUICtrlSetState($problem, $GUI_HIDE)
		Global $first = StringSplit($open, ',')
;~ 		_ArrayDisplay($first, '$first')
		If $first[0] > 5 Then
			Global $sell = StringSplit($first[29], ':')
;~ 			_ArrayDisplay($sell, '$sell')
			If $sell[0] > 1 Then
				Global $sellprice = $sell[3]
				ConsoleWrite('$sellprice' & $sellprice)
			EndIf
			Global $buy = StringSplit($first[17], ':')
;~ 			_ArrayDisplay($buy, '$buy')
			If $buy[0] > 1 Then
				Global $buyprice = $buy[3]
				ConsoleWrite('$buyprice' & $buyprice)
			EndIf
			Global $roundedbuy = Round(StringReplace($buyprice, '"', ''), 2)
			Global $roundedsell = Round(StringReplace($sellprice, '"', ''), 2)
			ConsoleWrite('$roundedbuy' & $roundedbuy)
			ConsoleWrite('$roundedsell' & $roundedsell)
		EndIf
		GUICtrlSetData($selllabel, '$' & $roundedsell)
		GUICtrlSetData($buylabel, '$' & $roundedbuy)
		Global $alarm = 0
		Global $alarm2 = 0
	EndIf
EndFunc   ;==>Getrates
Func settings()
	GUISetState(@SW_DISABLE, $Form1)

	#Region ### START Koda GUI section ### Form=c:\users\techwg\documents\settings.kxf
	$Settings = GUICreate("Settings", 323, 111)
	$Label1 = GUICtrlCreateLabel("Choose the delay between getting live data online:", 8, 16, 292, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	Global $delayinput = GUICtrlCreateInput($delaychoice - 1, 168, 40, 41, 21)
	$Label2 = GUICtrlCreateLabel("In seconds:", 72, 40, 70, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$settingok = GUICtrlCreateButton("Ok", 48, 72, 75, 25, BitOR($BS_DEFPUSHBUTTON, $WS_GROUP))
	$settingcancel = GUICtrlCreateButton("Cancel", 200, 72, 75, 25, $WS_GROUP)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	While 1
		$nMsg2 = GUIGetMsg()
		Switch $nMsg2
			Case $GUI_EVENT_CLOSE
				GUISetState(@SW_ENABLE, $Form1)
				GUIDelete($Settings)
				$delay = 0
				ExitLoop
			Case $settingcancel
				GUISetState(@SW_ENABLE, $Form1)
				GUIDelete($Settings)
				$delay = 0
				ExitLoop
			Case $settingok
				GUISetState(@SW_ENABLE, $Form1)
				$delaychoice = Round(GUICtrlRead($delayinput), 0) + 1
				GUIDelete($Settings)
				$delay = 0
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>settings
Func Savesettings()
	Global $buyalertlevel = GUICtrlRead($buyalert)
	Global $sellalertlevel = GUICtrlRead($sellalert)
	IniWrite($ini, 'Values', 'Buyalert', $buyalertlevel)
	IniWrite($ini, 'Values', 'Sellalert', $sellalertlevel)
	IniWrite($ini, 'Values', 'Chosendelay', $delaychoice)
EndFunc   ;==>Savesettings
Func Loadsettings()
	$loadedbuy = IniRead($ini, 'Values', 'Buyalert', 0)
	$loadedsell = IniRead($ini, 'Values', 'Sellalert', 0)
	$loadeddelay = IniRead($ini, 'Values', 'Chosendelay', 11)
	GUICtrlSetData($buyalert, $loadedbuy)
	GUICtrlSetData($sellalert, $loadedsell)
	$delaychoice = $loadeddelay
EndFunc   ;==>Loadsettings
Func Resetsettings()
	IniWrite($ini, 'Values', 'Buyalert', 0)
	IniWrite($ini, 'Values', 'Sellalert', 0)
	IniWrite($ini, 'Values', 'Chosendelay', 11)
	GUICtrlSetData($buyalert, 0)
	GUICtrlSetData($sellalert, 0)
	$delaychoice = 11
EndFunc   ;==>Resetsettings
Func convert()
	GUISetState(@SW_DISABLE, $Form1)


	#include <ButtonConstants.au3>
	#include <EditConstants.au3>
	#include <GUIConstantsEx.au3>
	#include <StaticConstants.au3>
	#include <WindowsConstants.au3>
	#Region ### START Koda GUI section ### Form=c:\users\techwg\documents\conversion.kxf
	$convert = GUICreate("Bitcoin Conversions", 441, 248)
	$Group1 = GUICtrlCreateGroup("Bitcoin - Currency (Based on current asking price)", 16, 8, 409, 89)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$Label1 = GUICtrlCreateLabel("Bitcoins", 24, 32, 49, 17)
	$btc = GUICtrlCreateInput("1", 24, 56, 81, 21)
	$Label2 = GUICtrlCreateLabel("Currency Value:", 312, 32, 94, 17)
	$curend = GUICtrlCreateInput("", 312, 56, 81, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
	$curcode1 = GUICtrlCreateInput("USD", 176, 56, 81, 21, BitOR($ES_UPPERCASE, $ES_AUTOHSCROLL))
	GUICtrlSetTip(-1, 'Use a three character currency code such as:' & @CRLF & 'AUD CAD GBP EUR USD')
	$Label6 = GUICtrlCreateLabel("Currency code:", 176, 32, 90, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Currency - Bitcoins (Based on current bidding price)", 16, 144, 409, 89)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$Label3 = GUICtrlCreateLabel("Bitcoin value:", 320, 168, 82, 17)
	$Input1 = GUICtrlCreateInput("1", 184, 192, 81, 21)
	$Label4 = GUICtrlCreateLabel("Currency amount:", 176, 168, 103, 17)
	$Bitcoinend = GUICtrlCreateInput("", 320, 192, 81, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
	$curcode2 = GUICtrlCreateInput("USD", 40, 192, 81, 21, BitOR($ES_UPPERCASE, $ES_AUTOHSCROLL))
	GUICtrlSetTip(-1, 'Use a three character currency code such as:' & @CRLF & 'AUD CAD GBP EUR USD')
	$Label5 = GUICtrlCreateLabel("Currency code:", 40, 168, 90, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Button1 = GUICtrlCreateButton("Convert Now", 96, 112, 99, 25, BitOR($BS_DEFPUSHBUTTON, $WS_GROUP))
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	$Button2 = GUICtrlCreateButton("Close", 248, 112, 99, 25, $WS_GROUP)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	While 1
		$nMsgc = GUIGetMsg()
		Switch $nMsgc
			Case $GUI_EVENT_CLOSE
				GUISetState(@SW_ENABLE, $Form1)
				GUIDelete($convert)
				$delay = 0
				ExitLoop
			Case $Button2
				GUISetState(@SW_ENABLE, $Form1)
				GUIDelete($convert)
				$delay = 0
				ExitLoop
			Case $Button1
				Local $codeerror = 0
				$convapi1 = InetGet('http://www.google.com/ig/calculator?q=' & $roundedsell * GUICtrlRead($btc) & 'USD' & '=?' & GUICtrlRead($curcode1), @TempDir & '\btcwatchconv.txt', 1)
				$convfile1 = FileRead(@TempDir & '\btcwatchconv.txt')
				FileDelete(@TempDir & '\btcwatchconv.txt')
				;MsgBox(0,0,$test2)
				$split1 = StringSplit($convfile1, '"')
				If $split1[0] > 6 Then
					$split2 = StringSplit($split1[4], ' ')
					If $split2[0] > 0 Then
						$roundedsplit1 = Round($split2[1], 2)
						;MsgBox(0, 0, $roundedsplit1)
					EndIf
					GUICtrlSetData($curend, $roundedsplit1)
					If $roundedsplit1 = 0 Then $codeerror = 1
				EndIf
				$convapi2 = InetGet('http://www.google.com/ig/calculator?q=' & GUICtrlRead($Input1) & GUICtrlRead($curcode2) & '=?USD', @TempDir & '\btcwatchconv.txt', 1)
				$convfile2 = FileRead(@TempDir & '\btcwatchconv.txt')
				FileDelete(@TempDir & '\btcwatchconv.txt')
				;MsgBox(0,0,$test2)
				$split12 = StringSplit($convfile2, '"')
				If $split12[0] > 6 Then
					$split22 = StringSplit($split12[4], ' ')
					If $split22[0] > 0 Then
						$roundedsplit2 = Round($split22[1], 8)
						;MsgBox(0, 0, $roundedsplit1)
					EndIf
					GUICtrlSetData($Bitcoinend, Round($roundedsplit2 / $roundedbuy, 8))
					If Round($roundedsplit2 / $roundedbuy, 8) = 0 Then $codeerror = 1
					If $codeerror = 1 Then MsgBox(0, 'Error', 'Please make sure the currency codes are typed correctly')
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>convert
Func mini()
	GUISetState(@SW_DISABLE, $Form1)
	GUISetState(@SW_HIDE, $Form1)
	$delay = 0


	#Region ### START Koda GUI section ### Form=C:\Users\techwg\Documents\miniscreen.kxf
	$mini = GUICreate("MinX", 172, 45)
	$minibuy = GUICtrlCreateLabel("Buy: $0.00", 5, 5, 80, 22)
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	$minisell = GUICtrlCreateLabel("Sell: $0.00", 90, 5, 80, 22)
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	Global $minialerttoggle = GUICtrlCreateCheckbox("Audio Alerting", 8, 23, 97, 17)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	If GUICtrlRead($alerttoggle) = 1 Then
		GUICtrlSetState(-1, $GUI_CHECKED)
	EndIf
	GUISetState(@SW_SHOW)
	WinSetOnTop('[CLASS:AutoIt v3 GUI;TITLE:MinX]', '', 1)
	#EndRegion ### END Koda GUI section ###
	While 1
		$nMsgmini = GUIGetMsg()
		Switch $nMsgmini
			Case $GUI_EVENT_CLOSE
				$delay = 0
				;GUISetState(@SW_ENABLE, $Form1)
				GUIDelete($mini)
				GUISetState(@SW_SHOW, $Form1)
				GUISetState(@SW_ENABLE, $Form1)
				ExitLoop
			Case 0
				If $delay = 0 Then Getrates()
				If $delay = $delaychoice Then Getrates()
				Sleep(1000)
				If $nMsgmini = -3 Then
					$delay = 0
					;GUISetState(@SW_ENABLE, $Form1)
					GUIDelete($mini)
					GUISetState(@SW_SHOW, $Form1)
					GUISetState(@SW_ENABLE, $Form1)
					ExitLoop
				EndIf
				$delay = $delay + 1
				Global $buyalertlevel = GUICtrlRead($buyalert)
				Global $sellalertlevel = GUICtrlRead($sellalert)
				Global $alarm = 0
				Global $alarm2 = 0
				GUICtrlSetData($minibuy, 'Bid: $' & $roundedbuy)
				GUICtrlSetData($minisell, 'Ask: $' & $roundedsell)
				If $buyalertlevel + $sellalertlevel <> 0 Then
					If $buyalertlevel <> 0 Then
						If $buyalertlevel >= $roundedbuy Then $alarm = 1
					EndIf
					If $sellalertlevel <> 0 Then
						If $sellalertlevel <= $roundedsell Then $alarm2 = 1
					EndIf
					If $first[0] > 5 Then
						If $alarm = 1 Then
							$audioallowed = GUICtrlRead($minialerttoggle)
							If $audioallowed = 1 Then
								Beep(500, 500)
								Beep(740, 500)
							EndIf
						EndIf
						If $alarm2 = 1 Then
							$audioallowed = GUICtrlRead($minialerttoggle)
							If $audioallowed = 1 Then
								Beep(740, 500)
								Beep(500, 500)
							EndIf
						EndIf
					EndIf
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>mini