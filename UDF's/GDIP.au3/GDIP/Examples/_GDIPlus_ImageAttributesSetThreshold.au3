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
	; Set interpolation mode to high-quality, bicubic interpolation. Ensuring high quality while drawing a shrinked image
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
	
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; Get image dimensions
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iWidth = $aSize[0]
	$iHeight = $aSize[1]
	
	; Create an ImageAttributes object used to adjust image colors
	$hIA = _GDIPlus_ImageAttributesCreate()
	; Set the threshold value to 0.4
	_GDIPlus_ImageAttributesSetThreshold($hIA, 1, True, 0.4)
	
	GUISetState()
	; Draw the image once unaltered and then the altered image
	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, 0, @DesktopWidth, @DesktopHeight/2)
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight, 0, @DesktopHeight/2, @DesktopWidth, @DesktopHeight/2, $hIA)
	
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc