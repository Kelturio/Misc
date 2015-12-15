#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hBrush
	Local $aColors[11] = [10, 0xFFFF0000, 0xFFFF0000, 0xFF0000FF, 0xFFFF0000, 0xFFFF0000, 0xFF0000FF, 0xFFFF0000, 0xFFFFFFFF, 0xFFFF0000, 0xFF0000FF]
	Local $aPoints[11][2] = [[10], [0, 100], [130, 100], [200, 0], [270, 100], [400, 100], [300, 150], [400, 300], [200, 200], [0, 300], [100, 150]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_PathBrushCreateFromPath", 400, 300)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a Path object and add lines from the points
	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLines($hPath, $aPoints)
	
	; Create a path gradient brush from a path
	$hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	; Set the path gradient brush center color
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFF00FF00)
	; Set the path gradient brush surrounding colors
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hBrush, $aColors)
	
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