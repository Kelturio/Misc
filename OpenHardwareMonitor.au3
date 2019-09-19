#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

If not ProcessExists("OpenHardwareMonitor.exe") Then
Msgbox (16, "Error", "Please start OpenHardwareMonitor.exe")
Exit
EndIf
$wbemFlagReturnImmediately = 0x10
$wbemFlagForwardOnly = 0x20
$strComputer = "."
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\OpenHardwareMonitor")

GUICreate ("CPU", 200,200)

GUICtrlCreateLabel ("Temperature", 10, 10, 100,20)
GUICtrlCreateLabel ("Load", 10, 40, 100,20)
GUICtrlCreateLabel ("Power", 10, 70, 100,20)

$CPUTemp = GUICtrlCreateLabel("", 130, 10, 50, 20, $SS_RIGHT)
$CPULoad = GUICtrlCreateLabel("", 130, 40, 50, 20, $SS_RIGHT)
$CPUPower = GUICtrlCreateLabel("", 130, 70, 50, 20, $SS_RIGHT)

GUISetState()

While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE
Exit
EndSwitch

$colItems = $objWMIService.ExecQuery("SELECT * FROM Sensor", "WQL",$wbemFlagReturnImmediately + $wbemFlagForwardOnly)
$Output=""
$Power=""
$Load=""
For $objItem in $colItems
if $objItem.SensorType = 'Power' and StringInStr($objItem.Parent, 'cpu') Then
If StringInStr($objItem.Name , "Package") Then
_GuiCtrlSetData($CPUPower, Round($objItem.Value,1) & " W")
EndIf
EndIf
if $objItem.SensorType = 'Temperature' and StringInStr($objItem.Parent, 'cpu') Then
If StringInStr($objItem.Name , "Package") Then
_GuiCtrlSetData($CPUTemp, $objItem.Value & " °C")
EndIf
EndIf
if $objItem.SensorType = 'Load' and StringInStr($objItem.Parent, 'cpu') Then
If StringInStr($objItem.Name , "Total") Then
_GuiCtrlSetData($CPULoad, Round($objItem.Value,1) & " %")
EndIf
EndIf
Next
WEnd

Func _GUICtrlSetData($iCtrlID, $sData)
If GUICtrlRead($iCtrlID, 1) <> $sData Then GUICtrlSetData($iCtrlID, $sData)
EndFunc ;==>_GUICtrlSetData