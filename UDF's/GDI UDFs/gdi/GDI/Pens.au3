#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         Prog@ndy, Greenhorn

 Script Function:
	GDI functions for Pens

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region					  Pens

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreatePen
; Description ...: Creates a logical pen that has the specified style, width, and color.
; Syntax.........: _GDI_CreatePen($iPenStyle, $iWidth, $nColor)
; Parameters ....: $iPenStyle - Specifies the pen style. It can be any one of the following values.
;                  |PS_SOLID - The pen is solid.
;                  |PS_DASH - The pen is dashed. This style is valid only when the pen width is one or less in device units.
;                  |PS_DOT - The pen is dotted. This style is valid only when the pen width is one or less in device units.
;                  |PS_DASHDOT - The pen has alternating dashes and dots. This style is valid only when the pen width is one or less in device units.
;                  |PS_DASHDOTDOT - The pen has alternating dashes and double dots. This style is valid only when the pen width is one or less in device units.
;                  |PS_NULL - The pen is invisible.
;                  |PS_INSIDEFRAME - The pen is solid. When this pen is used in any GDI drawing function that takes a bounding rectangle, the dimensions of the figure are shrunk so that it fits entirely in the bounding rectangle, taking into account the width of the pen. This applies only to geometric pens.
;                  $iWidth - Specifies the width of the pen, in logical units.
;                  CreatePen returns a pen with the specified width bit with the PS_SOLID style if you specify a width greater than one for the following styles: PS_DASH, PS_DOT, PS_DASHDOT, PS_DASHDOTDOT.
;                  If nWidth is zero, the pen is a single pixel wide, regardless of the current transformation.
;                  $nColor - Specifies the color of the pen (BGR)
; Return values .: Success      - HPEN Value that identifies a logical pen
;                  Failure      - 0
; Author ........: Zedna
; Modified.......:
; Remarks .......: The pen can subsequently be selected into a device context and used to draw lines and curves.
;                  After an application creates a logical pen, it can select that pen into a device context by calling the SelectObject function. After a pen is selected into a device context, it can be used to draw lines and curves.
;                  If the value specified by the nWidth parameter is zero, a line drawn with the created pen always is a single pixel wide regardless of the current transformation.
;                  If the value specified by nWidth is greater than 1, the fnPenStyle parameter must be PS_NULL, PS_SOLID, or PS_INSIDEFRAME.
;                  When you no longer need the pen, call the DeleteObject function to delete it.
; Related .......: _GDI_MoveTo, _GDI_LineTo, _GDI_SelectObject, _GDI_DeleteObject
; Link ..........; @@MsdnLink@@ CreatePen
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_CreatePen($iPenStyle, $iWidth, $nColor)
	Local $hPen = DllCall($__GDI_gdi32dll, "ptr", "CreatePen", "int", $iPenStyle, "int", $iWidth, "int", $nColor)
	If @error Then Return SetError(@error, 0, 0)
	Return $hPen[0]
EndFunc   ;==>_GDI_CreatePen

#EndRegion
;*************************************************************