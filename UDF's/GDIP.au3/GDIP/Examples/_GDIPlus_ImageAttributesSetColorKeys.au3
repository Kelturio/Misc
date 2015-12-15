#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBmp, $hBitmap, $hIA
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight/2)
	GUISetBkColor(0x00C080)
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	
	; Create GDI+ Bitmap object from GDI Bitmap object
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	; Create an ImageAttribute object and set it's color key
	$hIA = _GDIPlus_ImageAttributesCreate()
	; Make a total range of 4210752 colors transparent
	_GDIPlus_ImageAttributesSetColorKeys($hIA, 0, True, 0xFF000000, 0xFF404040)
	
	GUISetState()
	
	; Set interpolation mode to increase shrinking quality
	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
	
	; Draw the image while applying the color adjustment
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hBitmap, 0, 0, @DesktopWidth, @DesktopHeight, 0, 0, @DesktopWidth, @DesktopHeight/2, $hIA)
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