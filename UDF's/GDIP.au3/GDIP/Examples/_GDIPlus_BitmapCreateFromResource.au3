#include <GDIP.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hInst, $hBitmap
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hInst = _WinAPI_LoadLibrary(@SystemDir & "\taskmgr.exe")
	$hBitmap = _GDIPlus_BitmapCreateFromResource($hInst, 103)
	
	; Save icon image to file
	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & "\ResourceTest.jpg")
	
	; Clean up
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_FreeLibrary($hInst)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
	
	ShellExecute(@MyDocumentsDir & "\ResourceTest.jpg")
EndFunc