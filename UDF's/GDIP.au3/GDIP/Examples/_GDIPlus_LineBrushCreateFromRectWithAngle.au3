#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush20, $hBrush120, $tRectF
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushCreateFromRectWithAngle", 420, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	; Create the defining rectangle for the linear gradient brush
	$tRectF = _GDIPlus_RectFCreate(0, 0, 50, 100)
	; Create a linear gradient brush that changes gradually from red to green with angle of 20 degrees
	$hBrush20 = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFFFF0000, 0xFF00FF00, 20, True, 1)
	; Create a linear gradient brush that changes gradually from red to green with angle of 20 degrees
	$hBrush120 = _GDIPlus_LineBrushCreateFromRectWithAngle($tRectF, 0xFFFF0000, 0xFF00FF00, 120, True, 1)
	
	; Fill a rectangle with the linear gradient brush of 20 degrees
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 200, 200, $hBrush20)
	; Fill a rectangle with the linear gradient brush of 120 degrees
	_GDIPlus_GraphicsFillRect($hGraphics, 220, 0, 200, 200, $hBrush120)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush120)
	_GDIPlus_BrushDispose($hBrush20)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc