#include <FontConstants.au3>
#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt("MustDeclareVars", 1)

Global Const $DTT_TEXTCOLOR = 0x00000001
Global Const $DTT_GLOWSIZE = 0x00000800
Global Const $DTT_COMPOSITED = 0x00002000

; $tagDTTOPTS structure - specifies various options used by _WinAPI_DrawThemeTextEx
Global Const $tagDTTOPTS = _
"uint Size;uint Flags;uint clrText;uint clrBorder;uint clrShadow;int TextShadowType;" & $tagPOINT & _
";int BorderSize;int FontPropId;int ColorPropId;int StateId;int ApplyOverlay;int GlowSize;ptr DrawTextCallback;int lParam;"

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hDC, $hCDC, $hTheme
	Local $hBitmap, $hDIBBmp, $hOldBmp, $hFont, $hOldFont
	Local $pBitmapData, $tBmpInfo, $tDTTOptions, $pDTTOptions, $tClientRect, $pClientRect

	; Initialize GDI+
	_GDIPlus_Startup()

	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	GUISetState()

	; Opens the theme data for GUI window and its associated class.
	$hTheme = _WinAPI_OpenThemeData($hGUI, "globals")

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)
    $hCDC = _WinAPI_CreateCompatibleDC($hDC)
	$tClientRect = _WinAPI_GetClientRect($hGUI)
	$pClientRect = DllStructGetPtr($tClientRect)


    $tBmpInfo = DllStructCreate($tagBITMAPINFO)
    DllStructSetData($tBmpInfo, "Size", DllStructGetSize($tBmpInfo)-4)
    DllStructSetData($tBmpInfo, "Width", @DesktopWidth)
    DllStructSetData($tBmpInfo, "Height", -@DesktopHeight)
    DllStructSetData($tBmpInfo, "Planes", 1)
    DllStructSetData($tBmpInfo, "BitCount", 32)
    DllStructSetData($tBmpInfo, "Compression", 0) ; BI_RGB

	; Create the DIB object and select assign to the memory device context
    $hDIBBmp = _WinAPI_CreateDIBSection($hDC, $tBmpInfo, $pBitmapData)
	$hFont = _WinAPI_CreateFont(50, 30, 0, 0, 400, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, 'Courier New')

    $hOldBmp = _WinAPI_SelectObject($hCDC, $hDIBBmp) ; Select the DIBBMP object before drawing text
	$hOldFont = _WinAPI_SelectObject($hCDC, $hFont)  ; Select the font object

    $tDTTOptions = DllStructCreate($tagDTTOPTS)
    DllStructSetData($tDTTOptions, "Size", DllStructGetSize($tDTTOptions))
    DllStructSetData($tDTTOptions, "Flags", BitOR($DTT_GLOWSIZE, $DTT_TEXTCOLOR, $DTT_COMPOSITED)) ; GlowSize and ClrText members are valid
    DllStructSetData($tDTTOptions, "GlowSize", 25)
	DllStructSetData($tDTTOptions, "clrText", _RGBtoBGR($GDIP_CHOCOLATE))
	$pDTTOptions = DllStructGetPtr($tDTTOptions)

    _WinAPI_DrawThemeTextEx($hTheme, $hCDC, 0, 0, "AutoIt GDI+", BitOR($DT_SINGLELINE, $DT_CENTER, $DT_VCENTER, $DT_NOPREFIX), $pClientRect, $pDTTOptions)

	; Release the graphics dc for painting
	_WinAPI_SelectObject($hCDC, $hOldFont)
	_WinAPI_SelectObject($hCDC, $hOldBmp)
	_WinAPI_DeleteObject($hFont)
	_WinAPI_DeleteDC($hCDC)
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)

	$hBitmap = _GDIPlus_BitmapCreateFromGdiDib($tBmpInfo, $pBitmapData)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)


	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up
	 _GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_WinAPI_DeleteObject($hDIBBmp)

	_WinAPI_CloseThemeData($hTheme)

	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc

Func _RGBtoBGR($iRGB)
	Return Dec(StringMid(Binary($iRGB), 3, 6))
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CloseThemeData
; Description ...: Closes the theme data handle
; Syntax.........: _WinAPI_CloseThemeData($hTheme)
; Parameters ....: $hTheme - Handle to a window's specified theme data
; Return values .: Success      - True
;                  Failure      - False and either:
; Remarks .......: This function should be called when a window that has a visual style applied is destroyed
; Related .......: _WinAPI_OpenThemeData
; Link ..........; @@MsdnLink@@ CloseThemeData
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_CloseThemeData($hTheme)
	Local $aResult = DllCall("uxtheme.dll", "int", "CloseThemeData", "hwnd", $hTheme)

	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_WinAPI_CloseThemeData

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateDIBSection
; Description ...: Creates a DIB that applications can write to directly
; Syntax.........: _WinAPI_CreateDIBSection($hDC, $tBmpInfo, ByRef $pBits)
; Parameters ....: $hDC 	 - A handle to a device context
;                  $tBmpInfo - $tagBITMAPINFO structure that specifies various attributes of the DIB
;                  $pBits    - Reference to a variable that receives a pointer to the location of the DIB bit values
; Return values .: Success      - A handle to the newly created DIB
;                  Failure      - 0:
;                  |If @error is -1, there was an invalid parameter specified for the function
;                  |If @error is -2, the function failed, call _WinAPI_GetLastError to get the error code
; Remarks .......: None
; Related .......: $tagBITMAPINFO
; Link ..........; @@MsdnLink@@ CreateDIBSection
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_CreateDIBSection($hDC, $tBmpInfo, ByRef $pBits)
	Local $pBmpInfo, $aResult

	$pBmpInfo = DllStructGetPtr($tBmpInfo)
	$aResult = DllCall("gdi32.dll", "hwnd", "CreateDIBSection", "hwnd", $hDC, "ptr", $pBmpInfo, "uint", 0, "int*", 0, "hwnd", 0, "uint", 0)

	If @error Then Return SetError(@error, @extended, 0)
	If $aResult[0] = 87 Then Return SetError(-1, 0, 0); 87 = ERROR_INVALID_PARAMETER
	If $aResult[0] = 0 Then Return SetError(-2, 0, 0)
	$pBits = $aResult[4]
	Return SetError(0, 0, $aResult[0])
EndFunc   ;==>_WinAPI_CreateDIBSection

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_DrawThemeTextEx
; Description ...: Draws text using the color and font defined by the visual style
; Syntax.........: _WinAPI_DrawThemeTextEx($hTheme, $hDC, $iPartId, $iStateId, $sText, $iFlags, $pRect, $pDTTOPTS)
; Parameters ....: $hTheme   - Handle to a window's specified theme data
;                  $hDC		 - Handle to a device context to use for drawing
;                  $iPartId  - The control part that has the desired text appearance
;                  $iStateId - The control state that has the desired text appearance
;                  $sText	 - String to be drawn
;                  $iFlags	 - String formatting flags (see remarks)
;                  $pRect	 - Pointer to a $tagRECT structure that contains the rectangle in which the text is to be drawn
;                  $pDTTOPTS - Pointer to a $tagDTTOPTS structure that defines additional formatting options that will be applied
;                  +to the text being drawn
; Return values .: Success      - True
;                  Failure      - False
; Remarks .......: The formatting flags are the same flags used by _WinAPI_DrawText
; Related .......: _WinAPI_DrawText
; Link ..........; @@MsdnLink@@ DrawThemeTextEx
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_DrawThemeTextEx($hTheme, $hDC, $iPartId, $iStateId, $sText, $iFlags, $pRect, $pDTTOPTS)
	Local $aResult = DllCall("uxtheme.dll", "int", "DrawThemeTextEx", "ptr", $hTheme, "hwnd", $hDC, "int", $iPartId, "int", $iStateId, "wstr", $sText, "int", -1, "uint", $iFlags, "ptr", $pRect, "ptr", $pDTTOPTS)

	If @error Then Return SetError(@error, @extended, 0)
	Return SetError(0, 0, $aResult[0] = 0)
EndFunc   ;==>_WinAPI_DrawThemeTextEx

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_OpenThemeData
; Description ...: Opens the theme data for a window and its associated class
; Syntax.........: _WinAPI_OpenThemeData($hWnd, $sClassList)
; Parameters ....: $hWnd	   - Handle of the window for which theme data is required
;                  $sClassList - String that contains a semicolon-separated list of classes
; Return values .: Success      - A handle to the newly loaded icon
;                  Failure      - 0
; Remarks .......: None
; Related .......: _WinAPI_CloseThemeData
; Link ..........; @@MsdnLink@@ OpenThemeData
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_OpenThemeData($hWnd, $sClassList)
	Local $aResult = DllCall("uxtheme.dll", "hwnd", "OpenThemeData", "hwnd", $hWnd, "wstr", $sClassList)

	If @error Then Return SetError(@error, @extended, 0)
	Return SetError(0, 0, $aResult[0])
EndFunc   ;==>_WinAPI_OpenThemeData