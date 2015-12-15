#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushSetLinearBlend", 400, 320)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a linear gradient brush that changes gradually from red to blue
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 400, 0, 0xFFFF0000, 0xFF0000FF, 1) ; Flip the brush
	
	; Set the linear gradient brush focus at 50% from the left which blends by 60% (40% red, 60% blue)
	_GDIPlus_LineBrushSetLinearBlend($hBrush, 0.5, 0.6)
	; Fill a rectangle with the linear gradient brush
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 100, $hBrush)

	; Set the linear gradient brush focus at 20% from the left which blends by 80% (20% red, 80% blue)
	_GDIPlus_LineBrushSetLinearBlend($hBrush, 0.2, 0.8)
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 110, 400, 100, $hBrush)
	
	; Set the linear gradient brush focus at 80% from the left which blends by 100% (0% red, 100% blue)
	_GDIPlus_LineBrushSetLinearBlend($hBrush, 0.8, 1)
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 220, 400, 100, $hBrush) 
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc