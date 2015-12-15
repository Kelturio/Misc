#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region				  Filled Shapes

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_Chord
; Description ...: Draws a chord (a region bounded by the intersection of an ellipse and a line segment, called a secant).
;                    The chord is outlined by using the current pen and filled by using the current brush.
; Syntax.........: _GDI_Chord($hdc, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect, $nXRadial1, $nYRadial1, $nXRadial2, $nYRadial2)
; Parameters ....: $hdc          - [in] Handle to the device context in which the chord appears.
;                  $nLeftRect    - [in] Specifies the x-coordinate, in logical coordinates,
;                                       of the upper-left corner of the bounding rectangle.
;                  $nTopRect     - [in] Specifies the y-coordinate, in logical coordinates,
;                                       of the upper-left corner of the bounding rectangle.
;                  $nRightRect   - [in] Specifies the x-coordinate, in logical coordinates,
;                                       of the lower-right corner of the bounding rectangle.
;                  $nBottomRect  - [in] Specifies the y-coordinate, in logical coordinates,
;                                       of the lower-right corner of the bounding rectangle.
;                  $nXRadial1    - [in] Specifies the x-coordinate, in logical coordinates,
;                                       of the endpoint of the radial defining the beginning of the chord.
;                  $nYRadial1    - [in] Specifies the y-coordinate, in logical coordinates,
;                                       of the endpoint of the radial defining the beginning of the chord.
;                  $nXRadial2    - [in] Specifies the x-coordinate, in logical coordinates,
;                                       of the endpoint of the radial defining the end of the chord.
;                  $nYRadial2    - [in] Specifies the y-coordinate, in logical coordinates,
;                                       of the endpoint of the radial defining the end of the chord.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The curve of the chord is defined by an ellipse that fits the specified bounding rectangle.
;                    The curve begins at the point where the ellipse intersects the first radial and extends counterclockwise
;                    to the point where the ellipse intersects the second radial. The chord is closed by drawing a line from
;                    the intersection of the first radial and the curve to the intersection of the second radial and the curve.
;                  If the starting point and ending point of the curve are the same, a complete ellipse is drawn.
;                  The current position is neither used nor updated by Chord.
;                  Windows 95/98/Me: The sum of the coordinates of the bounding rectangle cannot exceed 32,767.
;                    The sum of nLeftRect and nRightRect or nTopRect and nBottomRect parameters cannot exceed 32,767.
; Related .......:
; Link ..........; @@MsdnLink@@ Chord
; Example .......;
; ===============================================================================================================================
Func _GDI_Chord($hdc, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect, $nXRadial1, $nYRadial1, $nXRadial2, $nYRadial2)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "Chord", "ptr", $hdc, "int", $nLeftRect, "int", $nTopRect, "int", $nRightRect, "int", $nBottomRect, _
				"int", $nXRadial1, "int", $nYRadial1, "int", $nXRadial2, "int", $nYRadial2)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_Ellipse
; Description ...: Draws an ellipse. The center of the ellipse is the center of the specified bounding rectangle.
;                    The ellipse is outlined by using the current pen and is filled by using the current brush.
; Syntax.........: _GDI_Ellipse($hDC, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect )
; Parameters ....: $hDC          - [in] Handle to the device context.
;                  $nLeftRect    - [in] Specifies the x-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
;                  $nTopRect     - [in] Specifies the y-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
;                  $nRightRect   - [in] Specifies the x-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
;                  $nBottomRect  - [in] Specifies the y-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The current position is neither used nor updated by Ellipse.
;                  Windows 95/98/Me: The sum of the coordinates of the bounding rectangle cannot exceed 32,767.
;                    The sum of nLeftRect and nRightRect or nTopRect and nBottomRect parameters cannot exceed 32,767.
; Related .......:
; Link ..........; @@MsdnLink@@ Ellipse
; Example .......;
; ===============================================================================================================================
Func _GDI_Ellipse($hDC, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect )
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "Ellipse", "ptr", $hDC, "int", $nLeftRect, "int", $nTopRect, "int", $nRightRect, "int", $nBottomRect)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc   ;==>_GDI_Ellipse

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_FillRect
; Description ...: Fills a rectangle by using the specified brush. This function includes the left and top borders, but
;                    excludes the right and bottom borders of the rectangle.
; Syntax.........: _GDI_FillRect($hDC, $lprc, $hbr)
; Parameters ....: $hDC   - [in] Handle to the device context.
;                  $lprc  - [in] Pointer to a RECT structure that contains the logical coordinates of the rectangle to be filled.
;                  $hbr   - [in] Handle to the brush used to fill the rectangle.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The brush identified by the hbr parameter may be either a handle to a logical brush or a color value.
;                    If specifying a handle to a logical brush, call one of the following functions to obtain the handle:
;                    CreateHatchBrush, CreatePatternBrush, or CreateSolidBrush. Additionally, you may retrieve a handle
;                    to one of the stock brushes by using the GetStockObject function. If specifying a color value for the
;                    hbr parameter, it must be one of the standard system colors (the value 1 must be added to the chosen color).
;                    For example:
;                    FillRect($hdc, DLLStructGetPtr($rect), ($COLOR_WINDOW+1));
;                  For a list of all the standard system colors, see GetSysColor.
;                  When filling the specified rectangle, FillRect does not include the rectangle's right and bottom sides. GDI
;                    fills a rectangle up to, but not including, the right column and bottom row, regardless of the current mapping mode.
; Related .......:
; Link ..........; @@MsdnLink@@ FillRect
; Example .......;
; ===============================================================================================================================
Func _GDI_FillRect($hDC, $lprc, $hbr)
	Local $aResult = DllCall($__GDI_user32dll, "int", "FillRect", "ptr", $hDC, "ptr", $lprc, "ptr", $hbr)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_FrameRect
; Description ...: Draws a border around the specified rectangle by using the specified brush.
;                    The width and height of the border are always one logical unit.
; Syntax.........: _GDI_FrameRect($hDC, $lprc, $hbr)
; Parameters ....: $hDC   - [in] Handle to the device context in which the border is drawn.
;                  $lprc  - [in] Pointer to a RECT structure that contains the logical coordinates of the upper-left and
;                                 lower-right corners of the rectangle.
;                  $hbr   - [in] A handle to the brush used to draw the border.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The brush identified by the hbr parameter must have been created by using the  CreateHatchBrush,
;                    CreatePatternBrush, or  CreateSolidBrush function, or retrieved by using the  GetStockObject function.
;                  If the bottom member of the RECT structure is less than or equal to the top member, or if the right member
;                    is less than or equal to the left member, the function does not draw the rectangle.
; Related .......:
; Link ..........; @@MsdnLink@@ FrameRect
; Example .......;
; ===============================================================================================================================
Func _GDI_FrameRect($hDC, $lprc, $hbr)
	Local $aResult = DllCall($__GDI_user32dll, "int", "FrameRect", "ptr", $hDC, "ptr", $lprc, "ptr", $hbr)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_InvertRect
; Description ...: Draws a border around the specified rectangle by using the specified brush.
;                    The width and height of the border are always one logical unit.
; Syntax.........: _GDI_InvertRect($hDC, $lprc)
; Parameters ....: $hDC   - [in] Handle to the device context.
;                  $lprc  - [in] Pointer to a RECT structure that contains the logical coordinates of the rectangle to be inverted.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: On monochrome screens, InvertRect makes white pixels black and black pixels white. On color screens,
;                    the inversion depends on how colors are generated for the screen. Calling InvertRect twice for the same
;                    rectangle restores the display to its previous colors.
; Related .......:
; Link ..........; @@MsdnLink@@ InvertRect
; Example .......;
; ===============================================================================================================================
Func _GDI_InvertRect($hDC, $lprc)
	Local $aResult = DllCall($__GDI_user32dll, "int", "InvertRect", "ptr", $hDC, "ptr", $lprc)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_Pie
; Description ...: Draws a pie-shaped wedge bounded by the intersection of an ellipse and two radials. The pie is outlined by
;                    using the current pen and filled by using the current brush.
; Syntax.........: _GDI_Pie($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $nXRadial1, $nYRadial1, $nXRadial2, $nYRadial2 )
; Parameters ....: $hdc [in] Handle to the device context.
;                  $nLeftRect [in] Specifies the x-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
;                  $nTopRect [in] Specifies the y-coordinate, in logical coordinates, of the upper-left corner of the bounding rectangle.
;                  $nRightRect [in] Specifies the x-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
;                  $nBottomRect [in] Specifies the y-coordinate, in logical coordinates, of the lower-right corner of the bounding rectangle.
;                  $nXRadial1 [in] Specifies the x-coordinate, in logical coordinates, of the endpoint of the first radial.
;                  $nYRadial1 [in] Specifies the y-coordinate, in logical coordinates, of the endpoint of the first radial.
;                  $nXRadial2 [in] Specifies the x-coordinate, in logical coordinates, of the endpoint of the second radial.
;                  $nYRadial2 [in] Specifies the y-coordinate, in logical coordinates, of the endpoint of the second radial.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The curve of the pie is defined by an ellipse that fits the specified bounding rectangle. The curve begins
;                    at the point where the ellipse intersects the first radial and extends counterclockwise to the point where
;                    the ellipse intersects the second radial.
;                  The current position is neither used nor updated by the Pie function.
;                  Windows 95/98/Me: The sum of the coordinates of the bounding rectangle cannot exceed 32,767.
;                    The sum of nLeftRect and nRightRect or nTopRect and nBottomRect parameters cannot exceed 32,767.
; Related .......:
; Link ..........; @@MsdnLink@@ Pie
; Example .......;
; ===============================================================================================================================
Func _GDI_Pie($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $nXRadial1, $nYRadial1, $nXRadial2, $nYRadial2 )
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "int", "Pie", "ptr", $hDC, "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect, "int", $nXRadial1, "int", $nYRadial1, "int", $nXRadial2, "int", $nYRadial2)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc   ;==>_GDI_Pie

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_Polygon
; Description ...: Draws a Polygon
; Syntax.........: _GDI_Polygon($hDC, $arPoints, $nCount=0)
; Parameters ....: $hDC - Identifies the device context.
;                  $arPoints - an array of  points that specify the vertices of the polygon, in logical coordinates.
;                               [0][0] x-coordinate of Point 1
;                               [0][1] y-coordinate of Point 1
;                               ...
;                               [n][0] x-coordinate of Point n
;                               [n][1] y-coordinate of Point n
;                              can also be a pointer to an array of  POINT structures that specify the
;                               vertices of the polygon, in logical coordinates.
;                  $nCount   - The number of vertices in the array. This value must be greater than or equal to 2.
;                              only required if $arPoints is a Pointer.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author.........: Prog@ndy
; Modified.......:
; Remarks .......: The polygon is closed automatically by drawing a line from the last vertex to the first.
;                  The current position is neither used nor updated by the Polygon function.
;                  Any extra points are ignored. To draw a line with more points, divide your data into groups, each of which
;                    have less than the maximum number of points, and call the function for each group of points.
;                    Remember to connect the line segments.
; Related .......:
; Link ..........; @@MsdnLink@@ Polygon
; Example .......;
; ===============================================================================================================================
Func _GDI_Polygon($hDC, $arPoints, $nCount=0)
	Local $aResult, $pPoints
	If IsPtr($arPoints) Then
		$pPoints = $arPoints
	Else
		If UBound($arPoints) < 2 Then Return SetError(1, 0, 0)
		If UBound($arPoints, 0) <> 2 Then Return SetError(2, 0, 0)
		Local $Pointsstruct=""
		For $i = 1 To UBound($arPoints)
			$Pointsstruct &= "long[2];"
		Next
		Local $Points = DllStructCreate($Pointsstruct)
		For $i = 1 To UBound($arPoints)
			DllStructSetData($Points, $i, $arPoints[$i - 1][0], 1)
			DllStructSetData($Points, $i, $arPoints[$i - 1][1], 2)
		Next
		$pPoints = DllStructGetPtr($Points)
		$nCount = UBound($arPoints)
	EndIf
	$aResult = DllCall($__GDI_gdi32dll, "long", "Polygon", "ptr", $hDC, "ptr", $pPoints, "int", $nCount)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc   ;==>_GDI_Polygon

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PolyPolygon
; Description ...: Draws a series of closed polygons. Each polygon is outlined by using the current pen and filled by using the
;                   current brush and polygon fill mode. The polygons drawn by this function can overlap.
; Syntax.........: _GDI_PolyPolygon($hDC, $lpPoints, $lpPolyCounts, $nCount)
; Parameters ....: $hdc           - [in] A handle to the device context.
;                  $lpPoints      - [in] A pointer to an array of POINT structures that define the vertices of the polygons,
;                                         in logical coordinates. The polygons are specified consecutively. Each polygon is
;                                         closed automatically by drawing a line from the last vertex to the first.
;                                         Each vertex should be specified once.
;                  $lpPolyCounts  - [in] A pointer to an array of integers, each of which specifies the number of points in
;                                         the corresponding polygon. Each integer must be greater than or equal to 2.
;                  $nCount        - [in] The total number of polygons.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The current position is neither used nor updated by this function.
;                  Any extra points are ignored. To draw the polygons with more points, divide your data into groups,
;                   each of which have less than the maximum number of points, and call the function for each group of points.
;                   Note, it is best to have a polygon in only one of the groups.
; Related .......:
; Link ..........; @@MsdnLink@@ PolyPolygon
; Example .......;
; ===============================================================================================================================
Func _GDI_PolyPolygon($hDC, $lpPoints, $lpPolyCounts, $nCount)
	Local $aResult = DllCall($__GDI_gdi32dll, "long", "PolyPolygon", "ptr", $hDC, "ptr", $lpPoints, "ptr", $lpPolyCounts, "int", $nCount)
	If @error Then Return SetError(1,@error,0)
	Return $aResult[0]
EndFunc   ;==>_GDI_Polygon

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_Rectangle
; Description ...: Draws a rectangle. The rectangle is outlined by using the current pen and filled by using the current brush.
; Syntax.........: _GDI_Rectangle($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect )
; Parameters ....: $hdc          - [in] A handle to the device context.
;                  $iLeftRect    - [in] The x-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
;                  $iTopRect     - [in] The y-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
;                  $iRightRect   - [in] The x-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
;                  $iBottomRect  - [in] The y-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: GRS
; Modified.......: Prog@ndy
; Remarks .......: The current position is neither used nor updated by Rectangle.
;                  The rectangle that is drawn excludes the bottom and right edges.
;                  If a PS_NULL pen is used, the dimensions of the rectangle are 1 pixel less in height and 1 pixel less in width.
; Related .......:
; Link ..........; @@MsdnLink@@ Rectangle
; Example .......;
; ===============================================================================================================================
Func _GDI_Rectangle($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect )
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "Rectangle", "ptr", $hDC, "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect)
	Return $aResult[0]
EndFunc   ;==>_GDI_Rectangle

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_RoundRect
; Description ...: Draws a rectangle with rounded corners.
;                  The rectangle is outlined by using the current pen and filled by using the current brush.
; Syntax.........: _GDI_RoundRect($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iWidth, $iHeight )
; Parameters ....: $hdc          - [in] A handle to the device context.
;                  $iLeftRect    - [in] The x-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
;                  $iTopRect     - [in] The y-coordinate, in logical coordinates, of the upper-left corner of the rectangle.
;                  $iRightRect   - [in] The x-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
;                  $iBottomRect  - [in] The y-coordinate, in logical coordinates, of the lower-right corner of the rectangle.
;                  $iWidth       - [in] The width, in logical coordinates, of the ellipse used to draw the rounded corners.
;                  $iHeight      - [in] The height, in logical coordinates, of the ellipse used to draw the rounded corners.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: GRS
; Modified.......: Prog@ndy
; Remarks .......: The current position is neither used nor updated by this function.
; Related .......:
; Link ..........; @@MsdnLink@@ RoundRect
; Example .......;
; ===============================================================================================================================
Func _GDI_RoundRect($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iWidth, $iHeight )
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "RoundRect", "ptr", $hDC, "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect, "int", $iWidth, "int", $iHeight)
	Return $aResult[0]
EndFunc   ;==>_GDI_RoundRect

#EndRegion
;*************************************************************
