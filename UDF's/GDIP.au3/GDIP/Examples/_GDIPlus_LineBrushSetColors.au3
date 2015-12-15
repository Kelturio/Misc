#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushSetColors", 420, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a linear gradient brush that changes gradually from red to green
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 0, 100, 0xFFFF0000, 0xFF00FF00, 1) ; Flip the brush
	
	; Fill a rectangle with the red to green linear gradient brush
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush)
	
	; Change the starting and ending colors of the linear gradient brush to black and white
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFFFFFFFF)
	; Fill a rectangle with the black to white linear gradient brush
	_GDIPlus_GraphicsFillRect($hGraphics, 220, 0, 200, 200, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc