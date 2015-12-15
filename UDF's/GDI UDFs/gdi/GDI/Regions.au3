#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         Prog@ndy, Greenhorn

 Script Function:
	GDI functions for Regions

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region					 Regions

;===============================================================================
;
; Function Name:   _GDI_CombineMultiRgn()
; Description::    Combine Mutliple Regions into first variable in array
; Parameter(s):    $a_rgns - Array of region variables to be combined
;                  $fnCombineMode - Description see _GDI_CombineRgn()
; Requirement(s):
; Return Value(s): see _GDI_CombineRgn()
;                  The resulting Region is saved in $a_rgns[0]
; Author(s):       RazerM
;
;===============================================================================
;

Func _GDI_CombineMultiRgn(ByRef $a_rgns,$fnCombineMode=2)
	Local $aResult
	For $i = 1 To UBound($a_rgns) - 1
		$aResult = DllCall($__GDI_gdi32dll, "ptr", "CombineRgn", "ptr", $a_rgns[0], "ptr", $a_rgns[0], "ptr", $a_rgns[$i], "int", $fnCombineMode)
		If @error Or $aResult[0] = 0 Then Return SetError(@error, 0, 0)
	Next
	Return $aResult[0]
EndFunc   ;==>CombineMultiRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CombineRgn
; Description ...: Combines two regions and stores the result in a third region
; Syntax.........: _GDI_CombineRgn($hRgnDest, $hRgnSrc1, $hRgnSrc2, $iCombineMode)
; Parameters ....: $hRgnDest - Handle to a new region with dimensions defined by combining two other regions. (This region must exist before CombineRgn is called.)
;                  $hRgnSrc1 - Handle to the first of two regions to be combined.
;                  $hRgnSrc2 - Handle to the second of two regions to be combined.
;                  $iCombineMode - Specifies a mode indicating how the two regions will be combined. This parameter can be one of the following values.
;                  |RGN_AND - Creates the intersection of the two combined regions.
;                  |RGN_COPY - Creates a copy of the region identified by hrgnSrc1.
;                  |RGN_DIFF - Combines the parts of hrgnSrc1 that are not part of hrgnSrc2.
;                  |RGN_OR - Creates the union of two combined regions.
;                  |RGN_XOR - Creates the union of two combined regions except for any overlapping areas.
; Return values .: Success      - Specifies the type of the resulting region. It can be one of the following values.
;                  |NULLREGION - The region is empty.
;                  |SIMPLEREGION - The region is a single rectangle.
;                  |COMPLEXREGION - The region is more than a single rectangle.
;                  |ERROR - No region is created.
;                  Failure      - 0
; Author ........: Zedna
; Modified.......:
; Remarks .......: The two regions are combined according to the specified mode.
;                  The three regions need not be distinct. For example, the hrgnSrc1 parameter can equal the hrgnDest parameter.
; Related .......: _WinAPI_CreateRectRgn, _WinAPI_CreateRoundRectRgn, _WinAPI_SetWindowRgn
; Link ..........; @@MsdnLink@@ CombineRgn
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_CombineRgn($hRgnDest, $hRgnSrc1, $hRgnSrc2, $iCombineMode)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "CombineRgn", "ptr", $hRgnDest, "ptr", $hRgnSrc1, "ptr", $hRgnSrc2, "int", $iCombineMode)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CombineRgn


; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateEllipticRgn
; Description ...: Creates an elliptical region
; Syntax.........: _GDI_CreateEllipticRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect)
; Parameters ....: $iLeftRect - X-coordinate of the upper-left corner of the bounding rectangle of the ellipse.
;                  $iTopRect - Y-coordinate of the upper-left corner of the bounding rectangle of the ellipse.
;                  $iRightRect - X-coordinate of the lower-right corner of the bounding rectangle of the ellipse.
;                  $iBottomRect - Y-coordinate of the lower-right corner of the bounding rectangle of the ellipse.
; Return values .: Success      - Returns the handle to the region
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: When you no longer need the HRGN object call the _WinAPI_DeleteObject function to delete it.
;                  A bounding rectangle defines the size, shape, and orientation of the region: The long sides of the rectangle
;                  define the length of the ellipse's major axis; the short sides define the length of the ellipse's minor axis;
;                  and the center of the rectangle defines the intersection of the major and minor axes.
; Related .......: _GDI_CreateRoundRectRgn, _GDI_SetWindowRgn, _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreateEllipticRgn
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_CreateEllipticRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect)
	Local $hRgn = DllCall($__GDI_gdi32dll, "ptr", "CreateEllipticRgn", "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect)
	If @error Then Return SetError(@error, 0, 0)
	Return $hRgn[0]
EndFunc   ;==>_WinAPI_CreateEllipticRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateEllipticRgnIndirect
; Description ...: Creates an elliptical region
; Syntax.........: _GDI_CreateEllipticRgnIndirect($iLeftRect, $iTopRect, $iRightRect, $iBottomRect)
; Parameters ....: $pRect - Pointer to a RECT structure that contains the coordinates of the upper-left and lower-right corners
;                  |of the bounding rectangle of the ellipse in logical units.
; Return values .: Success      - Returns the handle to the region
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: When you no longer need the HRGN object call the _WinAPI_DeleteObject function to delete it.
;                  A bounding rectangle defines the size, shape, and orientation of the region: The long sides of the rectangle
;                  define the length of the ellipse's major axis; the short sides define the length of the ellipse's minor axis;
;                  and the center of the rectangle defines the intersection of the major and minor axes.
; Related .......: _GDI_CreateRoundRectRgn, _GDI_SetWindowRgn, _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreateEllipticRgn
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_CreateEllipticRgnIndirect($pRect)
	Local $hRgn = DllCall($__GDI_gdi32dll, "ptr", "CreateEllipticRgnIndirect", "ptr", $pRect)
	If @error Then Return SetError(@error, 0, 0)
	Return $hRgn[0]
EndFunc   ;==>_WinAPI_CreateEllipticRgnIndirect

;===============================================================================
;
; Function Name:   _GDI_CreatePolyRgn()
; Description::    Create a polygon region
; Parameter(s):    $arPoints - 2D-Array of Points for Polygon:
;                    [0][0] x-coordinate of Point 1
;                    [0][1] y-coordinate of Point 1
;                    ...
;                    [n][0] x-coordinate of Point n
;                    [n][1] y-coordinate of Point n
; Requirement(s):
; Return Value(s): Region handle
; Author(s):       Larry, Improved by RazerM
; Modified:        Prog@ndy
;
;===============================================================================
;
Func _GDI_CreatePolyRgn(ByRef $arPoints,$FillMode=$ALTERNATE)
	If UBound($arPoints, 2) <> 2 Then Return SetError(1, 0, 0)
;~ 	Local $ALTERNATE = 1
	Local $Pointsstruct = _GDI_PointArCreate($arPoints)

	Local $ret = DllCall($__GDI_gdi32dll, "long", "CreatePolygonRgn", _
			"ptr", DllStructGetPtr($Pointsstruct), "int", UBound($arPoints), _
			"int", $FillMode)
;~ 	$lppt = 0
	Return $ret[0]
EndFunc   ;==>CreatePolyRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateRectRgn
; Description ...: Creates a rectangular region
; Syntax.........: _GDI_CreateRectRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect)
; Parameters ....: $iLeftRect - X-coordinate of the upper-left corner of the region
;                  $iTopRect - Y-coordinate of the upper-left corner of the region
;                  $iRightRect - X-coordinate of the lower-right corner of the region
;                  $iBottomRect - Y-coordinate of the lower-right corner of the region
; Return values .: Success      - Returns the handle to the region
;                  Failure      - 0
; Author ........: Zedna
; Modified.......:
; Remarks .......: When you no longer need the HRGN object call the _WinAPI_DeleteObject function to delete it.
;                  Region coordinates are represented as 27-bit signed integers.
;                  The region will be exclusive of the bottom and right edges.
; Related .......: _GDI_CreateRoundRectRgn, _GDI_SetWindowRgn, _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreateRectRgn
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_CreateRectRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect)
	Local $hRgn = DllCall($__GDI_gdi32dll, "ptr", "CreateRectRgn", "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect)
	If @error Then Return SetError(@error, 0, 0)
	Return $hRgn[0]
EndFunc   ;==>_WinAPI_CreateRectRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateRoundRectRgn
; Description ...: Creates a rectangular region with rounded corners
; Syntax.........: _GDI_CreateRoundRectRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iWidthEllipse, $iHeightEllipse)
; Parameters ....: $iLeftRect - X-coordinate of the upper-left corner of the region
;                  $iTopRect - Y-coordinate of the upper-left corner of the region
;                  $iRightRect - X-coordinate of the lower-right corner of the region
;                  $iBottomRect - Y-coordinate of the lower-right corner of the region
;                  $iWidthEllipse - Width of the ellipse used to create the rounded corners
;                  $iHeightEllipse - Height of the ellipse used to create the rounded corners
; Return values .: Success      - Returns the handle to the region
;                  Failure      - 0
; Author ........: Zedna
; Modified.......:
; Remarks .......: When you no longer need the HRGN object call the _WinAPI_DeleteObject function to delete it.
;                  Region coordinates are represented as 27-bit signed integers.
; Related .......: _GDI_CreateRectRgn, _GDI_SetWindowRgn, _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreateRoundRectRgn
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_CreateRoundRectRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iWidthEllipse, $iHeightEllipse)
	Local $hRgn = DllCall($__GDI_gdi32dll, "ptr", "CreateRoundRectRgn", "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect, _
			"int", $iWidthEllipse, "int", $iHeightEllipse)
	If @error Then Return SetError(@error, 0, 0)
	Return $hRgn[0]
EndFunc   ;==>_WinAPI_CreateRoundRectRgn

;===============================================================================
;
; Function Name:   _GDI_CreateTriangleRgn()
; Description::    Creates a triangular region
; Parameter(s):    left, top, width, height
; Requirement(s):  AutoIt Beta
; Return Value(s): Region Handle
; Author(s):       RazerM
; Modified:        Prog@ndy
;
;===============================================================================
;
Func _GDI_CreateTriangleRgn($l, $t, $w, $h,$FillMode=$ALTERNATE)
	Local $arPoints[4][2] = [[ $l + ($w / 2), $t], [$l + $w,$t + $h], [$l, $t + $h], [$l + ($w / 2), $t]]
;~ 	Return _GDI_CreatePolyRgn("0,0," & $l + ($w / 2) & "," & $t & "," & $l + $w & "," & $t + $h & "," & $l & "," & $t + $h & "," & $l + ($w / 2) & "," & $t & ",0,0")
	Local $aResult = _GDI_CreatePolyRgn($arPoints, $FillMode)
	Return SetError(@error,@extended,$aResult)
EndFunc   ;==>CreateTriangleRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_FillRgn
; Description ...: Fills a region by using the specified brush.
; Syntax.........: _GDI_FillRgn($hdc,$hrgn, $hbr)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $hrgn  - [in] Handle to the region to be filled. The region's coordinates are presumed to be in logical units.
;                  $hbr   - [in] Handle to the brush to be used to fill the region.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ FillRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_FillRgn($hdc,$hrgn, $hbr)
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'FillRgn', 'ptr', $hdc, 'ptr', $hrgn, 'ptr', $hbr)
	If @error Then Return SetError(@error,@extended,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PtInRegion
; Description ...: Determines whether the specified point is inside the specified region.
; Syntax.........: _GDI_PtInRegion($hrgn, $iX, $iY)
; Parameters ....: $hrgn  - [in] Handle to the region to be examined.
;                  $X     - [in] Specifies the x-coordinate of the point in logical units.
;                  $Y     - [in] Specifies the y-coordinate of the point in logical units.
; Return values .: Success      - nonzero, the point is in the region
;                  Failure      - 0, the point not in region or an error occured
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ PtInRegion
; Example .......;
; ===============================================================================================================================
Func _GDI_PtInRegion($hrgn, $iX, $iY)
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'PtInRegion', 'ptr', $hrgn, 'int', $iX, 'int', $iY)
	If @error Then Return SetError(@error,@extended,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_RectInRegion
; Description ...: Determines whether the specified rectangle overlaps the specified region.
; Syntax.........: _GDI_RectInRegion($hrgn, $iX, $iY)
; Parameters ....: $hrgn  - [in] Handle to the region to be examined.
;                  $lpRect  - [in] Pointer to a RECT structure containing the coordinates of the rectangle in logical units.
;                  |The lower and right edges of the rectangle are not included.
; Return values .: Success      - nonzero, some part of the specified rectangle lies within the boundaries of the region
;                  Failure      - 0, the rectangle lies NOT in the region
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ RectInRegion
; Example .......;
; ===============================================================================================================================
Func _GDI_RectInRegion($hrgn, $lpRect)
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'RectInRegion', 'ptr', $hrgn, 'ptr', $lpRect)
	If @error Then Return SetError(@error,@extended,0)
	Return $aResult[0]
EndFunc


#EndRegion
;*************************************************************
