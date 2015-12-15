#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPen, $aPoints[11][2], $iI
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsDrawBeziers Example", 400, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Using antialiasing
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	
	; Create a few random points
	$aPoints[0][0] = 10
	
	For $iI = 1 To 10
		$aPoints[$iI][0] = Random(0, 350, 1)
		$aPoints[$iI][1] = Random(0, 300, 1)
	Next
	
	; Create a Pen object
	$hPen = _GDIPlus_PenCreate($GDIP_MAROON, 8)
	
	; Draw the beziers
	_GDIPlus_GraphicsDrawBeziers($hGraphics, $aPoints, $hPen)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc