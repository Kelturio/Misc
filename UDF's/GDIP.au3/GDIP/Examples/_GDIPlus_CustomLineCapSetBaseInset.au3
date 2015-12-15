#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hCustomLineCap, $hCustomLineCap2, $hPen, $nBaseInset
	Local $avPoints[4][2] = [[3], [-15, -15], [0, 0], [15, -15]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_CustomLineCapSetBaseInset Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create GraphicsPath and add two lines to it.
	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLines($hPath, $avPoints)

	; Create a CustomLineCap object.
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath, $LineCapRound, 5)

	; Create CustomLineCap object $hCustomLineCap2 and set it's base inset to the one of $hCustomLineCap's, plus 5.
	$nBaseInset = _GDIPlus_CustomLineCapGetBaseInset($hCustomLineCap) + 5
	$hCustomLineCap2 = _GDIPlus_CustomLineCapCreate(0, $hPath, $LineCapRound)
	_GDIPlus_CustomLineCapSetBaseInset($hCustomLineCap2, $nBaseInset)
	

	; Create a Pen object, assign cloned cap as the custom end cap, and draw a line.
	$hPen = _GDIPlus_PenCreate(0xFFFF00FF, 2)
	_GDIPlus_PenSetCustomStartCap($hPen, $hCustomLineCap)
	_GDIPlus_PenSetCustomEndCap($hPen, $hCustomLineCap2)
   
	_GDIPlus_GraphicsDrawLine($hGraphics, 10, 10, 100, 100, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphics, 190, 190, 110, 110, $hPen)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap2)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc