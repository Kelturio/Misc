#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $iGraphicsCont
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsEndContainer Example", 400, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	;  Set the clipping reguin for the Graphics object
	_GDIPlus_GraphicsSetClipRect($hGraphics, 10, 10, 150, 150)
	
	; Begin a graphics container
	$iGraphicsCont = _GDIPlus_GraphicsBeginContainer2($hGraphics)
	
	; Set an additional clipping region for the container
	_GDIPlus_GraphicsSetClipRect($hGraphics, 100, 50, 100, 75) 
	
	; Fill a red rectangle in the container
	$hBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; Red
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 400, $hBrush)
	
	; End the container and reset the graphics state to the state the graphics was before the container began
	_GDIPlus_GraphicsEndContainer($hGraphics, $iGraphicsCont)
	
	;Fill a blue rectangle outside the container
	_GDIPlus_BrushSetFillColor($hBrush, 0x800000FF) ; Semi transparent blue
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 400, $hBrush)
	
	; Set the clipping region to infinite, and draw the outlines
	; of the two previous clipping regions
	_GDIPlus_GraphicsResetClip($hGraphics)
	_GDIPlus_GraphicsDrawRect($hGraphics, 10, 10, 150, 150)
	_GDIPlus_GraphicsDrawRect($hGraphics, 100, 50, 100, 75)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc