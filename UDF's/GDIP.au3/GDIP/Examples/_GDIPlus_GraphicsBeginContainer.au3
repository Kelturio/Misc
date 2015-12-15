#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $iGraphicsCont, $tDstRect, $tSrcRect
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsBeginContainer Example", 400, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create the rectangles used by the Graphics container
	$tSrcRect = _GDIPlus_RectFCreate(0, 0, 200, 100)
	$tDstRect = _GDIPlus_RectFCreate(100, 100, 200, 200)
	
	; Create a Graphics container with a (100, 100) translation and (1, 2) scale
	$iGraphicsCont = _GDIPlus_GraphicsBeginContainer($hGraphics, $tDstRect, $tSrcRect)
	
	; Fill an ellipse in the container
	$hBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; Red
	_GDIPlus_GraphicsFillEllipse($hGraphics, 0, 0, 100, 60, $hBrush)
	
	; End the container and reset the graphics state to the state the graphics was before the container began
	_GDIPlus_GraphicsEndContainer($hGraphics, $iGraphicsCont)
	
	;Fill an ellipse outside the container
	_GDIPlus_BrushSetFillColor($hBrush, 0xFF0000FF) ; Blue
	_GDIPlus_GraphicsFillEllipse($hGraphics, 0, 0, 100, 60, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc