#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         Prog@ndy, Greenhorn

 Script Function:
	GDI functions for Rectangles

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region					Rectangles

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_RectCreate
; Description ...: Create a $tagRECT structure
; Syntax.........: _GDIPlus_RectCreate([$nX = 0[, $nY = 0[, $nWidth = 0[, $nHeight = 0]]]])
; Parameters ....: $left   - Specifies the x-coordinate of the upper-left corner of the rectangle.
;                  $top    - Specifies the y-coordinate of the upper-left corner of the rectangle.
;                  $right  - Specifies the x-coordinate of the lower-right corner of the rectangle.
;                  $bottom - Specifies the y-coordinate of the lower-right corner of the rectangle.

; Return values .: Success      - $tagGDIPRECTF structure
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; ===============================================================================================================================
Func _GDI_RectCreate($left = 0, $top = 0, $right = 0, $bottom = 0)
	Local $tRect

	$tRect = DllStructCreate($tagRECT)
	DllStructSetData($tRect, "Left", $left)
	DllStructSetData($tRect, "Top", $top)
	DllStructSetData($tRect, "Right", $right)
	DllStructSetData($tRect, "Bottom", $bottom)
	Return $tRect
EndFunc   ;==>_GDI_RectCreate

#EndRegion
;*************************************************************