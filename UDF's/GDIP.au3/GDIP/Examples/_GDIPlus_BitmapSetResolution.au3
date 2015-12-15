#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGraphics, $hBmp, $hBitmap
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	
	; Set Dots Per Inch to 96x144, usually 96x96 or 120x120: isotropic
	_GDIPlus_BitmapSetResolution($hBitmap, 96, 144)
	
	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & "\96x144.jpg")
	; Clean up
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
	
	ShellExecute(@MyDocumentsDir & "\96x144.jpg")
EndFunc