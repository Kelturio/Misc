#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hPathBrush, $hLineBrush, $hBitmap, $hContext
	Local $avColors[2] = [1, 0x00FFFFFF]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_BitmapCreateFromScan0 Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create the bitmap with size but without data
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(200, 200)
	
	; Get the bitmap graphics context to draw using double buffering
	$hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	; Create the linear gradient brush used to fill the shapes
	$hLineBrush = _GDIPlus_LineBrushCreate(1, 1, 200 - 2, 200 - 2, 0x000000FF, 0xA00000FF)

	; Create the graphics path to draw the figures, using the default fill mode
	$hPath = _GDIPlus_PathCreate()
	
	; Start drawing a figure
	_GDIPlus_PathStartFigure($hPath)
	; Draw an ellipse
	_GDIPlus_PathAddEllipse($hPath, 2, 2, 200 - 4, 200 - 4)
	
	; Create a path brush accosiated with the graphics path
	$hPathBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	
	_GDIPlus_PathBrushSetCenterColor($hPathBrush, 0x8000FFFF)
	_GDIPlus_PathBrushSetCenterPoint($hPathBrush, 200/2, 200/2)
	_GDIPlus_PathBrushSetFocusScales($hPathBrush, 0.1, 0.1)
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hPathBrush, $avColors)
	
	; Set the graphics smoothing mode and draw the path to the bitmap context using the brushes
	_GDIPlus_GraphicsSetSmoothingMode($hContext, $SmoothingModeAntiAlias)
	_GDIPlus_GraphicsFillPath($hContext, $hPath, $hLineBrush)
	_GDIPlus_GraphicsFillPath($hContext, $hPath, $hPathBrush)
	
	; Finally, draw bitmap on graphics
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 100, 0)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hPathBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hLineBrush)
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc