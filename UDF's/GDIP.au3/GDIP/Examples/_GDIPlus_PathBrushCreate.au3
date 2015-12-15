#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush
	Local $aColors[11] = [10, 0xFFFF0000, 0xFFFF0000, 0xFF0000FF, 0xFFFF0000, 0xFFFF0000, 0xFF0000FF, 0xFFFF0000, 0xFFFFFFFF, 0xFFFF0000, 0xFF0000FF]
	Local $aPoints[11][2] = [[10], [0, 100], [130, 100], [200, 0], [270, 100], [400, 100], [300, 150], [400, 300], [200, 200], [0, 300], [100, 150]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_PathBrushCreate", 400, 300)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a path gradient brush from the points
	$hBrush = _GDIPlus_PathBrushCreate($aPoints)
	; Set the path gradient brush center color
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFF00FF00)
	; Set the path gradient brush surrounding colors
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hBrush, $aColors)
	
	; Fill a polygon with the path gradient brush
	_GDIPlus_GraphicsFillPolygon($hGraphics, $aPoints, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc