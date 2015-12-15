#include <Constants.au3>
#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <StaticConstants.au3> 
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $Label
	Local $hBmp, $hBitmap, $hIcon
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_HICONCreateFromBitmap Example", 400, 200)
	$Label = GUICtrlCreateLabel("", 120, 20, 160, 160, $SS_ICON)
	GUISetState()
	
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	$hIcon = _GDIPlus_HICONCreateFromBitmap($hBitmap)
	GUICtrlSendMsg($Label, 370, $IMAGE_ICON, $hIcon) ; STM_SETIMAGE = 370
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_WinAPI_DestroyIcon($hIcon)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc