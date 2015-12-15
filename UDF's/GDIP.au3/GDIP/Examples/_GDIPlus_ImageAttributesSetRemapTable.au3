#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hRedBrush, $hGreenBrush, $hBlueBrush, $hBitmap, $hBitmapContext, $hIA, $iI, $iJ, $aRemapTable[4][2]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("", 420, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	; Create a Bitmap object and get it's graphics context
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(200, 200)
	$hBitmapContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	
	; Create 3 brushes of 3 different colors: red, green and blue
	$hRedBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; Red
	$hGreenBrush = _GDIPlus_BrushCreateSolid(0xFF00FF00) ; Green
	$hBlueBrush = _GDIPlus_BrushCreateSolid(0xFF0000FF) ; Blue
	
	For $iI = 0 To 9
		For $iJ = 0 To 9
			Switch Random(1, 3, 1)
				Case 1
					_GDIPlus_GraphicsFillRect($hBitmapContext, $iI*20, $iJ*20, 20, 20, $hRedBrush)
				Case 2
					_GDIPlus_GraphicsFillRect($hBitmapContext, $iI*20, $iJ*20, 20, 20, $hGreenBrush)
				Case Else
					_GDIPlus_GraphicsFillRect($hBitmapContext, $iI*20, $iJ*20, 20, 20, $hBlueBrush)
			EndSwitch
		Next
	Next
	
	; Draw the image unaltered
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)
	
	; Create an ImageAttributes object used to adjust image colors
	$hIA = _GDIPlus_ImageAttributesCreate()
	; Define the remap table that replaces image colors
	$aRemapTable[0][0] = 3 ; 3 entries
	
	; Replace red with cyan
	$aRemapTable[1][0] = 0xFFFF0000
	$aRemapTable[1][1] = 0xFF00FFFF
	; Replace green with blue
	$aRemapTable[2][0] = 0xFF00FF00
	$aRemapTable[2][1] = 0xFF0000FF
	; Replace blue with yellow
	$aRemapTable[3][0] = 0xFF0000FF
	$aRemapTable[3][1] = 0xFFFFFF00
	
	_GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemapTable)
	
	; Draw the image while applying the ImageAttributes color adjustment
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, 200, 200, 220, 0, 200, 200, $hIA)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_BrushDispose($hBlueBrush)
	_GDIPlus_BrushDispose($hGreenBrush)
	_GDIPlus_BrushDispose($hRedBrush)
	_GDIPlus_GraphicsDispose($hBitmapContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc