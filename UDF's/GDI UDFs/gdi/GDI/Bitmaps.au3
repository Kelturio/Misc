#include-once
; #INDEX# =======================================================================================================================
; Title .........: Windows GDI Bitmap functions
; Description ...: This module contains various Windows GDI Bitmap functions that have been translated to AutoIt functions.
; Author ........: Greenhorn, Prog@ndy
; ===============================================================================================================================

; ===============================================================================================================================
; #CURRENT# =====================================================================================================================
;_GDI_AlphaBlend
;_GDI_BitBlt
;_GDI_CreateBitmap
;_GDI_CreateBitmapIndirect
;_GDI_CreateCompatibleBitmap
;_GDI_CreateDIBitmap
;_GDI_CreateDIBSection
;_GDI_ExtFloodFill
;_GDI_FloodFill
;_GDI_GetBitmapBits
;_GDI_GetBitmapDimensionEx
;_GDI_GetDIBits
;_GDI_GetPixel
;_GDI_GetStretchBltMode
;_GDI_GradientFill
;_GDI_LoadBitmap
;_GDI_MaskBlt
;_GDI_PlgBlt
;_GDI_SetBitmapBits
;_GDI_SetBitmapDimensionEx
;_GDI_SetDIBColorTable
;_GDI_SetDIBits
;_GDI_SetDIBitsToDevice
;_GDI_SetPixel
;_GDI_SetPixelV
;_GDI_SetStretchBltMode
;_GDI_StretchBlt
;_GDI_StretchDIBits
;_GDI_TransparentBlt
; ===============================================================================================================================

;*************************************************************
#Region					Bitmaps

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_AlphaBlend
; Description ...: Performs a bit-block transfer of the color data corresponding to a rectangle of pixels from the specified source device context into a destination device context.
; Syntax.........: _GDI_AlphaBlend($hDCDest, $nXOriginDest, $nYOriginDest, $nWidthDest, $nHeightDest, $hDCSrc, $nXOriginSrc, $nYOriginSrc, $nWidthSrc, $nHeightSrc, $blendFunction)
; Parameters ....: $hDCDest       - [in] Handle to the destination device context.
;                  $nXOriginDest  - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nYOriginDest  - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nWidthDest    - [in] Specifies the width, in logical units, of the destination rectangle.
;                  $hHeightDest   - [in] Handle to the height, in logical units, of the destination rectangle.
;                  $hDCSrc        - [in] Handle to the source device context.
;                  $nXOriginSrc   - [in] Specifies the x-coordinate, in logical units, of the source rectangle.
;                  $nYOriginSrc   - [in] Specifies the y-coordinate, in logical units, of the source rectangle.
;                  $nWidthSrc     - [in] Specifies the width, in logical units, of the source rectangle.
;                  $nHeightSrc    - [in] Specifies the height, in logical units, of the source rectangle.
; Return values .: Success      - 1
;                  Failure      - 0
; Author ........: Greenhorn
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ AlphaBlend
; Example .......;
; ===============================================================================================================================
Func _GDI_AlphaBlend($hDCDest, $nXOriginDest, $nYOriginDest, $nWidthDest, $nHeightDest, _
		$hDCSrc, $nXOriginSrc, $nYOriginSrc, $nWidthSrc, $nHeightSrc, $blendFunction)
	Local $data
	If IsDllStruct($blendFunction) Then
		$data = DllStructCreate("dword", DllStructGetPtr($blendFunction))
		$data = DllStructGetData($data, 1)
	ElseIf IsPtr($blendFunction) Then
		$data = DllStructCreate("dword", $blendFunction)
		$data = DllStructGetData($data, 1)
	Else
		$data = $blendFunction
	EndIf
	Local $aRes = DllCall($__GDI_msimg32dll, 'int', 'AlphaBlend', _
			'ptr', $hDCDest, _  ;  // handle to destination DC
			'int', $nXOriginDest, _  ;  // x-coord of upper-left corner
			'int', $nYOriginDest, _  ;  // y-coord of upper-left corner
			'int', $nWidthDest, _  ;  // destination width
			'int', $nHeightDest, _  ;  // destination height
			'ptr', $hDCSrc, _  ;  // handle to source DC
			'int', $nXOriginSrc, _  ;  // x-coord of upper-left corner
			'int', $nYOriginSrc, _  ;  // y-coord of upper-left corner
			'int', $nWidthSrc, _  ;  // source width
			'int', $nHeightSrc, _  ;  // source height
			'dword', $data);$blendFunction)   ;  // alpha-blending function
	If @error Then Return SetError(1, 0, 0)
	Return $aRes[0]

EndFunc   ;==>_GDI_AlphaBlend

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_BitBlt
; Description ...: Performs a bit-block transfer of color data
; Syntax.........: _GDI_BitBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iROP)
; Parameters ....: $hDestDC     - Handle to the destination device context
;                  $iXDest      - X value of the upper-left corner of the destination rectangle
;                  $iYDest      - Y value of the upper-left corner of the destination rectangle
;                  $iWidth      - Width of the source and destination rectangles
;                  $iHeight     - Height of the source and destination rectangles
;                  $hSrcDC      - Handle to the source device context
;                  $iXSrc       - X value of the upper-left corner of the source rectangle
;                  $iYSrc       - Y value of the upper-left corner of the source rectangle
;                  $iROP        - Specifies a raster operation code.  These codes define  how  the  color  data  for  the  source
;                  +rectangle is to be combined with the color data for the destination rectangle to achieve the final color:
;                  |$BLACKNESS      - Fills the destination rectangle using the color associated with palette index 0
;                  |$CAPTUREBLT     - Includes any window that are layered on top of your window in the resulting image
;                  |$DSTINVERT      - Inverts the destination rectangle
;                  |$MERGECOPY      - Merges the color of the source rectangle with the brush currently  selected  in  hDest,  by
;                  +using the AND operator.
;                  |$MERGEPAINT     - Merges the color of the inverted source  rectangle  with  the  colors  of  the  destination
;                  +rectangle by using the OR operator.
;                  |$NOMIRRORBITMAP - Prevents the bitmap from being mirrored
;                  |$NOTSRCCOPY     - Copies the inverted source rectangle to the destination
;                  |$NOTSRCERASE    - Combines the colors of the source and destination rectangles by using the OR  operator  and
;                  +then inverts the resultant color.
;                  |$PATCOPY        - Copies the brush selected in hdcDest, into the destination bitmap
;                  |$PATINVERT      - Combines the colors of the brush currently selected  in  hDest,  with  the  colors  of  the
;                  +destination rectangle by using the XOR operator.
;                  |$PATPAINT       - Combines the colors of the brush currently selected  in  hDest,  with  the  colors  of  the
;                  +inverted source rectangle by using the OR operator.  The result of this operation is combined with the  color
;                  +of the destination rectangle by using the OR operator.
;                  |$SRCAND         - Combines the colors of the source and destination rectangles by using the AND operator
;                  |$SRCCOPY        - Copies the source rectangle directly to the destination rectangle
;                  |$SRCERASE       - Combines the inverted color of the destination rectangle with  the  colors  of  the  source
;                  +rectangle by using the AND operator.
;                  |$SRCINVERT      - Combines the colors of the source and destination rectangles by using the XOR operator
;                  |$SRCPAINT       - Combines the colors of the source and destination rectangles by using the OR operator
;                  |$WHITENESS      - Fills the destination rectangle using the color associated with index  1  in  the  physical
;                  +palette.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ BitBlt
; Example .......;
; ===============================================================================================================================
Func _GDI_BitBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iROP)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "BitBlt", "ptr", $hDestDC, "int", $iXDest, "int", $iYDest, "int", $iWidth, "int", $iHeight, _
			"ptr", $hSrcDC, "int", $iXSrc, "int", $iYSrc, "int", $iROP)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0] <> 0
EndFunc   ;==>_GDI_BitBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateBitmap
; Description ...: Creates a bitmap with the specified width, height, and color format
; Syntax.........: _GDI_CreateBitmap($iWidth, $iHeight[, $iPlanes = 1[, $iBitsPerPel = 1[, $pBits = 0]]])
; Parameters ....: $iWidth      - Specifies the bitmap width, in pixels
;                  $iHeight     - Specifies the bitmap height, in pixels
;                  $iPlanes     - Specifies the number of color planes used by the device
;                  $iBitsPerPel - Specifies the number of bits required to identify the color of a single pixel
;                  $pBits       - Pointer to an array of color data used to set the colors in a rectangle of  pixels.  Each  scan
;                  +line in the rectangle must be word aligned (scan lines that are not word aligned must be padded with  zeros).
;                  +If this parameter is 0, the contents of the new bitmap is undefined.
; Return values .: Success      - The handle to a bitmap
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ CreateBitmap
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateBitmap($iWidth, $iHeight, $iPlanes = 1, $iBitsPerPel = 1, $pBits = 0)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateBitmap", "int", $iWidth, "int", $iHeight, "int", $iPlanes, "int", $iBitsPerPel, "ptr", $pBits)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateBitmapIndirect
; Description ...: Creates a bitmap with the specified width, height, and color format
; Syntax.........: _GDI_CreateBitmapIndirect($lpBITMAP)
; Parameters ....: $lpBITMAP    - Pointer to a BITMAP structure that contains information about the bitmap. If an application sets
;                  +the bmWidth or bmHeight members to zero, CreateBitmapIndirect returns the handle to a
;                  +1-by-1 pixel, monochrome bitmap.
; Return values .: Success      - The handle to a bitmap
;                  Failure      - 0
;                  |  Windows NT/2000/XP: This can have the following values.
;                  |    $ERROR_INVALID_PARAMETER - One or more of the input parameters was invalid.
;                  |    $ERROR_NOT_ENOUGH_MEMORY - The bitmap is too big for memory to be allocated.
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ CreateBitmapIndirect
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateBitmapIndirect($lpBITMAP)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateBitmapIndirect", "ptr", $lpBITMAP)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateBitmapIndirect

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateCompatibleBitmap
; Description ...: Creates a bitmap compatible with the specified device context
; Syntax.........: _GDI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
; Parameters ....: $hDC         - Identifies a device context
;                  $iWidth      - Specifies the bitmap width, in pixels
;                  $iHeight     - Specifies the bitmap height, in pixels
; Return values .: Success      - The handle to the bitmap
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: When you no longer need the bitmap, call the _GDI_DeleteObject function to delete it
; Related .......: _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreateCompatibleBitmap
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateCompatibleBitmap", "ptr", $hDC, "int", $iWidth, "int", $iHeight)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateCompatibleBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateDIBitmap
; Description ...: creates a compatible bitmap (DDB) from a DIB and, optionally, sets the bitmap bits.
; Syntax.........: _GDI_CreateDIBitmap($hdc, $lpbmih, $fdwInit, $lpbInit, $lpbmi, $fuUsage)
; Parameters ....: $hdc      - [in] Handle to a device context.
;                  $lpbmih   - [in] Pointer to a bitmap information header structure, which may be one of those shown in the following table.
;                  |Operating System                - Bitmap Information Header
;                  |Windows NT 3.51 and earlier     -   $tagBITMAPINFOHEADER
;                  |Windows 95 and Windows NT 4.0   -   $tagBITMAPV4HEADER
;                  |Windows 98/Me and Windows 2000  -   $tagBITMAPV5HEADER
;                  |
;                  |If fdwInit is CBM_INIT, the function uses the bitmap information header structure to obtain the
;                  +desired width and height of the bitmap as well as other information. Note that a positive value
;                  +for the height indicates a bottom-up DIB while a negative value for the height indicates a
;                  +top-down DIB. Calling CreateDIBitmap with fdwInit as CBM_INIT is equivalent to calling the
;                  +CreateCompatibleBitmap function to create a DDB in the format of the device and then calling the
;                  +SetDIBits function to translate the DIB bits to the DDB.
;                  $fdwInit  - [in] Specifies how the system initializes the bitmap bits. The following value is defined.
;                  |$CBM_INIT  -  If this flag is set, the system uses the data pointed to by the lpbInit and lpbmi
;                  +parameters to initialize the bitmap bits.
;                  |
;                  |If this flag is clear, the data pointed to by those parameters is not used.
;                  |If fdwInit is zero, the system does not initialize the bitmap bits.
;                  $lpbInit  - [in] Pointer to an array of bytes containing the initial bitmap data. The format of the data depends
;                  +on the biBitCount member of the BITMAPINFO structure to which the lpbmi parameter points.
;                  $lpbmi    - [in] Pointer to a BITMAPINFO structure that describes the dimensions and color format of the array
;                  +pointed to by the lpbInit parameter.
;                  $fuUsage  - [in] Specifies whether the bmiColors member of the BITMAPINFO structure was initialized and,
;                  +if so, whether bmiColors contains explicit red, green, blue (RGB) values or palette indexes.
;                  +The fuUsage parameter must be one of the following values.
;                  |$DIB_PAL_COLORS  - A color table is provided and consists of an array of 16-bit indexes into
;                  +the logical palette of the device context into which the bitmap is to be selected.
;                  |$DIB_RGB_COLORS  - A color table is provided and contains literal RGB values.
; Return values .: Success      - handle to the compatible bitmap.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The DDB that is created will be whatever bit depth your reference DC is. To create a bitmap that is of
;                  different bit depth, use CreateDIBSection.
;                  For a device to reach optimal bitmap-drawing speed, specify fdwInit as CBM_INIT. Then, use the same
;                  color depth DIB as the video mode. When the video is running 4- or 8-bpp, use DIB_PAL_COLORS.
;                  The CBM_CREATDIB flag for the fdwInit parameter is no longer supported.
;                  When you no longer need the bitmap, call the DeleteObject function to delete it.
;                  ICM: No color management is performed. The contents of the resulting bitmap are not color matched after
;                  the bitmap has been created.
;                  Windows 95/98/Me: The created bitmap cannot exceed 16MB in size.
; Related .......:
; Link ..........; @@MsdnLink@@ CreateDIBitmap
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateDIBitmap($hDC, $lpbmih, $fdwInit, $lpbInit, $lpbmi, $fuUsage)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateDIBitmap", "ptr", $hDC, "ptr", $lpbmih, "DWORD", $fdwInit, "ptr", $lpbInit, "ptr", $lpbmi, "UINT", $fuUsage)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateDIBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateDIBSection
; Description ...: Creates a bitmap compatible with the device that is associated with the specified device context.
; Syntax.........: _GDI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
; Parameters ....: $hDC         - Identifies a device context
;                  $bmi         - Pointer to a BITMAPINFO structure that specifies various attributes of the DIB,
;                  +including the bitmap dimensions and colors.
;                  $iUsage      - Specifies the type of data contained in the bmiColors array member of the BITMAPINFO structure
;                  |$DIB_PAL_COLORS - The bmiColors member is an array of 16-bit indexes into the logical palette
;                  +of the device context specified by hdc.
;                  |$DIB_RGB_COLORS - The BITMAPINFO structure contains an array of literal RGB values.
;                  $ppvBits     - A variable that receives a pointer to the location of the DIB bit values.
;                  $Section     - [Optional] Handle to a file-mapping object that the function will use to create the DIB.
;                  +This parameter can be NULL.
;                  $dwOffset    - [Optional] Specifies the offset from the beginning of the file-mapping object referenced by hSection
; Return values .: Success      - return value is a handle to the newly created DIB, and $ppvBits points to the bitmap bit values.
;                  Failure      - return value is NULL, and $ppvBits is NULL.
; Author ........: Greenhorn
; Modified.......: Prog@ndy
; Remarks .......: When you no longer need the bitmap, call the _GDI_DeleteObject function to delete it
; Related .......: _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreateCompatibleBitmap
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateDIBSection($hDC, ByRef $bmi, $iUsage, ByRef $ppvBits, $hSection = 0, $dwOffset = 0)
	Local $pbmi = DllStructGetPtr($bmi)
	If IsPtr($bmi) Then $pbmi = $bmi

	Local $aRes = DllCall($__GDI_gdi32dll, 'ptr', 'CreateDIBSection', _
			'ptr', $hDC, _ ; // handle to DC
			'ptr', $pbmi, _ ; // bitmap data
			'uint', $iUsage, _ ; // data type indicator
			'ptr*', 0, _ ;$ppvBits,  _ ; // bit values
			'ptr', $hSection, _ ; // handle to file mapping object
			'dword', $dwOffset) ; // offset to bitmap bit values
	If @error Then
		$ppvBits = 0
		Return SetError(1, 0, 0)
	EndIf
	$ppvBits = $aRes[4] ; Bitmap Bits
	Return $aRes[0] ; Bitmap Handle

EndFunc   ;==>_GDI_CreateDIBSection

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ExtFloodFill
; Description ...: Fills an area of the display surface with the current brush.
; Syntax.........: _GDI_ExtFloodFill($hDC, $nXStart, $nYStart, $crColor, $fuFillType)
; Parameters ....: $hDC         - Handle to a device context.
;                  $nXStart     - Specifies the x-coordinate, in logical units, of the point where filling is to start
;                  $nYStart     - Specifies the y-coordinate, in logical units, of the point where filling is to start
;                  $crColor     - Specifies the color of the boundary or of the area to be filled. The interpretation of crColor
;                  +depends on the value of the fuFillType parameter.
;                  $fuFillType  - Specifies the type of fill operation to be performed. This must be one of the following values:
;                  |$FLOODFILLBORDER  - The fill area is bounded by the color specified by the crColor parameter.
;                  +This style is identical to the filling performed by the FloodFill function.
;                  |$FLOODFILLSURFACE - The fill area is defined by the color that is specified by crColor.
;                  +Filling continues outward in all directions as long as the color is
;                  +encountered. This style is useful for filling areas with multicolored boundaries.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ ExtFloodFill
; Example .......;
; ===============================================================================================================================
Func _GDI_ExtFloodFill($hDC, $nXStart, $nYStart, $crColor, $fuFillType)
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'ExtFloodFill', 'ptr', $hDC, 'int', $nXStart, 'int', $nYStart, 'dword', $crColor, 'uint', $fuFillType)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0] <> 0
EndFunc   ;==>_GDI_ExtFloodFill

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_FloodFill
; Description ...: Fills an area of the display surface with the current brush. The area is assumed to be bounded as specified by the crFill parameter.
; Syntax.........: _GDI_FloodFill($hDC, $nXStart, $nYStart, $crColor)
; Parameters ....: $hDC         - Handle to a device context.
;                  $nXStart     - Specifies the x-coordinate, in logical units, of the point where filling is to start
;                  $nYStart     - Specifies the y-coordinate, in logical units, of the point where filling is to start
;                  $crColor     - Specifies the color of the boundary or of the area to be filled.
;                  +To create a COLORREF color value, use the RGB macro.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The FloodFill function is included only for compatibility with 16-bit versions of Windows.
;                  +Applications should use the ExtFloodFill function with FLOODFILLBORDER specified.
; Related .......:
; Link ..........; @@MsdnLink@@ FloodFill
; Example .......;
; ===============================================================================================================================
Func _GDI_FloodFill($hDC, $nXStart, $nYStart, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'FloodFill', 'ptr', $hDC, 'int', $nXStart, 'int', $nYStart, 'dword', $crColor)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0] <> 0
EndFunc   ;==>_GDI_FloodFill

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetBitmapBits
; Description ...: Copies the bitmap bits of a specified device-dependent bitmap into a buffer.
; Syntax.........: _GDI_GetBitmapBits($hBmp, $cbBuffer, $lpvBits)
; Parameters ....: $hBmp      - Handle to the device-dependent bitmap.
;                  $cbBuffer  - Specifies the number of bytes to copy from the bitmap into the buffer.
;                  $lpvBits   - Pointer to a buffer to receive the bitmap bits. The bits are stored as an array of byte values.
; Return values .: Success  - number of bytes copied to the buffer.
;                  Failure  - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: This function is provided only for compatibility with 16-bit versions of Windows. Applications should use the GetDIBits function.
; Related .......:
; Link ..........; @@MsdnLink@@ GetBitmapBits
; Example .......;
; ===============================================================================================================================
Func _GDI_GetBitmapBits($hBmp, $cbBuffer, $lpvBits)
	Local $aResult = DllCall($__GDI_gdi32dll, "long", "GetBitmapBits", "ptr", $hBmp, "long", $cbBuffer, "ptr", $lpvBits)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetBitmapBits

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetBitmapDimensionEx
; Description ...: Retrieves the dimensions of a compatible bitmap. The retrieved dimensions must have been set by the SetBitmapDimensionEx function.
; Syntax.........: _GDI_GetBitmapDimensionEx($hBitmap, $lpDimension)
; Parameters ....: $hBitmap      - Handle to a compatible bitmap (DDB).
;                  $lpDimension  - Pointer to a SIZE structure to receive the bitmap dimensions. For more information, see Remarks.
; Return values .: Success      - 1 (true)
;                  Failure      - 0 (false)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The function returns a data structure that contains fields for the height and width of the bitmap,
;                  +in .01-mm units. If those dimensions have not yet been set, the structure that is returned will have
;                  +zeroes in those fields.
; Related .......: _GDI_SetBitmapDimensionEx
; Link ..........; @@MsdnLink@@ GetBitmapDimensionEx
; Example .......;
; ===============================================================================================================================
Func _GDI_GetBitmapDimensionEx($hBitmap, $lpDimension)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetBitmapDimensionEx", "ptr", $hBitmap, "ptr", $lpDimension)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetBitmapDimensionEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDIBits
; Description ...: Retrieves the bits of the specified bitmap and copies them into a buffer as a DIB
; Syntax.........: _GDI_GetDIBits($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pBI, $iUsage)
; Parameters ....: $hDC         - Handle to the device context
;                  $hBmp        - Handle to the bitmap. This must be a compatible bitmap (DDB).
;                  $iStartScan  - Specifies the first scan line to retrieve
;                  $iScanLines  - Specifies the number of scan lines to retrieve
;                  $pBits       - Pointer to a buffer to receive the bitmap data. If this parameter is 0, the function passes the
;                  +dimensions and format of the bitmap to the $tagBITMAPINFO structure pointed to by the pBI parameter.
;                  $pBI         - Pointer to a $tagBITMAPINFO structure that specifies the desired format for the DIB data
;                  $iUsage      - Specifies the format of the bmiColors member of the $tagBITMAPINFO structure. It must be one  of
;                  +the following values:
;                  |$DIB_PAL_COLORS - The color table should consist of an array of 16-bit indexes into the current palette
;                  |$DIB_RGB_COLORS - The color table should consist of literal red, green, blue values
; Return values .: Success      - If pBits is not 0 and the function succeeds, the return value  is  the  number  of  scan  lines
;                  +copied from the bitmap.  If pBits is 0 and GetDIBits successfully fills the structure, the  return  value  is
;                  +True.
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......: $tagBITMAPINFO
; Link ..........; @@MsdnLink@@ GetDIBits
; Example .......;
; ===============================================================================================================================
Func _GDI_GetDIBits($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pBI, $iUsage)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetDIBits", "ptr", $hDC, "ptr", $hBmp, "int", $iStartScan, "int", $iScanLines, _
			"ptr", $pBits, "ptr", $pBI, "int", $iUsage)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDIBits

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetPixel
; Description ...: Retrieves the red, green, blue (RGB) color value of the pixel at the specified coordinates.
; Syntax.........: _GDI_GetPixel($hDC, $nXPos, $nYPos)
; Parameters ....: $hDC   - Handle to the device context.
;                  $nXPos - Specifies the x-coordinate, in logical units, of the pixel to be examined.
;                  $nYPos - Specifies the y-coordinate, in logical units, of the pixel to be examined.
; Return values .: Success      - COLORREF of Pixel
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Attention: $CLR_INVALID has the same value as Yellow (R = 255, G = 255, B = 0)
; Related .......:
; Link ..........; @@MsdnLink@@ GetPixel
; Example .......;
; ===============================================================================================================================
Func _GDI_GetPixel($hDC, $nXPos, $nYPos)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "GetPixel", "ptr", $hDC, "int", $nXPos, "int", $nYPos)
	If @error Then Return SetError(1, 0, $CLR_INVALID)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetPixel

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetStretchBltMode
; Description ...: Retrieves the red, green, blue (RGB) color value of the pixel at the specified coordinates.
; Syntax.........: _GDI_GetStretchBltMode($hDC)
; Parameters ....: $hDC - Handle to the device context.
; Return values .: Success - current stretching mode. This can be one of the following values:
;                  |$BLACKONWHITE         - Performs a Boolean AND operation using the color values for the eliminated and
;                  +existing pixels. If the bitmap is a monochrome bitmap,
;                  +this mode preserves black pixels at the expense of white pixels.
;                  |$COLORONCOLOR         - Deletes the pixels. This mode deletes all eliminated lines of pixels without
;                  +trying to preserve their information.
;                  |$HALFTONE             - Maps pixels from the source rectangle into blocks of pixels in the destination
;                  +rectangle. The average color over the destination block of pixels approximates
;                  +the color of the source pixels.
;                  +This option is not supported on Windows 95/98/Me.
;                  |$STRETCH_ANDSCANS     - Same as $BLACKONWHITE.
;                  |$STRETCH_DELETESCANS  - Same as $COLORONCOLOR.
;                  |$STRETCH_HALFTONE     - Same as $HALFTONE.
;                  |$STRETCH_ORSCANS      - Same as $WHITEONBLACK.
;                  |$WHITEONBLACK         - Performs a Boolean OR operation using the color values for the eliminated and existing pixels. If the bitmap is a monochrome bitmap, this mode preserves white pixels at the expense of black pixels.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetStretchBltMode
; Example .......;
; ===============================================================================================================================
Func _GDI_GetStretchBltMode($hDC)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetStretchBltMode", "ptr", $hDC)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetStretchBltMode

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GradientFill
; Description ...: Fills rectangle and triangle structures
; Syntax.........: _GDI_GradientFill ($hDC, $pVertex, $dwNumVertex, $pMesh, $dwNumMesh, $dwMode)
; Parameters ....: $hDC          - [in] Handle to the destination device context.
;                  $pVertex      - [in] Pointer to an array of TRIVERTEX structures that each define a triangle vertex.
;                  $dwNumVertex  - [in] The number of vertices in pVertex.
;                  $pMesh        - [in] Array of GRADIENT_TRIANGLE structures in triangle mode,
;                  +or an array of GRADIENT_RECT structures in rectangle mode.
;                  $dwNumMesh    - [in] The number of elements (triangles or rectangles) in pMesh
;                  $dwMode       - [in] Specifies gradient fill mode. This parameter can be one of the following values
;                  |$GRADIENT_FILL_RECT_H   - In this mode, two endpoints describe a rectangle.
;                  +The rectangle is defined to have a constant color
;                  +(specified by the TRIVERTEX structure) for the left and right edges.
;                  +GDI interpolates the color from the left to right edge and fills the interior.
;                  |$GRADIENT_FILL_RECT_V   - In this mode, two endpoints describe a rectangle. The rectangle is defined
;                  +to have a constant color (specified by the TRIVERTEX structure) for the top
;                  +and bottom edges. GDI interpolates the color from the top to bottom edge and
;                  +fills the interior.
;                  |$GRADIENT_FILL_TRIANGLE - In this mode, an array of TRIVERTEX structures is passed to GDI along
;                  +with a list of array indexes that describe separate triangles.
;                  +GDI performs linear interpolation between triangle vertices and fills
;                  +the interior. Drawing is done directly in 24- and 32-bpp modes.
;                  +Dithering is performed in 16-, 8-, 4-, and 1-bpp mode.
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
; Author ........: Greenhorn
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GradientFill
; Example .......;
; ===============================================================================================================================
Func _GDI_GradientFill($hDC, $pVertex, $dwNumVertex, $pMesh, $dwNumMesh, $dwMode)

	Local $aRes = DllCall($__GDI_msimg32dll, 'int', 'GradientFill', _
			'ptr', $hDC, _           ; // handle to DC
			'ptr', $pVertex, _       ; // array of vertices
			'ulong', $dwNumVertex, _   ; // number of vertices
			'ptr', $pMesh, _         ; // array of gradients
			'ulong', $dwNumMesh, _     ; // size of gradient array
			'ulong', $dwMode) ; // gradient fill mode
	If @error Then Return SetError(@error, 0, 0)
	Return $aRes[0]

EndFunc   ;==>_GDI_GradientFill

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_LoadBitmap
; Description ...: Loads the specified bitmap resource from a module's executable file
; Syntax.........: _GDI_LoadBitmap($hInstance, $sBitmap)
; Parameters ....: $hInstance   - Handle to the instance of the module whose executable file contains the bitmap to be loaded
;                  $sBitmap      - The name of the bitmap resource to be loaded.  Alternatively this can consist of the  resource
;                  +identifier in the low order word and 0 in the high order word. MAKEINTRESOURCE() can be used to create this value.
; Return values .: Success      - The handle to the specified bitmap
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ LoadBitmap
; Example .......;
; ===============================================================================================================================
Func _GDI_LoadBitmap($hInstance, $sBitmap)
	Local $aResult, $sType = "ptr"

	If IsString($sBitmap) Then $sType = "wstr"
	$aResult = DllCall($__GDI_user32dll, "ptr", "LoadBitmapW", "ptr", $hInstance, $sType, $sBitmap)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_LoadBitmap

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_MaskBlt
; Description ...: Combines the color data for the source and destination bitmaps using the specified mask and raster operation.
; Syntax.........: _GDI_MaskBlt($hDCDest, $nXDest, $nYDest, $nWidth, $nHeight, $hDCSrc, $nXSrc, $nYSrc, $hbmMask, $xMask, $yMask, $dwRop)
; Parameters ....: $hDCDest   - [in] Handle to the destination device context.
;                  $nXDest    - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nYDest    - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nWidth    - [in] Specifies the width, in logical units, of the destination rectangle and source bitmap.
;                  $nHeight   - [in] Specifies the height, in logical units, of the destination rectangle and source bitmap.
;                  $hDCSrc    - [in] Handle to the device context from which the bitmap is to be copied. It must be zero if the dwRop
;                  +parameter specifies a raster operation that does not include a source.
;                  $nXSrc     - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the source bitmap.
;                  $nYSrc     - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the source bitmap.
;                  $hbmMask   - [in] Handle to the monochrome mask bitmap combined with the color bitmap in the source device context.
;                  $xMask     - [in] Specifies the horizontal pixel offset for the mask bitmap specified by the hbmMask parameter.
;                  $yMask     - [in] Specifies the vertical pixel offset for the mask bitmap specified by the hbmMask parameter.
;                  $dwRop     - [in] Specifies both foreground and background ternary raster operation codes (ROPs) that the function
;                  +uses to control the combination of source and destination data. The background raster operation
;                  +code is stored in the high-order byte of the high-order word of this value; the foreground
;                  +raster operation code is stored in the low-order byte of the high-order word of this value; the
;                  +low-order word of this value is ignored, and should be zero. The macro MAKEROP4 creates such
;                  +combinations of foreground and background raster operation codes.
;                  |For a list of common raster operation codes (ROPs), see the BitBlt function.
;                  +Note that the CAPTUREBLT ROP generally cannot be used for printing device contexts.
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ MaskBlt
; Example .......;
; ===============================================================================================================================
Func _GDI_MaskBlt($hDCDest, $nXDest, $nYDest, $nWidth, $nHeight, $hDCSrc, $nXSrc, $nYSrc, $hbmMask, $xMask, $yMask, $dwRop)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "MaskBlt", "ptr", $hDCDest, "int", $nXDest, "int", $nYDest, "int", $nWidth, "int", $nHeight, _
			"ptr", $hDCSrc, "int", $nXSrc, "int", $nYSrc, _
			"ptr", $hbmMask, "int", $xMask, "int", $yMask, "DWORD", $dwRop)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_MaskBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PlgBlt
; Description ...: Performs a bit-block transfer of the bits of color data from the specified rectangle in the source device context to the specified parallelogram in the destination device context. If the given bitmask handle identifies a valid monochrome bitmap, the function uses this bitmap to mask the bits of color data from the source rectangle.
; Syntax.........: _GDI_PlgBlt($hDCDest, $lpPoint, $hDCSrc, $nXSrc, $nYSrc, $nWidth, $nHeight, $hbmMask, $xMask, $yMask)
; Parameters ....: $hDCDest  - [in] Handle to the destination device context.
;                  $lpPoint  - [in] Pointer to an array of three points in logical space that identify three corners of the destination parallelogram. The upper-left corner of the source rectangle is mapped to the first point in this array, the upper-right corner to the second point in this array, and the lower-left corner to the third point. The lower-right corner of the source rectangle is mapped to the implicit fourth point in the parallelogram.
;                  $hDCSrc   - [in] Handle to the source device context.
;                  $nXSrc    - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $nYSrc    - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the source rectangle.
;                  $nWidth   - [in] Specifies the width, in logical units, of the source rectangle.
;                  $nHeight  - [in] Specifies the height, in logical units, of the source rectangle.
;                  $hbmMask  - [in] Handle to an optional monochrome bitmap that is used to mask the colors of the source rectangle.
;                  $xMask    - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the monochrome bitmap.
;                  $yMask    - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the monochrome bitmap.
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ PlgBlt
; Example .......;
; ===============================================================================================================================
Func _GDI_PlgBlt($hDCDest, $lpPoint, $hDCSrc, $nXSrc, $nYSrc, $nWidth, $nHeight, $hbmMask, $xMask, $yMask)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "PlgBlt", "ptr", $hDCDest, "ptr", $lpPoint, "ptr", $hDCSrc, _
			"int", $nXSrc, "int", $nYSrc, "int", $nWidth, "int", $nHeight, "ptr", $hbmMask, "int", $xMask, "int", $yMask)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_PlgBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetBitmapBits
; Description ...: The SetBitmapBits function sets the bits of color data for a bitmap to the specified values.
; Syntax.........: _GDI_SetBitmapBits($hBmp, $cBytes, $lpBits)
; Parameters ....: $hBmp     - Handle to the bitmap to be set. This must be a compatible bitmap (DDB).
;                  $cBytes   - Specifies the number of bytes pointed to by the lpBits parameter.
;                  $lpBits   - Pointer to an array of bytes that contain color data for the specified bitmap.
; Return values .: Success  - number of bytes used in setting the bitmap bits.
;                  Failure  - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: This function is provided only for compatibility with 16-bit versions of Windows. Applications should use the SetDIBits function.
;                  The array identified by lpBits must be WORD aligned.
; Related .......:
; Link ..........; @@MsdnLink@@ SetBitmapBits
; Example .......;
; ===============================================================================================================================
Func _GDI_SetBitmapBits($hBmp, $cBytes, $lpBits)
	Local $aResult = DllCall($__GDI_gdi32dll, "long", "SetBitmapBits", "ptr", $hBmp, "long", $cBytes, "ptr", $lpBits)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetBitmapBits

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetBitmapDimensionEx
; Description ...: Assigns preferred dimensions to a bitmap. These dimensions can be used by applications; however, they are not used by the system.
; Syntax.........: _GDI_SetBitmapDimensionEx($hBitmap, $nWidth, $nHeight, $lpSize)
; Parameters ....: $hBitmap   - [in] Handle to the bitmap. The bitmap cannot be a DIB-section bitmap.
;                  $nWidth    - [in] Specifies the width, in 0.1-millimeter units, of the bitmap.
;                  $nHeight   - [in] Specifies the height, in 0.1-millimeter units, of the bitmap.
;                  $lpSize    - [out] Pointer to a SIZE structure to receive the previous dimensions of the bitmap.
;                  +This pointer can be NULL.
; Return values .: Success      - nonzero (true)
;                  Failure      - 0 (false)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: An application can retrieve the dimensions assigned to a bitmap with the SetBitmapDimensionEx function
;                  by calling the GetBitmapDimensionEx function.
;                  The bitmap identified by hBitmap cannot be a DIB section, which is a bitmap created by the CreateDIBSection
;                  function. If the bitmap is a DIB section, the SetBitmapDimensionEx function fails.
; Related .......: _GDI_SetBitmapDimensionEx
; Link ..........; @@MsdnLink@@ SetBitmapDimensionEx
; Example .......;
; ===============================================================================================================================
Func _GDI_SetBitmapDimensionEx($hBitmap, $nWidth, $nHeight, $lpSize)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SetBitmapDimensionEx", "ptr", $hBitmap, "int", $nWidth, "int", $nHeight, "ptr", $lpSize)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetBitmapDimensionEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetDIBColorTable
; Description ...: Sets RGB (red, green, blue) color values in a range of entries in the color table of the DIB that is currently selected into a specified device context.
; Syntax.........: _GDI_SetDIBColorTable($hDC, $uStartIndex, $cEntries, $pColors)
; Parameters ....: $hDC          - [in] Specifies a device context. A DIB must be selected into this device context.
;                  $uStartIndex  - [in] A zero-based color table index that specifies the first color table entry to set.
;                  $cEntries     - [in] Specifies the number of color table entries to set.
;                  $pColors      - [in] Pointer to an array of RGBQUAD structures containing new color information for the DIB's color table.
; Return values .: Success      - number of color table entries that the function sets.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ SetDIBColorTable
; Example .......;
; ===============================================================================================================================
Func _GDI_SetDIBColorTable($hDC, $uStartIndex, $cEntries, $pColors)
	Local $aResult = DllCall($__GDI_gdi32dll, "uint", "SetDIBColorTable", "Ptr", $hDC, "UINT", $uStartIndex, "UINT", $cEntries, "ptr", $pColors)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetDIBColorTable

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetDIBits
; Description ...: Sets the pixels in a compatible bitmap using the color data found in a DIB
; Syntax.........: _GDI_SetDIBits($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pBMI[, $iColorUse = 0])
; Parameters ....: $hDC         - Handle to a device context
;                  $hBmp        - Handle to the compatible bitmap (DDB) that is to be altered using the color data from the DIB
;                  $iStartScan  - Specifies the starting scan line for the device-independent color data in the array pointed  to
;                  +by the pBits parameter.
;                  $iScanLines  - Specifies the number of scan lines found in the array containing device-independent color data
;                  $pBits       - Pointer to the DIB color data, stored as an array of bytes.  The format of  the  bitmap  values
;                  +depends on the biBitCount member of the $tagBITMAPINFO structure pointed to by the pBMI parameter.
;                  $pBMI        - Pointer to a $tagBITMAPINFO structure that contains information about the DIB
;                  $iColorUse   - Specifies whether the iColors member of the $tagBITMAPINFO structure was provided  and,  if  so,
;                  +whether iColors contains explicit red, green, blue (RGB) values or palette indexes.  The iColorUse  parameter
;                  +must be one of the following values:
;                  |0 - The color table is provided and contains literal RGB values
;                  |1 - The color table consists of an array of 16-bit indexes into the logical palette of hDC
; Return values .: Success      - number of scan lines copied
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: The device context identified by the hDC parameter is used only if the iColorUse is set to 1, otherwise it  is
;                  ignored.  The bitmap identified by the hBmp parameter must not be selected into a  device  context  when  this
;                  function is called. The scan lines must be aligned on a DWORD except for RLE compressed  bitmaps.  The  origin
;                  for bottom up DIBs is the lower left corner of the bitmap; the origin for top down  DIBs  is  the  upper  left
;                  corner of the bitmap.
; Related .......: $tagBITMAPINFO
; Link ..........; @@MsdnLink@@ SetDIBits
; Example .......;
; ===============================================================================================================================
Func _GDI_SetDIBits($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pbmi, $iColorUse = 0)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "SetDIBits", "ptr", $hDC, "ptr", $hBmp, "uint", $iStartScan, "uint", $iScanLines, _
			"ptr", $pBits, "ptr", $pbmi, "uint", $iColorUse)
	Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_GDI_SetDIBits

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetDIBitsToDevice
; Description ...: sets the pixels in the specified rectangle on the device that is associated with the destination
;                    device context using color data from a DIB.
;                  Windows 98/Me, Windows 2000/XP:
;                    SetDIBitsToDevice has been extended to allow a JPEG or PNG image to be passed as the source image.
; Syntax.........: _GDI_SetDIBitsToDevice($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pBMI, $iColorUse = 0)
; Parameters ....: $hDC         - [in] Handle to the device context.
;                  $XDest       - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $YDest       - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $dwWidth     - [in] Specifies the width, in logical units, of the DIB.
;                  $dwHeight    - [in] Specifies the height, in logical units, of the DIB.
;                  $XSrc        - [in] Specifies the x-coordinate, in logical units, of the lower-left corner of the DIB.
;                  $YSrc        - [in] Specifies the y-coordinate, in logical units, of the lower-left corner of the DIB.
;                  $uStartScan  - [in] Specifies the starting scan line in the DIB.
;                  $cScanLines  - [in] Specifies the number of DIB scan lines contained in the array pointed to by the lpvBits parameter.
;                  $lpvBits     - [in] Pointer to DIB color data stored as an array of bytes. For more information, see the following Remarks section.
;                  $lpbmi       - [in] Pointer to a BITMAPINFO structure that contains information about the DIB.
;                  $fuColorUse  - [in] Specifies whether the bmiColors member of the BITMAPINFO structure contains explicit
;                                      red, green, blue (RGB) values or indexes into a palette. For more information, see the following Remarks section.
;                                 The fuColorUse parameter must be one of the following values.
;                                 $DIB_PAL_COLORS - The color table consists of an array of 16-bit indexes into the currently selected logical palette.
;                                 $DIB_RGB_COLORS - The color table contains literal RGB values.
; Return values .: Success      - number of scan lines set.
;                  Failure      - 0 (zero is also returned when zero scan lines are set (such as when dwHeight is 0) )
;                  Windows 98/Me, Windows 2000/XP:
;                    If the driver cannot support the JPEG or PNG file image passed to SetDIBitsToDevice, the function will fail
;                    and return GDI_ERROR. If failure does occur, the application must fall back on its own JPEG or PNG support to
;                    decompress the image into a bitmap, and then pass the bitmap to SetDIBitsToDevice.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: see MSDN
; Related .......:
; Link ..........; @@MsdnLink@@ SetDIBitsToDevice
; Example .......;
; ===============================================================================================================================
Func _GDI_SetDIBitsToDevice($hDC, $XDest, $YDest, $dwWidth, $dwHeight, $XSrc, $YSrc, $uStartScan, $cScanLines, $lpvBits, $lpbmi, $fuColorUse)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "SetDIBitsToDevice", "ptr", $hDC, "int", $XDest, "int", $YDest, "DWORD", $dwWidth, "DWORD", $dwHeight, _
			"int", $XSrc, "int", $YSrc, "UINT", $uStartScan, "UINT", $cScanLines, "ptr", $lpvBits, "ptr", $lpbmi, "UINT", $fuColorUse)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetDIBitsToDevice

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetPixel
; Description ...: The SetPixel function sets the pixel at the specified coordinates to the specified color.
; Syntax.........: _GDI_SetPixel($hDC, $nXPos, $nYPos, $crColor)
; Parameters ....: $hDC   - Handle to the device context.
;                  $nXPos - Specifies the x-coordinate, in logical units, of the point to be set.
;                  $nYPos - Specifies the y-coordinate, in logical units, of the point to be set.
;                  $crColor -     Specifies the color to be used to paint the point. To create a COLORREF color value, use the RGB macro.
; Return values .: Success      - new COLORREF of the pixel. sets the pixel to. This value may differ from the color specified
;                                   by crColor; that occurs when an exact match for the specified color cannot be found.
;                  Failure      - -1
;                         Windows NT/2000/XP: This can be the following value:
;                           $ERROR_INVALID_PARAMETER (87) - One or more input parameters are invalid.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetPixel
; Example .......;
; ===============================================================================================================================
Func _GDI_SetPixel($hDC, $nXPos, $nYPos, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "SetPixel", "ptr", $hDC, "int", $nXPos, "int", $nYPos, "dword", $crColor)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetPixel

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetPixelV
; Description ...: Sets the pixel at the specified coordinates to the closest approximation of the specified color.
;                    The point must be in the clipping region and the visible part of the device surface.
; Syntax.........: _GDI_SetPixelV($hDC, $nXPos, $nYPos, $crColor)
; Parameters ....: $hDC   - Handle to the device context.
;                  $nXPos - Specifies the x-coordinate, in logical units, of the point to be set.
;                  $nYPos - Specifies the y-coordinate, in logical units, of the point to be set.
;                  $crColor -     Specifies the color to be used to paint the point. To create a COLORREF color value, use the RGB macro.
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetPixel
; Example .......;
; ===============================================================================================================================
Func _GDI_SetPixelV($hDC, $nXPos, $nYPos, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SetPixelV", "ptr", $hDC, "int", $nXPos, "int", $nYPos, "dword", $crColor)
	If @error Then Return SetError(1, 0, $CLR_INVALID)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetPixelV

; ===============================================================================================================================
;
; Function Name:   _GDI_SetStretchBltMode
; Description::    The SetStretchBltMode function sets the bitmap stretching mode in the specified device context.
; Syntax:          _GDI_StretchBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iWSrc, $iHSrc, $iROP)
; Parameter(s):    $hDC            - Handle to the device context
;                  $iStretchMode   - Specifies the stretching mode. This parameter can be one of the following values:
;                   |$BLACKONWHITE 	        Performs a Boolean AND operation using the color values for the eliminated and existing pixels.
;                    +If the bitmap is a monochrome bitmap, this mode preserves black pixels at the expense of white pixels.
;                   |$COLORONCOLOR 	        Deletes the pixels. This mode deletes all eliminated lines of pixels without trying
;                    +to preserve their information.
;                   |$HALFTONE 	            Maps pixels from the source rectangle into blocks of pixels in the destination rectangle.
;                    +The average color over the destination block of pixels approximates the color of the source pixels.
;                    +After setting the HALFTONE stretching mode, an application must call the SetBrushOrgEx function to set
;                    +the brush origin. If it fails to do so, brush misalignment occurs.
;                    +This option is not supported on Windows 95/98/Me.
;                   |$STRETCH_ANDSCANS 	    Same as BLACKONWHITE.
;                   |$STRETCH_DELETESCANS   Same as COLORONCOLOR.
;                   |$STRETCH_HALFTONE      Same as HALFTONE.
;                   |$STRETCH_ORSCANS       Same as WHITEONBLACK.
;                   |$WHITEONBLACK 	        Performs a Boolean OR operation using the color values for the eliminated and existing pixels.
;                    +If the bitmap is a monochrome bitmap, this mode preserves white pixels at the expense of black pixels.
; Requirement(s):
; Return Value(s):
; Author(s):
;
; ===============================================================================================================================
;
Func _GDI_SetStretchBltMode($hDC, $iStretchMode, $GDIDll = $__GDI_gdi32dll)
	Local $aResult = DllCall($GDIDll, "dword", "SetStretchBltMode", "ptr", $hDC, "dword", $iStretchMode)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetStretchBltMode


; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_StretchBlt
; Description ...: Performs a bit-block transfer of color data and stretches to new size
; Syntax.........: _GDI_StretchBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iWSrc, $iHSrc, $iROP)
; Parameters ....: $hDestDC     - Handle to the destination device context
;                  $iXDest      - X value of the upper-left corner of the destination rectangle
;                  $iYDest      - Y value of the upper-left corner of the destination rectangle
;                  $iWidth      - Width of the destination rectangle
;                  $iHeight     - Height of the destination rectangle
;                  $hSrcDC      - Handle to the source device context
;                  $iXSrc       - X value of the upper-left corner of the source rectangle
;                  $iYSrc       - Y value of the upper-left corner of the source rectangle
;                  $iWSrc       - Width of the source rectangle
;                  $iHSrc       - Width of the source rectangle
;                  $iROP        - Specifies a raster operation code.  These codes define  how  the  color  data  for  the  source
;                  +rectangle is to be combined with the color data for the destination rectangle to achieve the final color:
;                  |$BLACKNESS      - Fills the destination rectangle using the color associated with palette index 0
;                  |$CAPTUREBLT     - Includes any window that are layered on top of your window in the resulting image
;                  |$DSTINVERT      - Inverts the destination rectangle
;                  |$MERGECOPY      - Merges the color of the source rectangle with the brush currently  selected  in  hDest,  by
;                  +using the AND operator.
;                  |$MERGEPAINT     - Merges the color of the inverted source  rectangle  with  the  colors  of  the  destination
;                  +rectangle by using the OR operator.
;                  |$NOMIRRORBITMAP - Prevents the bitmap from being mirrored
;                  |$NOTSRCCOPY     - Copies the inverted source rectangle to the destination
;                  |$NOTSRCERASE    - Combines the colors of the source and destination rectangles by using the OR  operator  and
;                  +then inverts the resultant color.
;                  |$PATCOPY        - Copies the brush selected in hdcDest, into the destination bitmap
;                  |$PATINVERT      - Combines the colors of the brush currently selected  in  hDest,  with  the  colors  of  the
;                  +destination rectangle by using the XOR operator.
;                  |$PATPAINT       - Combines the colors of the brush currently selected  in  hDest,  with  the  colors  of  the
;                  +inverted source rectangle by using the OR operator.  The result of this operation is combined with the  color
;                  +of the destination rectangle by using the OR operator.
;                  |$SRCAND         - Combines the colors of the source and destination rectangles by using the AND operator
;                  |$SRCCOPY        - Copies the source rectangle directly to the destination rectangle
;                  |$SRCERASE       - Combines the inverted color of the destination rectangle with  the  colors  of  the  source
;                  +rectangle by using the AND operator.
;                  |$SRCINVERT      - Combines the colors of the source and destination rectangles by using the XOR operator
;                  |$SRCPAINT       - Combines the colors of the source and destination rectangles by using the OR operator
;                  |$WHITENESS      - Fills the destination rectangle using the color associated with index  1  in  the  physical
;                  +palette.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ BitBlt
; Example .......;
; ===============================================================================================================================
Func _GDI_StretchBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iWSrc, $iHSrc, $iROP)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "StretchBlt", "ptr", $hDestDC, "int", $iXDest, "int", $iYDest, "int", $iWidth, "int", $iHeight, _
			"ptr", $hSrcDC, "int", $iXSrc, "int", $iYSrc, "int", $iWSrc, "int", $iHSrc, "dword", $iROP)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_GDI_StretchBlt

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_StretchDIBits
; Description ...: copies the color data for a rectangle of pixels in a DIB to the specified destination rectangle.
;                    If the destination rectangle is larger than the source rectangle, this function stretches the rows and columns
;                    of color data to fit the destination rectangle. If the destination rectangle is smaller than the source rectangle,
;                    this function compresses the rows and columns by using the specified raster operation.
;                  Windows 98/Me, Windows 2000/XP:
;                    StretchDIBits has been extended to allow a JPEG or PNG image to be passed as the source image.
; Syntax.........: _GDI_StretchDIBits($hDC, $XDest, $YDest, $nDestWidth, $nDestHeight, $XSrc, $YSrc, $nSrcWidth, $nSrcHeight, $lpBits, $lpBitsInfo, $iUsage, $dwRop)
; Parameters ....: $hDC          - [in] Handle to the destination device context.
;                  $XDest        - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $YDest        - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nDestWidth   - [in] Specifies the width, in logical units, of the destination rectangle.
;                  $nDestHeight  - [in] Specifies the height, in logical units, of the destination rectangle.
;                  $XSrc         - [in] Specifies the x-coordinate, in pixels, of the source rectangle in the DIB.
;                  $YSrc         - [in] Specifies the y-coordinate, in pixels, of the source rectangle in the DIB.
;                  $nSrcWidth    - [in] Specifies the width, in pixels, of the source rectangle in the DIB.
;                  $nSrcHeight   - [in] Specifies the height, in pixels, of the source rectangle in the DIB.
;                  $lpBits       - [in] Pointer to the DIB bits, which are stored as an array of bytes.
;                                       For more information, see the Remarks section.
;                  $lpBitsInfo   - [in] Pointer to a BITMAPINFO structure that contains information about the DIB.
;                  $iUsage       - [in] Specifies whether the bmiColors member of the BITMAPINFO structure was provided and, if so,
;                                       whether bmiColors contains explicit red, green, blue (RGB) values or indexes. The iUsage parameter
;                                       must be one of the following values.
;                                   $DIB_PAL_COLORS    The array contains 16-bit indexes into the logical palette of the source device context.
;                                   $DIB_RGB_COLORS    The color table contains literal RGB values.
;                                      For more information, see the Remarks section.
;                  $dwRop        - [in] Specifies how the source pixels, the destination device context's current brush, and the destination pixels are to be combined to form the new image. For more information, see the following Remarks section.
; Return values .: Success      - number of scan lines copied.
;                  Failure      - 0
;                  Windows 98/Me, Windows 2000/XP:
;                    If the driver cannot support the JPEG or PNG file image passed to StretchDIBits, the function will fail and
;                    return GDI_ERROR. If failure does occur, the application must fall back on its own JPEG or PNG support to decompress
;                    the image into a bitmap, and then pass the bitmap to StretchDIBits.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ StretchDIBits
; Example .......;
; ===============================================================================================================================
Func _GDI_StretchDIBits($hDC, $XDest, $YDest, $nDestWidth, $nDestHeight, $XSrc, $YSrc, $nSrcWidth, $nSrcHeight, $lpBits, $lpBitsInfo, $iUsage, $dwRop)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "StretchDIBits", "ptr", $hDC, "int", $XDest, "int", $YDest, "int", $nDestWidth, "int", $nDestHeight, _
			"int", $XSrc, "int", $YSrc, "int", $nSrcWidth, "int", $nSrcHeight, "Ptr", $lpBits, "ptr", $lpBitsInfo, "UINT", $iUsage, "DWORD", $dwRop)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_StretchDIBits


; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_TransparentBlt
; Description ...: Performs a bit-block transfer of the color data corresponding to a rectangle of pixels
;                  from the specified source device context into a destination device context.
; Syntax.........: _GDI_TransparentBlt($hDCDest, $nXOriginDest, $nYOriginDest, $nWidthDest, $hHeightDest, $hDCSrc, $nXOriginSrc, $nYOriginSrc, $nWidthSrc, $nHeightSrc, $crTransparent)
; Parameters ....: $hDCDest - [in] Handle to the destination device context.
;                  $nXOriginDest  - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nYOriginDest  - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the destination rectangle.
;                  $nWidthDest    - [in] Specifies the width, in logical units, of the destination rectangle.
;                  $hHeightDest   - [in] Handle to the height, in logical units, of the destination rectangle.
;                  $hDCSrc        - [in] Handle to the source device context.
;                  $nXOriginSrc   - [in] Specifies the x-coordinate, in logical units, of the source rectangle.
;                  $nYOriginSrc   - [in] Specifies the y-coordinate, in logical units, of the source rectangle.
;                  $nWidthSrc     - [in] Specifies the width, in logical units, of the source rectangle.
;                  $nHeightSrc    - [in] Specifies the height, in logical units, of the source rectangle.
;                  $crTransparent - [in] The RGB color in the source bitmap to treat as transparent.
;
; Return values .: Success      - True
;                  Failure      - 0 (False)
; Author ........: Greenhorn
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ TransparentBlt
; Example .......;
; ===============================================================================================================================
Func _GDI_TransparentBlt($hDCDest, $nXOriginDest, $nYOriginDest, $nWidthDest, $hHeightDest, $hDCSrc, $nXOriginSrc, $nYOriginSrc, $nWidthSrc, $nHeightSrc, $crTransparent)

	Local $aRes = DllCall($__GDI_msimg32dll, 'int', 'TransparentBlt', _
			'ptr', $hDCDest, _ ; // handle to destination DC
			'int', $nXOriginDest, _ ; // x-coord of destination upper-left corner
			'int', $nYOriginDest, _ ; // y-coord of destination upper-left corner
			'int', $nWidthDest, _ ; // width of destination rectangle
			'int', $hHeightDest, _ ; // height of destination rectangle
			'ptr', $hDCSrc, _ ; // handle to source DC
			'int', $nXOriginSrc, _ ; // x-coord of source upper-left corner
			'int', $nYOriginSrc, _ ; // y-coord of source upper-left corner
			'int', $nWidthSrc, _ ; // width of source rectangle
			'int', $nHeightSrc, _ ; // height of source rectangle
			'uint', $crTransparent) ; // color to make transparent
	If @error Then Return SetError(@error, 0, 0)
	Return $aRes[0]

EndFunc   ;==>_GDI_TransparentBlt

#EndRegion					Bitmaps
;*************************************************************
