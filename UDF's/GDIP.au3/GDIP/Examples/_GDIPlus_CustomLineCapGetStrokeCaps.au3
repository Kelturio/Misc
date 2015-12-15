#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hCustomLineCap, $hPen
	Local $avCaps, $avPoints[4][2] = [[3], [-15, -15], [0, 0], [15, -15]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_CustomLineCapGetStrokeCaps Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create GraphicsPath and add two lines to it.
    $hPath = _GDIPlus_PathCreate()
    _GDIPlus_PathAddLines($hPath, $avPoints)

	; Create a CustomLineCap object.
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)
	
	; Set the start and end caps for the CustomLineCap object
	_GDIPlus_CustomLineCapSetStrokeCaps($hCustomLineCap, $LineCapTriangle, $LineCapRound)
	
	; Get the start and edn caps from the CustomLineCap object
	$avCaps = _GDIPlus_CustomLineCapGetStrokeCaps($hCustomLineCap)

	; Create a Pen object and set it's start and end caps to those of the CustomLineCap object
	$hPen = _GDIPlus_PenCreate(0xFFFF00CC, 15)
	_GDIPlus_PenSetLineCap($hPen, $avCaps[0], $avCaps[1], $DashCapFlat)
   
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