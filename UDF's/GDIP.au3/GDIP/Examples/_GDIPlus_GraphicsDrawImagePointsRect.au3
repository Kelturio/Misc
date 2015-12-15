#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI
	Local $hGraphics, $hBrush, $hContext, $hBitmap, $hIA, $aColorMap[2][2], $iI, $iJ, $iClr
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsDrawImagePointsRect", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBrush = _GDIPlus_BrushCreateSolid()
	
	; Create a Bitmap object sized 180x120
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(180, 120)
	
	; Get the Bitmap graphics context to draw into
	$hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext)
	
	For $iI = 0 To 5
		For $iJ = 0 To 3
			Switch Mod($iI+$iJ, 3)
				Case 0
					$iClr = 0xFFFF0000
				Case 1
					$iClr = 0xFF00FF00
				Case Else
					$iClr = 0xFF0000FF
			EndSwitch
			
			_GDIPlus_BrushSetFillColor($hBrush, $iClr)
			_GDIPlus_GraphicsFillRect($hContext, $iI*30, $iJ*30, 30, 30, $hBrush)
		Next
	Next
	
	; Create an ImageAttribute object to adjust the image colors
	$hIA = _GDIPlus_ImageAttributesCreate()
	
	; Replace red colors with yellow
	$aColorMap[0][0] = 1
	$aColorMap[1][0] = 0xFFFF0000 ; Red
	$aColorMap[1][1] = 0xFFFFFF00 ; Yellow
	
	_GDIPlus_ImageAttributesSetRemapTable($hIA, 0, True, $aColorMap)

	; Draw the original image
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 5, 5)
	; Draw the cropped image
	_GDIPlus_GraphicsDrawImagePointsRect($hGraphics, $hBitmap, 220, 5, 370, 5, 190, 125, 0, 0, 180, 120, 2, $hIA)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc