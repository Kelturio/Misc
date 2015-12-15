#include <GDIP.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hInst, $hIcon, $hBitmap

	; Initialize GDI+
	_GDIPlus_Startup()

	$hInst = _WinAPI_GetModuleHandle("user32.dll")
	$hIcon = _WinAPI_LoadIcon($hInst, 104)

	$hBitmap = _GDIPlus_BitmapCreateFromHICON($hIcon)

	; Save icon image to file
	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & "\Information.jpg")

	; Clean up
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DestroyIcon($hIcon)

	; Uninitialize GDI+
	_GDIPlus_Shutdown()

	ShellExecute(@MyDocumentsDir & "\Information.jpg")
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_LoadIcon
; Description ...: Loads the specified icon resource from the executable (.exe) file associated with an application instance
; Syntax.........: _WinAPI_LoadIcon($hInstance, $vIconName)
; Parameters ....: $hInstance - Handle to an instance of the module whose executable file contains the icon to be loaded. This
;                  +parameter must be 0 when a standard icon is being loaded
;                  $vIconName - A string representing the icon resource name. Alternatively, this can be a number specifying the
;                  +resource identifier.
; Return values .: Success      - A handle to the newly loaded icon
;                  Failure      - 0
; Remarks .......: After you are done with the object, call _WinAPI_DestroyIcon to release the object resources
; Related .......: _WinAPI_DestroyIcon, _WinAPI_LoadImage
; Link ..........; @@MsdnLink@@ LoadIconA
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_LoadIcon($hInstance, $vIconName)
	Local $sType, $aResult

	If IsString($vIconName) Then
		$sType = "str"
	Else
		$sType = "int"
	EndIf
	$aResult = DllCall("user32.dll", "hwnd", "LoadIconA", "hwnd", $hInstance, $sType, $vIconName)

	If @error Then Return SetError(@error, @extended, 0)
	Return SetError(0, 0, $aResult[0])
EndFunc   ;==>_WinAPI_LoadIcon