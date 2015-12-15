#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushSetGammaCorrection", 420, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a linear gradient brush that changes gradually from red to blue
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 0, 200, 0xFFFF0000, 0xFF0000FF, 1) ; Flip the brush
	
	; Fill a rectangle with the linear gradient brush
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush)
	
	; Apply gamma correction
	_GDIPlus_LineBrushSetGammaCorrection($hBrush, True)
	; Fill a rectangle with the linear gradient brush while applying gamma correction
	_GDIPlus_GraphicsFillRect($hGraphics, 220, 0, 200, 200, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc