#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region					Colors

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_AnimatePalette
; Description ...: replaces entries in the specified logical palette.
; Syntax.........: _GDI_AnimatePalette($hpal, $iStartIndex, $cEntries, $ppe)
; Parameters ....: $hpal         - [in] Handle to the logical palette.
;                  $iStartIndex  - [in] Specifies the first logical palette entry to be replaced.
;                  $cEntries     - [in] Specifies the number of entries to be replaced.
;                  $ppe          - [in] Pointer to the first member in an array of PALETTEENTRY structures used to 
;                                       replace the current entries.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps
;                    function and specifying the RASTERCAPS constant.
;                  The AnimatePalette function only changes entries with the PC_RESERVED flag set in the corresponding 
;                    palPalEntry member of the LOGPALETTE structure.
;                  If the given palette is associated with the active window, the colors in the palette are replaced immediately.
; Related .......: 
; Link ..........; @@MsdnLink@@ AnimatePalette
; Example .......;
; ===============================================================================================================================
Func _GDI_AnimatePalette($hpal, $iStartIndex, $cEntries, $ppe)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "AnimatePalette",  "ptr", $hpal, "UINT", $iStartIndex, "UINT", $cEntries, "ptr", $ppe)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateHalftonePalette
; Description ...: creates a halftone palette for the specified device context (DC).
; Syntax.........: _GDI_CreateHalftonePalette($hdc)
; Parameters ....: $hdc  - [in] Handle to the device context.
; Return values .: Success      - handle to a logical halftone palette
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application should create a halftone palette when the stretching mode of a device context is set to 
;                    HALFTONE. The logical halftone palette returned by CreateHalftonePalette should then be selected and
;                    realized into the device context before the StretchBlt or StretchDIBits function is called.
;                  When you no longer need the palette, call the DeleteObject function to delete it.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreateHalftonePalette
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateHalftonePalette($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateHalftonePalette", "ptr", $hdc)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreatePalette
; Description ...: creates a logical palette.
; Syntax.........: _GDI_CreatePalette($lplgpl)
; Parameters ....: $lplgpl  - [in] Pointer to a LOGPALETTE structure that contains information about the colors in the logical palette.
; Return values .: Success      - handle to a logical palette.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps 
;                    function and specifying the RASTERCAPS constant.
;                  Once an application creates a logical palette, it can select that palette into a device context by calling
;                    the SelectPalette function. A palette selected into a device context can be realized by calling the
;                    RealizePalette function.
;                  When you no longer need the palette, call the DeleteObject function to delete it.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreatePalette
; Example .......;
; ===============================================================================================================================
Func _GDI_CreatePalette($lplgpl)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreatePalette", "ptr", $lplgpl)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetColorAdjustment
; Description ...: retrieves the color adjustment values for the specified device context (DC).
; Syntax.........: _GDI_GetColorAdjustment($hdc, $lpca)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $lpca  - [out] Pointer to a COLORADJUSTMENT structure that receives the color adjustment values.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........; @@MsdnLink@@ GetColorAdjustment
; Example .......;
; ===============================================================================================================================
Func _GDI_GetColorAdjustment($hdc, $lpca)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetColorAdjustment", "ptr", $hdc, "ptr", $lpca)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetNearestColor
; Description ...: retrieves a color value identifying a color from the system palette that will be displayed when the 
;                    specified color value is used.
; Syntax.........: _GDI_GetNearestColor($hdc, $crColor)
; Parameters ....: $hdc      - [in] Handle to the device context.
;                  $crColor  - [in] Specifies a color value that identifies a requested color. To create a COLORREF color value, use the RGB macro.
; Return values .: Success      - color from the system palette that corresponds to the given color value
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........; @@MsdnLink@@ GetNearestColor
; Example .......;
; ===============================================================================================================================
Func _GDI_GetNearestColor($hdc, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, "DWORD", "GetNearestColor", "ptr", $hdc, "DWORD", $crColor)
	If @error Then Return SetError(1,0,$CLR_INVALID)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetNearestPaletteIndex
; Description ...: retrieves the index for the entry in the specified logical palette most closely matching a specified color value.
; Syntax.........: _GDI_GetNearestPaletteIndex($hpal, $crColor)
; Parameters ....: $hpal     - [in] Handle to a logical palette.
;                  $crColor  - [in] Specifies a color to be matched. To create a COLORREF color value, use the RGB macro.
; Return values .: Success      - index of an entry in a logical palette.
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps 
;                    function and specifying the RASTERCAPS constant.
;                  If the given logical palette contains entries with the PC_EXPLICIT flag set, the return value is undefined.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetNearestPaletteIndex
; Example .......;
; ===============================================================================================================================
Func _GDI_GetNearestPaletteIndex($hpal, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, "UINT", "GetNearestPaletteIndex", "ptr", $hpal,  "DWORD", $crColor)
	If @error Then Return SetError(1,0,$CLR_INVALID)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetPaletteEntries
; Description ...: retrieves a specified range of palette entries from the given logical palette.
; Syntax.........: _GDI_GetPaletteEntries($hpal, $iStartIndex, $nEntries, $lppe)
; Parameters ....: $hpal         - [in] Handle to the logical palette.
;                  $iStartIndex  - [in] Specifies the first entry in the logical palette to be retrieved.
;                  $nEntries     - [in] Specifies the number of entries in the logical palette to be retrieved.
;                  $lppe         - [out] Pointer to an array of PALETTEENTRY structures to receive the palette entries. 
;                                        The array must contain at least as many structures as specified by the nEntries parameter.
; Return values .: Success      - If the handle to the logical palette is a valid pointer (not NULL), the return value is 
;                                   the number of entries retrieved from the logical palette. 
;                                 If the function succeeds and handle to the logical palette is NULL, the return value is 
;                                   the number of entries in the given palette.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps 
;                    function and specifying the RASTERCAPS constant.
;                  If the nEntries parameter specifies more entries than exist in the palette, the remaining members of 
;                    the PALETTEENTRY structure are not altered.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetPaletteEntries
; Example .......;
; ===============================================================================================================================
Func _GDI_GetPaletteEntries($hpal, $iStartIndex, $nEntries, $lppe)
	Local $aResult = DllCall($__GDI_gdi32dll, "UINT", "GetPaletteEntries", "ptr", $hpal, "UINT", $iStartIndex, "UINT", $nEntries, "ptr", $lppe)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetSystemPaletteEntries
; Description ...: retrieves a range of palette entries from the system palette that is associated with the specified device context (DC).
; Syntax.........: _GDI_GetSystemPaletteEntries($hdc, $iStartIndex, $nEntries, $lppe)
; Parameters ....: $hdc          - [in] Handle to the device context.
;                  $iStartIndex  - [in] Specifies the first entry to be retrieved from the system palette.
;                  $nEntries     - [in] Specifies the number of entries to be retrieved from the system palette.
;                  $lppe         - [out] Pointer to an array of PALETTEENTRY structures to receive the palette entries.
;                                        The array must contain at least as many structures as specified by the nEntries parameter. 
;                                        If this parameter is NULL, the function returns the total number of entries in the palette.
; Return values .: Success      - number of entries retrieved from the palette.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps
;                    function and specifying the RASTERCAPS constant.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetSystemPaletteEntries
; Example .......;
; ===============================================================================================================================
Func _GDI_GetSystemPaletteEntries($hdc, $iStartIndex, $nEntries, $lppe)
	Local $aResult = DllCall($__GDI_gdi32dll, "UINT", "GetSystemPaletteEntries", "ptr", $hdc, "UINT", $iStartIndex, "UINT", $nEntries, "ptr", $lppe)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetSystemPaletteUse
; Description ...: retrieves the current state of the system (physical) palette for the specified device context (DC).
; Syntax.........: _GDI_GetSystemPaletteUse($hdc)
; Parameters ....: hdc  - [in] Handle to the device context.
; Return values .: Success      - current state of the system palette. This parameter can be one of the following values.
;                                  $SYSPAL_NOSTATIC  - The system palette contains no static colors except black and white.
;                                  $SYSPAL_STATIC    - The system palette contains static colors that will not change when an 
;                                                        application realizes its logical palette.
;                                  $SYSPAL_ERROR     - The given device context is invalid or does not support a color palette.
;                  Failure      - 0 ($SYSPAL_ERROR)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: By default, the system palette contains 20 static colors that are not changed when an application realizes 
;                    its logical palette. An application can gain access to most of these colors by calling the 
;                    SetSystemPaletteUse function.
;                  The device context identified by the hdc parameter must represent a device that supports color palettes.
;                  An application can determine whether or not a device supports color palettes by calling the GetDeviceCaps
;                    function and specifying the RASTERCAPS constant.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetSystemPaletteUse
; Example .......;
; ===============================================================================================================================
Func _GDI_GetSystemPaletteUse($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "UINT", "GetSystemPaletteUse",  "ptr", $hdc)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_RealizePalette
; Description ...: maps palette entries from the current logical palette to the system palette.
; Syntax.........: _GDI_RealizePalette($hdc)
; Parameters ....: $hdc  - [in] Handle to the device context into which a logical palette has been selected.
; Return values .: Success      - number of entries in the logical palette mapped to the system palette
;                  Failure      - $GDI_ERROR (0xFFFF)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps
;                    function and specifying the RASTERCAPS constant.
;                  The RealizePalette function modifies the palette for the device associated with the specified device context.
;                    If the device context is a memory DC, the color table for the bitmap selected into the DC is modified.
;                    If the device context is a display DC, the physical palette for that device is modified.
;                  A logical palette is a buffer between color-intensive applications and the system, allowing these applications
;                    to use as many colors as needed without interfering with colors displayed by other windows.
;                  When an application's window has the focus and it calls the RealizePalette function, the system attempts to 
;                    realize as many of the requested colors as possible. The same is also true for applications with inactive windows.
; Related .......: 
; Link ..........; @@MsdnLink@@ RealizePalette
; Example .......;
; ===============================================================================================================================
Func _GDI_RealizePalette($hdc);
	Local $aResult = DllCall($__GDI_gdi32dll, "UINT", "RealizePalette", "ptr", $hdc);
	If @error Then Return SetError(1,0,0xFFFF)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ResizePalette
; Description ...: increases or decreases the size of a logical palette based on the specified value.
; Syntax.........: _GDI_ResizePalette($hpal,$nEntries)
; Parameters ....: $hpal      - [in] Handle to the palette to be changed.
;                  $nEntries  - [in] Specifies the number of entries in the palette after it has been resized.
;                               Windows NT/2000/XP: the number of entries is limited to 1024.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps 
;                    function and specifying the RASTERCAPS constant.
;                  If an application calls ResizePalette to reduce the size of the palette, the entries remaining in the resized
;                    palette are unchanged. If the application calls ResizePalette to enlarge the palette, the additional palette
;                    entries are set to black (the red, green, and blue values are all 0) and their flags are set to zero.
; Related .......: 
; Link ..........; @@MsdnLink@@ ResizePalette
; Example .......;
; ===============================================================================================================================
Func _GDI_ResizePalette($hpal,$nEntries)
	Local $aResult = DllCall($__GDI_gdi32dll, "INT", "ResizePalette", "ptr", $hpal, "UINT", $nEntries)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SelectPalette
; Description ...: selects the specified logical palette into a device context.
; Syntax.........: _GDI_SelectPalette($hdc, $hpal, $bForceBackground)
; Parameters ....: $hdc               - [in] Handle to the device context.
;                  $hpal              - [in] Handle to the logical palette to be selected.
;                  $bForceBackground  - [in] Specifies whether the logical palette is forced to be a background palette. 
;                                            If this value is TRUE, the RealizePalette function causes the logical palette to be
;                                              mapped to the colors already in the physical palette in the best possible way. 
;                                              This is always done, even if the window for which the palette is realized belongs 
;                                              to a thread without active focus.
;                                            If this value is FALSE, RealizePalette causes the logical palette to be copied into
;                                              the device palette when the application is in the foreground. (If the hdc parameter 
;                                              is a memory device context, this parameter is ignored.)
; Return values .: Success      - handle to the device context's previous logical palette.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps 
;                    function and specifying the RASTERCAPS constant.
;                  An application can select a logical palette into more than one device context only if device contexts 
;                    are compatible. Otherwise SelectPalette fails. To create a device context that is compatible with 
;                    another device context, call CreateCompatibleDC with the first device context as the parameter.
;                    If a logical palette is selected into more than one device context, changes to the logical palette 
;                    will affect all device contexts for which it is selected.
;                  An application might call the SelectPalette function with the bForceBackground parameter set to TRUE if 
;                    the child windows of a top-level window each realize their own palettes. However, only the child window
;                    that needs to realize its palette must set bForceBackground to TRUE; other child windows must set 
;                    this value to FALSE.
; Related .......: 
; Link ..........; @@MsdnLink@@ SelectPalette
; Example .......;
; ===============================================================================================================================
Func _GDI_SelectPalette($hdc, $hpal, $bForceBackground)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "SelectPalette", "ptr", $hdc, "ptr", $hpal, "int", $bForceBackground)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetColorAdjustment
; Description ...: sets the color adjustment values for a device context (DC) using the specified values.
; Syntax.........: _GDI_SetColorAdjustment($hdc, $lpca)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $lpca  - [in] Pointer to a COLORADJUSTMENT structure containing the color adjustment values.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The color adjustment values are used to adjust the input color of the source bitmap for calls to the 
;                    StretchBlt and StretchDIBits functions when HALFTONE mode is set.
; Related .......: 
; Link ..........; @@MsdnLink@@ SetColorAdjustment
; Example .......;
; ===============================================================================================================================
Func _GDI_SetColorAdjustment($hdc, $lpca)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SetColorAdjustment", "ptr", $hdc, "ptr", $lpca)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetPaletteEntries
; Description ...: sets RGB (red, green, blue) color values and flags in a range of entries in a logical palette.
; Syntax.........: _GDI_SetPaletteEntries($hpal, $iStart, $cEntries, $lppe)
; Parameters ....: $hpal      - [in] Handle to the logical palette.
;                  $iStart    - [in] Specifies the first logical-palette entry to be set.
;                  $cEntries  - [in] Specifies the number of logical-palette entries to be set.
;                  $lppe      - [in] Pointer to the first member of an array of PALETTEENTRY structures 
;                                    containing the RGB values and flags.
; Return values .: Success      - number of entries that were set in the logical palette.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether or not a device supports palette operations by calling the GetDeviceCaps
;                    function and specifying the RASTERCAPS constant.
;                  Even if a logical palette has been selected and realized, changes to the palette do not affect the physical
;                    palette in the surface. RealizePalette must be called again to set the new logical palette into the surface.
; Related .......: 
; Link ..........; @@MsdnLink@@ SetPaletteEntries
; Example .......;
; ===============================================================================================================================
Func _GDI_SetPaletteEntries($hpal, $iStart, $cEntries, $lppe)
	Local $aResult = DllCall($__GDI_gdi32dll, "uint", "SetPaletteEntries", "ptr", $hpal, "UINT", $iStart, "UINT", $cEntries, "ptr", $lppe)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetSystemPaletteUse
; Description ...: allows an application to specify whether the system palette contains 2 or 20 static colors. 
;                    The default system palette contains 20 static colors. 
;                    (Static colors cannot be changed when an application realizes a logical palette.)
; Syntax.........: _GDI_SetSystemPaletteUse($hdc, $uUsage)
; Parameters ....: $hdc [in] Handle to the device context. This device context must refer to a device that supports color palettes.
;                  $uUsage [in] Specifies the new use of the system palette. This parameter can be one of the following values.
;                  $SYSPAL_NOSTATIC The system palette contains two static colors (black and white).
;                  $SYSPAL_NOSTATIC256 Windows 2000/XP: The system palette contains no static colors.
;                  $SYSPAL_STATIC The system palette contains static colors that will not change when an application realizes its logical palette.
; Return values .: Success      - previous system palette. It can be either $SYSPAL_NOSTATIC, $SYSPAL_NOSTATIC256, or $SYSPAL_STATIC.
;                  Failure      - 0 ($SYSPAL_ERROR)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps function
;                    and specifying the RASTERCAPS constant.
;                  When an application window moves to the foreground and the SYSPAL_NOSTATIC value is set, the application must
;                    call the GetSysColor function to save the current system colors setting. It must also call SetSysColors to
;                    set reasonable values using only black and white. When the application returns to the background or terminates,
;                    the previous system colors must be restored.
;                  If the function returns SYSPAL_ERROR, the specified device context is invalid or does not support color palettes.
;                  An application must call this function only when its window is maximized and has the input focus.
;                  If an application calls SetSystemPaletteUse with uUsage set to SYSPAL_NOSTATIC, the system continues to set aside
;                    two entries in the system palette for pure white and pure black, respectively.
;                  After calling this function with uUsage set to SYSPAL_NOSTATIC, an application must take the following steps:
;                    1. Realize the logical palette.
;                    2. Call the GetSysColor function to save the current system-color settings.
;                    3. Call the SetSysColors function to set the system colors to reasonable values using black and white. For example,
;                       adjacent or overlapping items (such as window frames and borders) should be set to black and white, respectively.
;                    4. Send the WM_SYSCOLORCHANGE message to other top-level windows to allow them to be redrawn with the new system colors.
;                  When the application's window loses focus or closes, the application must perform the following steps:
;                    1. Call SetSystemPaletteUse with the uUsage parameter set to SYSPAL_STATIC.
;                    2. Realize the logical palette.
;                    3. Restore the system colors to their previous values.
;                    4. Send the WM_SYSCOLORCHANGE message.
; Related .......: 
; Link ..........; @@MsdnLink@@ SetSystemPaletteUse
; Example .......;
; ===============================================================================================================================
Func _GDI_SetSystemPaletteUse($hdc, $uUsage)
	Local $aResult = DllCall($__GDI_gdi32dll, "uint", "SetSystemPaletteUse", "ptr", $hdc, "UINT", $uUsage)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_UnrealizeObject
; Description ...: resets the origin of a brush or resets a logical palette. If the hgdiobj parameter is a handle to a brush,
;                    UnrealizeObject directs the system to reset the origin of the brush the next time it is selected. 
;                    If the hgdiobj parameter is a handle to a logical palette, UnrealizeObject directs the system to realize 
;                    the palette as though it had not previously been realized. The next time the application calls the 
;                    RealizePalette function for the specified palette, the system completely remaps the logical palette 
;                    to the system palette.
; Syntax.........: _GDI_UnrealizeObject($hgdiobj)
; Parameters ....: $hgdiobj  - [in] Handle to the logical palette to be reset.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The UnrealizeObject function should not be used with stock objects. For example, the default palette,
;                    obtained by calling GetStockObject (DEFAULT_PALETTE), is a stock object.
;                  A palette identified by hgdiobj can be the currently selected palette of a device context.
;                  Windows 95/98/Me: 
;                    Automatic tracking of the brush origin is not supported. Applications must use the UnrealizeObject,
;                    SetBrushOrgEx and SelectObject functions to align the brush before using it.
;                  Windows 2000/XP:
;                    If hgdiobj is a brush, UnrealizeObject does nothing, and the function returns TRUE.
;                    Use SetBrushOrgEx to set the origin of a brush.
; Related .......: 
; Link ..........; @@MsdnLink@@ UnrealizeObject
; Example .......;
; ===============================================================================================================================
Func _GDI_UnrealizeObject($hgdiobj)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "UnrealizeObject", "ptr", $hgdiobj)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_UpdateColors
; Description ...: updates the client area of the specified device context by remapping the current colors in the client area to
;                    the currently realized logical palette.
; Syntax.........: _GDI_UpdateColors($hdc)
; Parameters ....: $hdc  - [in] Handle to the device context.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application can determine whether a device supports palette operations by calling the GetDeviceCaps
;                    function and specifying the RASTERCAPS constant.
;                  An inactive window with a realized logical palette may call UpdateColors as an alternative to redrawing 
;                    its client area when the system palette changes.
;                  The UpdateColors function typically updates a client area faster than redrawing the area. However, because
;                    UpdateColors performs the color translation based on the color of each pixel before the system palette
;                    changed, each call to this function results in the loss of some color accuracy.
;                  This function must be called soon after a WM_PALETTECHANGED message is received.
; Related .......: 
; Link ..........; @@MsdnLink@@ UpdateColors
; Example .......;
; ===============================================================================================================================
Func _GDI_UpdateColors($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "UpdateColors", "ptr", $hdc)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]
EndFunc

#EndRegion
;*************************************************************