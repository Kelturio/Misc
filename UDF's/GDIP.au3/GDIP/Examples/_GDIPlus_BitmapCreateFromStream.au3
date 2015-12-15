; Thanks to trancexx for the code this example is built from: http://www.autoitscript.com/forum/index.php?showtopic=98526&view=findpost&p=709026

#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <Memory.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics
	Local $hBmp, $hBitmap, $hBitmapFromStream
	Local $sEncoderCLSID, $tEncoderCLSID, $pEncoderCLSID
	Local $pStream

	; Initialize GDI+
	_GDIPlus_Startup()

	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)

	$sEncoderCLSID = _GDIPlus_EncodersGetCLSID("tiff")
	$tEncoderCLSID = _WinAPI_GUIDFromString($sEncoderCLSID)
	$pEncoderCLSID = DllStructGetPtr($tEncoderCLSID)
	$pStream = _WinAPI_CreateStreamOnHGlobal()
	_GDIPlus_ImageSaveToStream($hBitmap, $pStream, $pEncoderCLSID)

	$hBitmapFromStream = _GDIPlus_BitmapCreateFromStream($pStream)

	GUISetState()
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmapFromStream, 0, 0)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up
	_GDIPlus_ImageDispose($hBitmapFromStream)
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DeleteObject($hBmp)

	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateStreamOnHGlobal
; Description ...: Creates a stream object that uses an HGLOBAL memory handle to store the stream contents
; Syntax.........: _WinAPI_CreateStreamOnHGlobal([$hGlobal = 0[, $fDeleteOnRelease = True]])
; Parameters ....: $hGlobal 	     - A memory handle. If 0, a new handle is to be allocated instead
;                  $fDeleteOnRelease - If True, the release of the IStream interface releases the memory handle as well.
;                  Otherwise, it's the responsibility of the user to release this memory handle.
; Return values .: Success      - A pointer to new stream object
;                  Failure      - 0
; Remarks .......: None
; Related .......: _MemGlobalFree
; Link ..........; @@MsdnLink@@ CreateStreamOnHGlobal
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $fDeleteOnRelease = True)
	Local $aResult = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", "hwnd", $hGlobal, "int", $fDeleteOnRelease, "ptr*", 0)

	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_WinAPI_CreateStreamOnHGlobal