#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $hIA, $tColorMatrix, $pColorMatrix, $iWidth, $iHeight, $aSize
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; Create an ImageAttribute object
	$hIA = _GDIPlus_ImageAttributesCreate()
	
	; Create the color matrix used to adjust the colors of the image
	; Use translation color matrix to increase the image brightness
	$tColorMatrix = _GDIPlus_ColorMatrixCreateTranslate(0.15, 0.15, 0.15)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
	
	; Adjust the ImageAttribute color-key color matrix
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pColorMatrix)
	
	GUISetState()
	
	; Get the image dimensions
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]
	
	; Set interpolation mode to increase shrinking quality
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
	
	; Draw the image as it was captured
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, @DesktopWidth, @DesktopHeight/2)
	; Draw the image while applying the color adjustment
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight/2, @DesktopWidth, @DesktopHeight/2, $hIA)
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageAttributesDispose($hIA)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc