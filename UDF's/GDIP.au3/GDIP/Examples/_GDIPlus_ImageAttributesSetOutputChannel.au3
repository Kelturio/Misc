#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $hIA, $iWidth, $iHeight, $aSize
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; Get the image dimensions
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]

	GUISetState()
	
	; Set interpolation mode to high-quality, bicubic interpolation. Ensuring high quality while drawing a shrinked image
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
	
	; Create an ImageAttributes object used to adjust image colors
	$hIA = _GDIPlus_ImageAttributesCreate()
	
	; Draw the image, showing the intensity of the cyan channel
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 0) ; Cyan
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, 0, @DesktopWidth/2, @DesktopHeight/2, $hIA)
	
	; Draw the image, showing the intensity of the magenta channel
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 1) ; Magenta
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth/2, 0, @DesktopWidth/2, @DesktopHeight/2, $hIA)
	
	; Draw the image, showing the intensity of the yellow channel
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 2) ; Yellow
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight/2, @DesktopWidth/2, @DesktopHeight/2, $hIA)
	
	; Draw the image, showing the intensity of the black channel
	_GDIPlus_ImageAttributesSetOutputChannel($hIA, 1, True, 3) ; Black
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, @DesktopWidth/2, @DesktopHeight/2, @DesktopWidth/2, @DesktopHeight/2, $hIA)
	
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