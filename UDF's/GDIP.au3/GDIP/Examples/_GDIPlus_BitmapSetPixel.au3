#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI
	Local $hGraphics, $hBmp, $hBitmap
	Local $iColor, $iX, $iY, $iImageWidth, $iImageHeight
	Local $aSize
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	$aSize = _GDIPlus_ImageGetDimension($hBitmap)
	$iColor = $GDIP_DARKSEAGREEN
	
	$iImageWidth =  $aSize[0]
	$iImageHeight = $aSize[1]
	
	For $iX = 0 To $iImageWidth Step 16
		For $iY = 0 To $iImageHeight Step 16
			_GDIPlus_BitmapSetPixel($hBitmap, $iX, $iY, $iColor)
		Next
	Next
	GUISetState()
	
	; Now draw a checkered screen capture
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc