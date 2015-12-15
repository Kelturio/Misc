#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $tRectF
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushCreateFromRect", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	; Create the defining rectangle for the linear gradient brush
	$tRectF = _GDIPlus_RectFCreate(0, 0, 50, 100)
	; Create a linear gradient brush that changes gradually from red to green
	$hBrush = _GDIPlus_LineBrushCreateFromRect($tRectF, 0xFFFF0000, 0xFF00FF00, 3, 1) ; Backward diagonal direction
	
	; Fill a rectangle with the linear gradient brush
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 200, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc