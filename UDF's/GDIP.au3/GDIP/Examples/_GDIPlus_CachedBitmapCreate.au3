#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI
	Local $hGraphics, $hBmp, $hBitmap, $hCachedBitmap
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; Create a cached bitmap from existing bitmap and graphics objects
	$hCachedBitmap = _GDIPlus_CachedBitmapCreate($hBitmap, $hGraphics)
	
	GUISetState()
	; Now draw the cached bitmap
	_GDIPlus_GraphicsDrawCachedBitmap($hGraphics, $hCachedBitmap, 0, 0)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_CachedBitmapDispose($hCachedBitmap)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc