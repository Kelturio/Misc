#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hJoinPath, $hCustomLineCap, $hPen, $iStrokeJoin
	Local $avPoints[4][2] = [[3], [-15, -15], [0, 0], [15, -15]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_CustomLineCapGetStrokeJoin Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create GraphicsPath and add two lines to it.
    $hPath = _GDIPlus_PathCreate()
    _GDIPlus_PathAddLines($hPath, $avPoints)

	; Create a CustomLineCap object.
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)
	
	; Set the stroke join for the CustomLineCap object
	_GDIPlus_CustomLineCapSetStrokeJoin($hCustomLineCap, $LineJoinBevel)
	
	; Get the stroke join from the CustomLineCap object
	$iStrokeJoin = _GDIPlus_CustomLineCapGetStrokeJoin($hCustomLineCap)

	; Create a Pen object and set it's line join to the line join of the CustomLineCap object
	$hPen = _GDIPlus_PenCreate($GDIP_DODGERBLUE, 15)
	_GDIPlus_PenSetLineJoin($hPen, $iStrokeJoin)
   
	$hJoinPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddRectangle($hJoinPath, 20, 20, 360, 160)
	
	_GDIPlus_GraphicsDrawPath($hGraphics, $hJoinPath, $hPen)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PathDispose($hJoinPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc