#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $tPreHue, $tPostHue, $tColorMatrix, $pColorMatrix, $iWidth, $iHeight, $aSize
	Local $hBrightIA, $hHueIA, $hGrayIA, $hContIA
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	
	; Create the brightness ImageAttributes object
	$hBrightIA = _GDIPlus_ImageAttributesCreate()
	; Create the hue ImageAttributes object
	$hHueIA = _GDIPlus_ImageAttributesCreate()
	; Create the grey ImageAttributes object
	$hGrayIA = _GDIPlus_ImageAttributesCreate()
	; Create the contrast ImageAttributes object
	$hContIA = _GDIPlus_ImageAttributesCreate()
	
	; Create the brightness color matrix
	$tColorMatrix = _GDIPlus_ColorMatrixCreateTranslate(0.5, 0.5, 0.5)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
	
	; Adjust the image brightness to be 50% brighter
	_GDIPlus_ImageAttributesSetColorMatrix($hBrightIA, 0, True, $pColorMatrix)
	
	; Create the identity color matrix and the hue color matrices
	$tColorMatrix = _GDIPlus_ColorMatrixCreate()
	$tPreHue = _GDIPlus_ColorMatrixCreate()
	$tPostHue = _GDIPlus_ColorMatrixCreate()
	_GDIPlus_ColorMatrixInitHue($tPreHue, $tPostHue)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
	
	; Adjust the image hue by 90 degrees rotation
	_GDIPlus_ColorMatrixRotateHue($tColorMatrix, $tPreHue, $tPostHue, 90)
	_GDIPlus_ImageAttributesSetColorMatrix($hHueIA, 0, True, $pColorMatrix)
	
	; Create the gray-scaled color matrix
	$tColorMatrix = _GDIPlus_ColorMatrixCreateGrayScale()
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
	
	; Adjust the image colors to be gray-scaled
	_GDIPlus_ImageAttributesSetColorMatrix($hGrayIA, 0, True, $pColorMatrix)
	
	; Create the contrast color matrix
	$tColorMatrix = _GDIPlus_ColorMatrixCreateScale(4, 4, 4)
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
	
	; Fix colors by hue rotation
	_GDIPlus_ColorMatrixRotateHue($tColorMatrix, $tPreHue, $tPostHue, 0)
	
	; Adjust the image contrast
	_GDIPlus_ImageAttributesSetColorMatrix($hContIA, 0, True, $pColorMatrix)
	
	GUISetState()
	
	; Get the image dimensions
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]
	
	; Set interpolation mode to increase shrinking quality
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
	
	; Draw the image adjusted by brightness
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, 0, @DesktopWidth/2, @DesktopHeight/2, $hBrightIA)
	
	; Draw the image adjusted by hue
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth/2, 0, @DesktopWidth/2, @DesktopHeight/2, $hHueIA)
	
	; Draw the image adjusted by the gray scaling color matrix
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight/2, @DesktopWidth/2, @DesktopHeight/2, $hGrayIA)
	
	; Draw the image adjusted by contrast
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth/2, @DesktopHeight/2, @DesktopWidth/2, @DesktopHeight/2, $hContIA)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageAttributesDispose($hContIA)
	_GDIPlus_ImageAttributesDispose($hGrayIA)
	_GDIPlus_ImageAttributesDispose($hHueIA)
	_GDIPlus_ImageAttributesDispose($hBrightIA)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc