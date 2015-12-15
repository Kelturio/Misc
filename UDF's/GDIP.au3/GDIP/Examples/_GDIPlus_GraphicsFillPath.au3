#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $hPath, $aPoints[5][2]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsFillPath", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	
	; Create a GraphicsPath
	$hPath = _GDIPlus_PathCreate()
	
	; Define the curve points
	$aPoints[0][0] = 4
	$aPoints[1][0] = 10
	$aPoints[1][1] = 100
	$aPoints[2][0] = 100
	$aPoints[2][1] = 190
	$aPoints[3][0] = 300
	$aPoints[3][1] = 10
	$aPoints[4][0] = 390
	$aPoints[4][1] = 100
	
	; Add the curve to the path
	_GDIPlus_PathAddCurve($hPath, $aPoints)
	
	; Create a brush to fill the path interior
	$hBrush = _GDIPlus_BrushCreateSolid(0xFF0000FF)
	
	; Fill the path
	_GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc