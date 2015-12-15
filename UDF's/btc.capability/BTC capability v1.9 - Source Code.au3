#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $debug = 0

Global $sharesuccesspercent = 0.000000000208333333333333000000
Global $clear = 0
Global $first = $clear
Global $sell = $clear
Global $sellprice = $clear
Global $buy = $clear
Global $buyprice = $clear
Global $roundedbuy = $clear
Global $roundedsell
Global $measurementpool = 'g'
Global $measurementpersonal = 'm'
Global $actualpersonalhashrate
Global $actualpoolhashrate
Global $difficulty
Global $errcount
Global $errored
Global $timetoblock



;Created by Morthawt




#Region ### START Koda GUI section ### Form=C:\Users\techwg\Documents\personalability.kxf
Global $Form1 = GUICreate("BTC Capability V 1.9", 492, 305)
Global $Group2 = GUICtrlCreateGroup("Pool Total Hash Speed", 8, 8, 217, 81)
Global $poolspeedinput = GUICtrlCreateInput("0", 16, 56, 97, 21)
Global $Label1 = GUICtrlCreateLabel("Pool hash speed", 16, 32, 98, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $Radio1 = GUICtrlCreateRadio("Mhash/s", 128, 32, 89, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $Radio2 = GUICtrlCreateRadio("Ghash/s", 128, 56, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Group1 = GUICtrlCreateGroup("Your Personal Total Hash Speed", 8, 104, 217, 81)
Global $personalspeedinput = GUICtrlCreateInput("0", 16, 152, 97, 21)
Global $personalhashlabel = GUICtrlCreateLabel("Your hash speed", 16, 128, 99, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $speedM = GUICtrlCreateRadio("Mhash/s", 128, 128, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $speedG = GUICtrlCreateRadio("Ghash/s", 128, 152, 89, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Group3 = GUICtrlCreateGroup("Results", 240, 8, 225, 200)
Global $Aproximate = GUICtrlCreateLabel("Aproximate results:", 288, 24, 127, 20)
GUICtrlSetFont(-1, 10, 800, 0, "arial")
Global $btcperdaylabel = GUICtrlCreateLabel("Bitcoins per 24 hour", 248, 56, 122, 18)
GUICtrlSetFont(-1, 8, 800, 0, "arial")
Global $btcp24hresult = GUICtrlCreateInput("0.00000000", 376, 56, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $Label2 = GUICtrlCreateLabel("Bitcoins per 28 days", 248, 88, 122, 18)
GUICtrlSetFont(-1, 8, 800, 0, "arial")
Global $btcp28dresult = GUICtrlCreateInput("0.00000000", 376, 88, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $Label3 = GUICtrlCreateLabel("Dollars per 28 days", 248, 152, 116, 18)
GUICtrlSetFont(-1, 8, 800, 0, "arial")
Global $curp28dresult = GUICtrlCreateInput("0.00", 376, 152, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $curp24hresult = GUICtrlCreateInput("0.00", 376, 120, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $blockcracktime = GUICtrlCreateInput("0", 376, 182, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $Label4 = GUICtrlCreateLabel("Dollars per 24 hour", 248, 120, 116, 18)
GUICtrlSetFont(-1, 8, 800, 0, "arial")
Global $Label55 = GUICtrlCreateLabel("Block Duration:", 248, 182, 118, 18)
GUICtrlSetFont(-1, 8, 800, 0, "arial")

GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $difficultygui = GUICtrlCreateInput("0", 104, 192, 121, 21)
Global $Calcstats = GUICtrlCreateButton("Calculate statistics", 240, 220, 114, 33, BitOR($BS_DEFPUSHBUTTON, $WS_GROUP))
Global $refreshrate = GUICtrlCreateButton("Refresh BTC Rates", 354, 220, 114, 33, $WS_GROUP)

Global $Label5 = GUICtrlCreateLabel("Current Difficulty", 8, 192, 89, 17, $SS_RIGHT)



$MenuItem1 = GUICtrlCreateMenu("Help")
$MenuItem2 = GUICtrlCreateMenuItem("About", $MenuItem1)
$MenuItem3 = GUICtrlCreateMenuItem("Donate", $MenuItem1)

Global $StatusBar0 = _GUICtrlStatusBar_Create($Form1)





GUISetState(@SW_SHOW)
_GUICtrlStatusBar_SetText($StatusBar0, 'Attempting to obtain fresh information from the internet...')

Getrates()

Local $diffdata
Local $ratedata
If IsNumber($roundedsell) Or IsFloat($roundedsell) Then $ratedata = 1
If IsNumber($difficulty) Then $diffdata = 1

If $diffdata + $ratedata = 2 Then _GUICtrlStatusBar_SetText($StatusBar0, 'All data was updated from the internet.')

If $diffdata = 0 And $errored = 1 Then _GUICtrlStatusBar_SetText($StatusBar0, 'Difficulty could not be updated. Enter manually.')
If $diffdata = 1 And $ratedata = 'error' Then _GUICtrlStatusBar_SetText($StatusBar0, 'Exchange rate could not update. Currency figures are disabled.')
If $diffdata = 0 And $ratedata = 'error' Then _GUICtrlStatusBar_SetText($StatusBar0, 'Exchange rate and difficulty could not update.')




#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Calcstats
			Calculate()

		Case $refreshrate
			Getrates()
			Calculate()

		Case $MenuItem3
			GUISetState(@SW_DISABLE, $Form1)
			$donateanswer = MsgBox(4, 'Donate', 'To donate to me, press "Yes" and my bitcoin address will copy to your clipboard. Thank you!')
			GUISetState(@SW_ENABLE, $Form1)
			GUISetstate(@SW_SHOW, $Form1)
			If $donateanswer = 6 Then ClipPut('1MTkF9ZTcXtgvQX245TwTL2Ko3NMvJHz6P')

	Case $MenuItem2
		about()



	EndSwitch
WEnd





Func about()
	GUISetState(@SW_DISABLE, $Form1)
	MsgBox(0, 'BTC Capability V 1.9', 'Created by Morthawt ( www.morthawt.com )' & @CRLF & 'Close this about screen to continue checking the rates.')
	GUISetState(@SW_ENABLE, $Form1)
	GUISetstate(@SW_SHOW, $Form1)
EndFunc   ;==>about





Func Calculate()


	If GUICtrlRead($speedM) = 1 Then
		$actualpersonalhashrate = GUICtrlRead($personalspeedinput) * 1000000

	Else
		$actualpersonalhashrate = GUICtrlRead($personalspeedinput) * 1000000000


	EndIf




	If GUICtrlRead($Radio1) = 1 Then
		$actualpoolhashrate = GUICtrlRead($poolspeedinput) * 1000000

	Else
		$actualpoolhashrate = GUICtrlRead($poolspeedinput) * 1000000000


	EndIf

	$timetoblock = Round(GUICtrlRead($difficultygui) * 2 ^ 32 / $actualpoolhashrate / 60 / 60, 4)

	$btcperhour = 50 * ($actualpersonalhashrate / (GUICtrlRead($difficultygui) * 2 ^ 256 / (0xffff * 2 ^ 208))) * 60 * 60 * 24
	GUICtrlSetData($btcp24hresult, Round($btcperhour, 8))
	GUICtrlSetData($btcp28dresult, Round($btcperhour * 28, 8))

	GUICtrlSetData($curp24hresult, Round($btcperhour * $roundedsell, 2))
	GUICtrlSetData($curp28dresult, Round($btcperhour * $roundedsell * 28, 2))



	If $timetoblock < 24 Then
		GUICtrlSetData($blockcracktime, Round($timetoblock, 2) & ' Hours')
	EndIf

	If $timetoblock >= 24 Then
		GUICtrlSetData($blockcracktime, Round($timetoblock / 24, 2) & ' Days')
	EndIf





	$Numweeks = 168
	$Numdays = 24
	$Numseconds = 0













EndFunc   ;==>Calculate





Func Getrates()
	$errored = 1
	Global $first = $clear
	Global $sell = $clear
	Global $sellprice = $clear
	Global $buy = $clear
	Global $buyprice = $clear


	Global $clear
	If $debug = 1 Then $roundedsell = 19


	$difficulty = BinaryToString(InetRead('http://blockexplorer.com/q/getdifficulty', 1))
	If @error Then
		$difficulty = 'error'
	Else
		GUICtrlSetData($difficultygui, $difficulty)
		$difficulty = $difficulty + 1
		$difficulty = $difficulty - 1

	EndIf

	If $debug = 0 Then
		$file = @TempDir & '\BTCrates.txt'

		$get = InetGet('https://mtgox.com/code/data/ticker.php', $file, 1)
		If @error Then
			Global $ratedata = 'error'

		EndIf



		Global $open = FileRead($file)

		If $debug = 1 Then

			FileWrite('debug.txt', $open & @CRLF)

		EndIf

		FileDelete($file)


		If $get <> 0 Then

			Global $first = StringSplit($open, ',')



			If $first[0] > 5 Then


				Global $sell = StringSplit($first[5], ':')

				If $sell[0] > 1 Then
					Global $sellprice = $sell[2]
				EndIf

				Global $buy = StringSplit($first[4], ':')

				If $buy[0] > 1 Then
					Global $buyprice = $buy[2]
				EndIf


				Global $roundedbuy = Round($buyprice, 2)
				Global $roundedsell = Round($sellprice, 2)

			EndIf






		EndIf

	EndIf


EndFunc   ;==>Getrates