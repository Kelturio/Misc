#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $aPoints[21][2], $iI
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsFillPolygon2", 400, 400)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	
	; Create a brush to fill the polygon interior
	$hBrush = _GDIPlus_BrushCreateSolid($GDIP_BROWN)
	
	; Create a random point
	$aPoints[0][0] = 20
	
	For $iI = 1 To 20
		$aPoints[$iI][0] = Random(1, 399, 1)
		$aPoints[$iI][1] = Random(1, 399, 1)
	Next
	
	; Draw the filled polygon
	_GDIPlus_GraphicsFillPolygon2($hGraphics, $aPoints, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc