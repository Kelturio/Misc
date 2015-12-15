#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

;*************************************************************
#Region					Brushes

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateBrushIndirect
; Description ...: creates a logical brush that has the specified style, color, and pattern.
; Syntax.........: _GDI_CreateBrushIndirect($lplb)
; Parameters ....: $lplb   - [in] Pointer to a LOGBRUSH structure that contains information about the brush.
; Return values .: Success      - HBRUSH Value that identifies a logical brush.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: A brush is a bitmap that the system uses to paint the interiors of filled shapes.
;                  After an application creates a brush by calling CreateBrushIndirect, it can select it into any 
;                    device context by calling the SelectObject function.
;                  A brush created by using a monochrome bitmap (one color plane, one bit per pixel) is drawn using the
;                    current text and background colors. Pixels represented by a bit set to 0 are drawn with the current 
;                    text color; pixels represented by a bit set to 1 are drawn with the current background color.
;                  When you no longer need the brush, call the DeleteObject function to delete it.
;                  ICM: No color is done at brush creation. However, color management is performed when the brush is selected 
;                    into an ICM-enabled device context.
;                  Windows 98/Me and Windows NT/2000/XP: Brushes can be created from bitmaps or DIBs larger than 8 by 8 pixels.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreateBrushIndirect
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateBrushIndirect($lplb)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateBrushIndirect", "ptr", $lplb)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateDIBPatternBrush
; Description ...: Creates a logical brush that has the pattern specified by the specified device-independent bitmap (DIB). 
;                    The brush can subsequently be selected into any device context that is associated with a device that supports raster operations.
;                  Note: This function is provided only for compatibility with 16-bit versions of Windows. Applications should 
;                          use the CreateDIBPatternBrushPt function.
; Syntax.........: _GDI_CreateDIBPatternBrush($hglbDIBPacked, $fuColorSpec)
; Parameters ....: $hglbDIBPacked  - [in] Handle to a global memory object containing a packed DIB, which consists of a BITMAPINFO 
;                                         structure immediately followed by an array of bytes defining the pixels of the bitmap.
;                                    Windows 98/Me and Windows NT/2000/XP: 
;                                         Brushes can be created from bitmaps or DIBs larger than 8 by 8 pixels.
;                  $fuColorSpec    - [in] Specifies whether the bmiColors member of the BITMAPINFO structure is initialized and, 
;                                         if so, whether this member contains explicit red, green, blue (RGB) values or indexes
;                                         into a logical palette. The fuColorSpec parameter must be one of the following values.
;                                    $DIB_PAL_COLORS   A color table is provided and consists of an array of 16-bit indexes into
;                                         the logical palette of the device context into which the brush is to be selected.
;                                    $DIB_RGB_COLORS   A color table is provided and contains literal RGB values.
; Return values .: Success      - HBRUSH Value that identifies a logical brush.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: When an application selects a two-color DIB pattern brush into a monochrome device context, the system 
;                    does not acknowledge the colors specified in the DIB; instead, it displays the pattern brush using the
;                    current background and foreground colors of the device context. Pixels mapped to the first color of the DIB
;                    (offset 0 in the DIB color table) are displayed using the foreground color; pixels mapped to the second 
;                    color (offset 1 in the color table) are displayed using the background color.
;                  When you no longer need the brush, call the DeleteObject function to delete it.
;                  ICM: No color is done at brush creation. However, color management is performed when the brush is selected 
;                    into an ICM-enabled device context.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreateDIBPatternBrush
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateDIBPatternBrush($hglbDIBPacked, $fuColorSpec)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateDIBPatternBrush", "ptr", $hglbDIBPacked, "UINT", $fuColorSpec)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateDIBPatternBrushPt
; Description ...: Creates a logical brush that has the pattern specified by the device-independent bitmap (DIB).
; Syntax.........: _GDI_CreateDIBPatternBrushPt($lpPackedDIB, $fuColorSpec)
; Parameters ....: $lpPackedDIB  - [in] Pointer to a packed DIB consisting of a BITMAPINFO structure immediately followed by 
;                                       an array of bytes defining the pixels of the bitmap.
;                                  Windows 98/Me and Windows NT/2000/XP:
;                                       Brushes can be created from bitmaps or DIBs larger than 8 by 8 pixels.
;                  $fuColorSpec  - [in] Specifies whether the bmiColors member of the BITMAPINFO structure contains a 
;                                       valid color table and, if so, whether the entries in this color table contain explicit 
;                                       red, green, blue (RGB) values or palette indexes. 
;                                  The iUsage parameter must be oneof the following values.
;                                      $DIB_PAL_COLORS   A color table is provided and consists of an array of 16-bit indexes into
;                                        the logical palette of the device context into which the brush is to be selected.
;                                      $DIB_RGB_COLORS   A color table is provided and contains literal RGB values.
; Return values .: Success      - HBRUSH Value that identifies a logical brush.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: A brush is a bitmap that the system uses to paint the interiors of filled shapes.
;                  After an application creates a brush by calling CreateDIBPatternBrushPt, it can select that brush into 
;                    any device context by calling the SelectObject function.
;                  When you no longer need the brush, call the DeleteObject function to delete it.
;                  ICM: No color is done at brush creation. However, color management is performed when the brush is selected
;                    into an ICM-enabled device context.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreateDIBPatternBrushPt
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateDIBPatternBrushPt($lpPackedDIB, $fuColorSpec)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateDIBPatternBrushPt", "ptr", $lpPackedDIB, "UINT", $fuColorSpec)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateHatchBrush
; Description ...: creates a logical brush that has the specified hatch pattern and color.
; Syntax.........: _GDI_CreateHatchBrush($fnStyle, $clrref)
; Parameters ....: $fnStyle  - [in] Specifies the hatch style of the brush. This parameter can be one of the following values.
;                                   $HS_BDIAGONAL    45-degree upward left-to-right hatch
;                                   $HS_CROSS        Horizontal and vertical crosshatch
;                                   $HS_DIAGCROSS    45-degree crosshatch
;                                   $HS_FDIAGONAL    45-degree downward left-to-right hatch
;                                   $HS_HORIZONTAL   Horizontal hatch
;                                   $HS_VERTICAL     Vertical hatch
;                  $clrref   - [in] Specifies the foreground color of the brush that is used for the hatches. 
;                                   To create a COLORREF color value, use the RGB macro.
; Return values .: Success      - HBRUSH Value that identifies a logical brush.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: A brush is a bitmap that the system uses to paint the interiors of filled shapes.
;                  After an application creates a brush by calling CreateHatchBrush, it can select that brush into any 
;                    device context by calling the SelectObject function.
;                  If an application uses a hatch brush to fill the backgrounds of both a parent and a child window with 
;                    matching color, it may be necessary to set the brush origin before painting the background of the 
;                    child window. You can do this by having your application call the SetBrushOrgEx function. Your application 
;                    can retrieve the current brush origin by calling the GetBrushOrgEx function.
;                  When you no longer need the brush, call the DeleteObject function to delete it.
;                  ICM: No color is done at brush creation. However, color management is performed when the brush is 
;                    selected into an ICM-enabled device context.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreateHatchBrush
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateHatchBrush($fnStyle, $clrref)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateHatchBrush", "int", $fnStyle, "DWORD", $clrref)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreatePatternBrush
; Description ...: Creates a logical brush with the specified bitmap pattern. The bitmap can be a DIB section bitmap, 
;                    which is created by the CreateDIBSection function, or it can be a device-dependent bitmap.
; Syntax.........: _GDI_CreatePatternBrush($hbmp)
; Parameters ....: hbmp   - [in] Handle to the bitmap to be used to create the logical brush.
;                           Windows 98/Me and Windows NT/2000/XP: 
;                                Brushes can be created from bitmaps or DIBs larger than 8 by 8 pixels.
; Return values .: Success      - HBRUSH Value that identifies a logical brush.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: A pattern brush is a bitmap that the system uses to paint the interiors of filled shapes.
;                    After an application creates a brush by calling CreatePatternBrush, it can select that brush into any 
;                    device context by calling the SelectObject function.
;                  You can delete a pattern brush without affecting the associated bitmap by using the DeleteObject function. 
;                    Therefore, you can then use this bitmap to create any number of pattern brushes.
;                  A brush created by using a monochrome (1 bit per pixel) bitmap has the text and background colors of the 
;                    device context to which it is drawn. Pixels represented by a 0 bit are drawn with the current text color; 
;                    pixels represented by a 1 bit are drawn with the current background color.
;                  ICM: No color is done at brush creation. However, color management is performed when the brush is selected 
;                    into an ICM-enabled device context.
; Related .......: 
; Link ..........; @@MsdnLink@@ CreatePatternBrush
; Example .......;
; ===============================================================================================================================
Func _GDI_CreatePatternBrush($hbmp)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreatePatternBrush", "ptr", $hbmp)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateSolidBrush
; Description ...: Creates a logical brush that has the specified solid color
; Syntax.........: _GDI_CreateSolidBrush($nColor)
; Parameters ....: $nColor      - Specifies the color of the brush
; Return values .: Success      - HBRUSH Value that identifies a logical brush
;                  Failure      - 0
; Author ........: Gary Frost
; Modified.......: Prog@ndy
; Remarks .......: When you no longer need the HBRUSH object call the _GDI_DeleteObject function to delete it
; Related .......:
; Link ..........; @@MsdnLink@@ CreateSolidBrush
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateSolidBrush($nColor)
	Local $hBrush = DllCall($__GDI_gdi32dll, 'ptr', 'CreateSolidBrush', 'int', $nColor)
	If @error Then Return SetError(@error, 0, 0)
	Return $hBrush[0]
EndFunc   ;==>_GDI_CreateSolidBrush

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetBrushOrgEx
; Description ...: Retrieves the current brush origin for the specified device context. 
;                    This function replaces the GetBrushOrg function.
; Syntax.........: _GDI_GetBrushOrgEx($hdc, $lppt)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $lppt  - [out] Pointer to a POINT structure that receives the brush origin, in device coordinates.
; Return values .: Success      - nonzero (true)
;                  Failure      - 0 (false)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: A brush is a bitmap that the system uses to paint the interiors of filled shapes.
;                  The brush origin is a set of coordinates with values between 0 and 7, specifying the location of one pixel 
;                    in the bitmap. The default brush origin coordinates are (0,0). For horizontal coordinates, the value 0 
;                    corresponds to the leftmost column of pixels; the value 7 corresponds to the rightmost column. 
;                    For vertical coordinates, the value 0 corresponds to the uppermost row of pixels; the value 7 corresponds
;                    to the lowermost row. When the system positions the brush at the start of any painting operation, it maps
;                    the origin of the brush to the location in the window's client area specified by the brush origin.
;                    For example, if the origin is set to (2,3), the system maps the origin of the brush (0,0) to the location 
;                    (2,3) on the window's client area.
;                  If an application uses a brush to fill the backgrounds of both a parent and a child window with matching 
;                    colors, it may be necessary to set the brush origin after painting the parent window but before painting
;                    the child window.
;                  Windows NT/2000/XP: The system automatically tracks the origin of all window-managed device contexts and 
;                    adjusts their brushes as necessary to maintain an alignment of patterns on the surface.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetBrushOrgEx
; Example .......;
; ===============================================================================================================================
Func _GDI_GetBrushOrgEx($hdc, $lppt)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "GetBrushOrgEx", "ptr", $hdc, "ptr", $lppt)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetSysColorBrush
; Description ...: retrieves a handle identifying a logical brush that corresponds to the specified color index
; Syntax.........: _GDI_GetSysColorBrush($iIndex)
; Parameters ....: $iIndex      - The display element whose color is to be retrieved
; Return values .: Success      - A logical brush if $iIndex is supported by the current platform
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetSysColorBrush
; Example .......;
; ===============================================================================================================================
Func _GDI_GetSysColorBrush($iIndex)
	Local $aResult

	$aResult = DllCall($__GDI_user32dll, "ptr", "GetSysColorBrush", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetSysColorBrush

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PatBlt
; Description ...: Paints the specified rectangle using the brush that is currently selected into the specified device context.
;                    The brush color and the surface color or colors are combined by using the specified raster operation.
; Syntax.........: _GDI_PatBlt($hdc, $nXLeft, $nYLeft, $nWidth, $nHeight, $dwRop)
; Parameters ....: $hdc      - [in] Handle to the device context.
;                  $nXLeft   - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the rectangle to be filled.
;                  $nYLeft   - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the rectangle to be filled.
;                  $nWidth   - [in] Specifies the width, in logical units, of the rectangle.
;                  $nHeight  - [in] Specifies the height, in logical units, of the rectangle.
;                  $dwRop    - [in] Specifies the raster operation code. This code can be one of the following values.
;                                   $PATCOPY     Copies the specified pattern into the destination bitmap.
;                                   $PATINVERT   Combines the colors of the specified pattern with the colors of the destination rectangle by using the Boolean XOR operator.
;                                   $DSTINVERT   Inverts the destination rectangle.
;                                   $BLACKNESS   Fills the destination rectangle using the color associated with index 0 in the physical palette. (This color is black for the default physical palette.)
;                                   $WHITENESS   Fills the destination rectangle using the color associated with index 1 in the physical palette. (This color is white for the default physical palette.)
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The values of the dwRop parameter for this function are a limited subset of the full 256 ternary 
;                    raster-operation codes; in particular, an operation code that refers to a source rectangle cannot be used.
;                  Not all devices support the PatBlt function. For more information, see the description of the 
;                    RC_BITBLT capability in the GetDeviceCaps function.
; Related .......: 
; Link ..........; @@MsdnLink@@ PatBlt
; Example .......;
; ===============================================================================================================================
Func _GDI_PatBlt($hdc, $nXLeft, $nYLeft, $nWidth, $nHeight, $dwRop)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "PatBlt", "ptr", $hdc, "int", $nXLeft, "int", $nYLeft, "int", $nWidth, "int", $nHeight, "DWORD", $dwRop)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetBrushOrgEx
; Description ...: $hdc    - [in] Handle to the device context.
;                  $nXOrg  - [in] Specifies the x-coordinate, in device units, of the new brush origin. 
;                                 If this value is greater than the brush width, its value is reduced using the 
;                                 modulus operator (nXOrg mod brush width).
;                  $nYOrg  - [in] Specifies the y-coordinate, in device units, of the new brush origin. 
;                                 If this value is greater than the brush height, its value is reduced using the 
;                                 modulus operator (nYOrg mod brush height).
;                  $lppt   - [out] Pointer to a POINT structure that receives the previous brush origin.
;                            This parameter can be NULL if the previous brush origin is not required.
; Syntax.........: _GDI_SetBrushOrgEx($hdc, $nXOrg, $nYOrg, $lppt)
; Parameters ....: 
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: A brush is a bitmap that the system uses to paint the interiors of filled shapes.
;                    The brush origin is a pair of coordinates specifying the location of one pixel in the bitmap. The default 
;                    brush origin coordinates are (0,0). For horizontal coordinates, the value 0 corresponds to the leftmost 
;                    column of pixels; the width corresponds to the rightmost column. For vertical coordinates, the value 0
;                    corresponds to the uppermost row of pixels; the height corresponds to the lowermost row.
;                  The system automatically tracks the origin of all window-managed device contexts and adjusts their brushes
;                    as necessary to maintain an alignment of patterns on the surface. The brush origin that is set with this 
;                    call is relative to the upper-left corner of the client area.
;                  An application should call SetBrushOrgEx after setting the bitmap stretching mode to HALFTONE by using 
;                    SetStretchBltMode. This must be done to avoid brush misalignment.
;                  Windows NT/2000/XP: 
;                    The system automatically tracks the origin of all window-managed device contexts and adjusts their 
;                    brushes as necessary to maintain an alignment of patterns on the surface.
; Related .......: 
; Link ..........; @@MsdnLink@@ SetBrushOrgEx
; Example .......;
; ===============================================================================================================================
Func _GDI_SetBrushOrgEx($hdc, $nXOrg, $nYOrg, $lppt=0)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SetBrushOrgEx", "ptr", $hdc, "int", $nXOrg, "int", $nYOrg, "ptr", $lppt)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc

#EndRegion
;*************************************************************