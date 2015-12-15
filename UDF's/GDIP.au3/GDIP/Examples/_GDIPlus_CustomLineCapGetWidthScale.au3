#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hCustomLineCap, $hPen, $nWidthScale
	Local $avPoints[4][2] = [[3], [-15, -15], [0, 0], [15, -15]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_CustomLineCapGetWidthScale Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create GraphicsPath and add two lines to it.
    $hPath = _GDIPlus_PathCreate()
    _GDIPlus_PathAddLines($hPath, $avPoints)

	; Create a CustomLineCap object.
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)
	
	; Set the width scale for the CustomLineCap object
	_GDIPlus_CustomLineCapSetWidthScale($hCustomLineCap, 1.2)
	
	; Get the width scale from the CustomLineCap object
	$nWidthScale = _GDIPlus_CustomLineCapGetWidthScale($hCustomLineCap)

	; Create a Pen object and set it's end cap to the CustomLineCap object
	$hPen = _GDIPlus_PenCreate($GDIP_CORAL, 5, $UnitWorld)
	_GDIPlus_PenSetCustomEndCap($hPen, $hCustomLineCap)
	
	_GDIPlus_GraphicsDrawLine($hGraphics, 90, 100, 310, 100, $hPen)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc