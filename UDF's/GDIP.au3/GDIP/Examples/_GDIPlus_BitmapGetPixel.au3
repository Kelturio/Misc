#include <GDIP.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hBmp, $hBitmap, $iColor
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	$iColor = _GDIPlus_BitmapGetPixel($hBitmap, 150, 150)
	
	MsgBox(0x40, "Color", "Bitmap Pixel Color at [150, 150] is: 0x" & Hex($iColor))
	
	; Clean up
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc