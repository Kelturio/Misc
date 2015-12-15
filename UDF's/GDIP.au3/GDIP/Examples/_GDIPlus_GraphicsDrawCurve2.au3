#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPen, $aPoints[11][2], $iI, $iJ
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsDrawCurve2 Example", 400, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Using antialiasing
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	
	; Create a few points
	$aPoints[0][0] = 10
	
	For $iI = 0 To 1
		For $iJ = 1 To 5
			$aPoints[$iI*5+$iJ][0] = 300*$iI+50
			$aPoints[$iI*5+$iJ][1] = $iJ*50
		Next
	Next
	
	; Create a Pen object
	$hPen = _GDIPlus_PenCreate($GDIP_ORCHID, 8)
	
	; Draw the curve specifying a tension value
	_GDIPlus_GraphicsDrawCurve2($hGraphics, $aPoints, 0.8, $hPen)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc