
#include <ListviewConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
Local $aTest[3][2][3] = [[["aa1", "aa2", "aa3"],["ab1", "ab2", "ab3"]],[["ba1", "ba2", "ba3"],["bb1", "bb2", "bb3"]],[["ca1", "ca2", "ca3"],["cb1", "cb2", "cb3"]]]
;~ Local $aTest[2][3] =[["aa1", "aa2", "aa3"],["ab1", "ab2", "ab3"]]
_3DArrayDisplay($aTest)
Func _3DArrayDisplay($aCallersArray)
 $iGuiHeight = 400
 $iGuiWidth = 400
 $hgui = GUICreate("3D Array", $iGuiWidth, $iGuiHeight)
 $i1D_Ubound = UBound($aCallersArray)
 $i2D_Ubound = UBound($aCallersArray, 2)
 $i3D_Ubound = UBound($aCallersArray, 3)
 If @error Then
  _ArrayDisplay($aCallersArray)
  Return $aCallersArray
 EndIf
 Local Enum $i2DHolder_TabControl, $i2DHolder_Array, $i2DHolder_UBound
 Local $a2DHolder[$i1D_Ubound][$i2DHolder_UBound]
 For $i = 0 To $i1D_Ubound - 1
  Local $aTemp[$i2D_Ubound][$i3D_Ubound]
  For $j = 0 To 1
   For $k = 0 To 2
    $aTemp[$j][$k] = $aCallersArray[$i][$j][$k]
   Next
  Next
  $a2DHolder[$i][$i2DHolder_Array] = $aTemp
 Next
 GUICtrlCreateTab(10, 10, $iGuiWidth - 20, $iGuiHeight - 20)
 For $i = 0 To UBound($a2DHolder) - 1
  $aTemp = $a2DHolder[$i][$i2DHolder_Array]
  $a2DHolder[$i][$i2DHolder_TabControl] = GUICtrlCreateTabItem("Dimension" & $i)
  $breaks = "Column0"
  For $j = 0 To UBound($aTemp, 2) - 2
   $breaks &= "|Column" & $j + 1
  Next
  $iListView = GUICtrlCreateListView($breaks, 20, 40, $iGuiWidth - 40, $iGuiHeight - 60, -1, $LVS_EX_GRIDLINES)
  For $j = 0 To UBound($aTemp) - 1
   For $k = 0 To UBound($aTemp, 2) - 1
    If $k = 0 Then
     $string = $aTemp[$j][$k]
    Else
     $string = $string & "|" & $aTemp[$j][$k]
    EndIf
   Next
   ConsoleWrite($string & @CRLF)
   GUICtrlCreateListViewItem($string, $iListView)
  Next
 Next
 GUISetState(@SW_SHOW)
 Do
  Local $msg = GUIGetMsg()
 Until $msg = $GUI_EVENT_CLOSE
EndFunc   ;==>_3DArrayDisplay