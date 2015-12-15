#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region				Lines and Curves

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_Arc
; Description ...: Draws an elliptical arc
; Syntax.........: _GDI_Arc($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iXStartArc, $iYStartArc, $iXEndArc, $iYEndArc)
; Parameters ....: $hDC - Identifies the device contex
; $iLeftRect - x-coord of rectangle's upper-left corner
; $iTopRect - y-coord of rectangle's upper-left corner
; $iRightRect - x-coord of rectangle's lower-right corner
; $iBottomRect - y-coord of rectangle's lower-right corner
; $iXStartArc - x-coord of first radial ending point
; $iYStartArc - y-coord of first radial ending point
; $iXEndArc - x-coord of second radial ending point
; $iYEndArc - y-coord of second radial ending point
; Return values .: Success - return value is nonzero
; Author.........: GRS
; ====================================================================================================
Func _GDI_Arc($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iXStartArc, $iYStartArc, $iXEndArc, $iYEndArc)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "Arc", "long", $hDC, "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect, "int", $iXStartArc, "int", $iYStartArc, "int", $iXEndArc, "int", $iYEndArc)
	Return $aResult[0]
EndFunc   ;==>_GDI_Arc

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_ArcTo
; Description ...: Draws an elliptical arc
; Syntax.........: _GDI_ArcTo($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iXRadial1, $iYRadial1, $iXRadial2, $iYRadial2)
; Parameters ....: $hDC - Identifies the device contex
; $iLeftRect - x-coord of rectangle's upper-left corner
; $iTopRect - y-coord of rectangle's upper-left corner
; $iRightRect - x-coord of rectangle's lower-right corner
; $iBottomRect - y-coord of rectangle's lower-right corner
; $iXRadial1 - x-coord of first radial ending point
; $iYRadial1 - y-coord of first radial ending point
; $iXRadial2 - x-coord of second radial ending point
; $iYRadial2 - y-coord of second radial ending point
; Return values .: Success - return value is nonzero
; Author.........: GRS
; ====================================================================================================
Func _GDI_ArcTo($hDC, $iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iXRadial1, $iYRadial1, $iXRadial2, $iYRadial2)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "ArcTo", "long", $hDC, "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect, "int", $iXRadial1, "int", $iYRadial1, "int", $iXRadial2, "int", $iYRadial2)
	Return $aResult[0]
EndFunc   ;==>_GDI_ArcTo

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_LineTo
; Description ...: Draws a line from the current position up to, but not including, the specified point.
; Syntax.........: _GDI_LineTo($hDC, $iX, $iY)
; Parameters ....: $hDC - Handle to device context
;                  $iX - X coordinate of the line's ending point.
;                  $iY - Y coordinate of the line's ending point.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Zedna
; Modified.......:
; Remarks .......: The line is drawn by using the current pen and, if the pen is a geometric pen, the current brush.
;                  If LineTo succeeds, the current position is set to the specified ending point.
; Related .......: _WinAPI_MoveTo, _WinAPI_DrawLine, _WinAPI_SelectObject, _WinAPI_CreatePen
; Link ..........; @@MsdnLink@@ LineTo
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_LineTo($hDC, $iX, $iY)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "LineTo", "int", $hDC, "int", $iX, "int", $iY)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_LineTo

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_MoveTo
; Description ...: Updates the current position to the specified point
; Syntax.........: _GDI_MoveTo($hDC, $iX, $iY)
; Parameters ....: $hDC - Handle to device context
;                  $iX - X coordinate of the new position.
;                  $iY - Y coordinate of the new position.
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Zedna
; Modified.......:
; Remarks .......: The MoveTo function affects all drawing functions.
; Related .......: _WinAPI_LineTo, _WinAPI_DrawLine, _WinAPI_SelectObject
; Link ..........; @@MsdnLink@@ MoveToEx
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_MoveTo($hDC, $iX, $iY)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "MoveToEx", "int", $hDC, "int", $iX, "int", $iY, "ptr", 0)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_MoveTo

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_MoveToEx
; Description ...: Updates the current position to the specified point and optionally retrieves the previous position
; Syntax.........: _GDI_MoveToEx($hDC, $iX, $iY, $tPoint)
; Parameters ....: $hDC - Identifies the device contex
; $iX - x-coordinate of the new position, in logical units
; $iY - y-coordinate of the new position, in logical units
; $lpPoint - Pointer to a $tagPOINT structure that receives the previous position
; Return values .: Success - non-zero value
; Author.........: GRS
; ====================================================================================================
Func _GDI_MoveToEx($hDC, $iX, $iY, $lpPoint=0)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "MoveToEx", "long", $hDC, "int", $iX, "int", $iY, "ptr", $lpPoint)
	Return $aResult[0]
EndFunc   ;==>_GDI_MoveToEx

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_Polyline
; Description ...: Draws a Polyline
; Syntax.........: _GDI_Polyline($hDC, $iXEnd, $iYEnd)
; Parameters ....: $hDC - Identifies the device context
; $arPoints - 2D-Array of Points for Polygon:
;   [0][0] x-coordinate of Point 1
;   [0][1] y-coordinate of Point 1
;   ...
;   [n][0] x-coordinate of Point n
;   [n][1] y-coordinate of Point n
; $iYEnd - y-coordinate, in logical units, of the endpoint of the line
; Return values .: Success - non-zero value
; Author.........: Prog@ndy
; ====================================================================================================
Func _GDI_Polyline($hDC, $arPoints)
	Local $aResult
	If UBound($arPoints) < 2 Then Return SetError(1, 0, 0)
	If UBound($arPoints, 0) <> 2 Then Return SetError(2, 0, 0)
	Local $Points = _GDI_PointArCreate($arPoints)
	$aResult = DllCall($__GDI_gdi32dll, "long", "Polyline", "long", $hDC, "ptr", DllStructGetPtr($Points), "int", UBound($arPoints))
	Return $aResult[0]
EndFunc   ;==>_GDI_Polyline

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_PolylineTo
; Description ...: Draws a Polyline:
;    A line is drawn from the current position to the first point specified by the lppt parameter by using
;    the current pen. For each additional line, the function draws from the ending point of the previous
;    line to the next point specified by lppt.
; Syntax.........: _GDI_PolylineTo($hDC, $iXEnd, $iYEnd)
; Parameters ....: $hDC - Identifies the device context
; $arPoints - 2D-Array of Points for Polygon:
;   [0][0] x-coordinate of Point 1
;   [0][1] y-coordinate of Point 1
;   ...
;   [n][0] x-coordinate of Point n
;   [n][1] y-coordinate of Point n
; $iYEnd - y-coordinate, in logical units, of the endpoint of the line
; Return values .: Success - non-zero value
; Author.........: Prog@ndy
; ====================================================================================================
Func _GDI_PolylineTo($hDC, $arPoints)
	Local $aResult
	If UBound($arPoints) < 1 Then Return SetError(1, 0, 0)
	If UBound($arPoints, 0) <> 2 Then Return SetError(2, 0, 0)
	Local $Points = _GDI_PointArCreate($arPoints)
	$aResult = DllCall($__GDI_gdi32dll, "long", "PolylineTo", "long", $hDC, "ptr", DllStructGetPtr($Points), "int", UBound($arPoints))
	Return $aResult[0]
EndFunc   ;==>_GDI_PolylineTo

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_PolyBezier
; Description ...: Draws a PolyBezier
; Syntax.........: _GDI_PolylineTo($hDC, $iXEnd, $iYEnd)
; Parameters ....: $hDC - Identifies the device context
; $arPoints - 2D-Array of Points for Bezier-Curve:
;    Specifies the number of points in the lppt array. This value must be one more than three times the number
;    of curves to be drawn, because each Bézier curve requires two control points and an endpoint, and the
;    initial curve requires an additional starting point.
; $iYEnd - y-coordinate, in logical units, of the endpoint of the line
; Return values .: Success - non-zero value
; Author.........: Prog@ndy
; ====================================================================================================
Func _GDI_PolyBezier($hDC, $arPoints)
	Local $aResult
	If UBound($arPoints) < 4 Or Mod(UBound($arPoints), 3) <> 1 Then Return SetError(1, 0, 0)
	If UBound($arPoints, 0) <> 2 Then Return SetError(2, 0, 0)
	Local $Points = _GDI_PointArCreate($arPoints)
	$aResult = DllCall($__GDI_gdi32dll, "long", "PolyBezier", "long", $hDC, "ptr", DllStructGetPtr($Points), "int", UBound($arPoints))
	Return $aResult[0]
EndFunc   ;==>_GDI_PolyBezier

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_PolyBezierTo
; Description ...: Draws a PolyBezier:
;    This function draws cubic Bézier curves by using the control points specified by the lppt parameter.
;    The first curve is drawn from the current position to the third point by using the first two points
;    as control points. For each subsequent curve, the function needs exactly three more points, and uses
;    the ending point of the previous curve as the starting point for the next.
; Syntax.........: _GDI_PolylineTo($hDC, $iXEnd, $iYEnd)
; Parameters ....: $hDC - Identifies the device context
; $arPoints - 2D-Array of Points for Bezier-Curve:
;    Specifies the number of points in the lppt array. This value must be three times the number of curves to
;    be drawn, because each Bézier curve requires two control points and an ending point.
; $iYEnd - y-coordinate, in logical units, of the endpoint of the line
; Return values .: Success - non-zero value
; Author.........: Prog@ndy
; ====================================================================================================
Func _GDI_PolyBezierTo($hDC, $arPoints)
	Local $aResult
	If UBound($arPoints) < 3 Or Mod(UBound($arPoints), 3) <> 0 Then Return SetError(1, 0, 0)
	If UBound($arPoints, 0) <> 2 Then Return SetError(2, 0, 0)
	Local $Points = _GDI_PointArCreate($arPoints)
	$aResult = DllCall($__GDI_gdi32dll, "long", "PolyBezierTo", "long", $hDC, "ptr", DllStructGetPtr($Points), "int", UBound($arPoints))
	Return $aResult[0]
EndFunc   ;==>_GDI_PolyBezierTo

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_SetArcDirection
; Description ...: Sets the drawing direction to be used for arc and rectangle functions
; Syntax.........: _GDI_SetArcDirection($hDC, $Direction)
; Parameters ....: $hDC - Identifies the device contex
; $Direction - Specifies the new arc direction
; $AD_COUNTERCLOCKWISE = 1
; $AD_CLOCKWISE = 2
; Return values .: Success - old arc direction
; Author.........: GRS
; ====================================================================================================
Func _GDI_SetArcDirection($hDC, $Direction)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "SetArcDirection", "long", $hDC, "int", $Direction)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetArcDirection

#EndRegion
;*************************************************************