#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hCustomLineCapEnd, $hCustomLineCapStart, $hPen, $iBaseCap
	Local $avPoints[4][2] = [[3], [-15, -15], [0, 0], [15, -15]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_CustomLineCapSetBaseCap Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	
	; Create GraphicsPath and add two lines to it.
	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLines($hPath, $avPoints)

	; Create a CustomLineCap object.
	$hCustomLineCapEnd = _GDIPlus_CustomLineCapCreate(0, $hPath, Random($LineCapFlat, $LineCapTriangle, 1))
	_GDIPlus_PathReset($hPath)
	_GDIPlus_PathAddEllipse($hPath, -15, -15, 30, 30)
	
	$hCustomLineCapStart = _GDIPlus_CustomLineCapCreate(0, $hPath)
	
	; Get the BaseCap of the ending CustomLineCap object and assign the same for the starting one
	$iBaseCap = _GDIPlus_CustomLineCapGetBaseCap($hCustomLineCapEnd)
	_GDIPlus_CustomLineCapSetBaseCap($hCustomLineCapStart, $iBaseCap)
   
	; Create a Pen object, assign cloned cap as the custom end cap, and draw a line.
	$hPen = _GDIPlus_PenCreate(0xFF000000, 3)
	_GDIPlus_PenSetCustomEndCap($hPen, $hCustomLineCapEnd)
	_GDIPlus_PenSetCustomStartCap($hPen, $hCustomLineCapStart)
	_GDIPlus_GraphicsDrawLine($hGraphics, 50, 70, 200, 70, $hPen)
  
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hCustomLineCapStart)
	_GDIPlus_CustomLineCapDispose($hCustomLineCapEnd)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc