#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region			Painting and Drawing

; Greenhorn
Func _GDI_BeginPaint($hWnd, $lpPaint)

	Local $aResult = DllCall($__GDI_user32dll, 'ptr', 'BeginPaint', 'hwnd', $hWnd, 'ptr', $lpPaint)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]

EndFunc

; Greenhorn
Func _GDI_EndPaint($hWnd, $lpPaint)

	Local $aResult = DllCall($__GDI_user32dll, 'int', 'EndPaint', 'hwnd', $hWnd, 'ptr', $lpPaint)
	If @error Then Return SetError(1,0,0)
	Return $aResult[0]

EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetBkMode
; Description ...: Returns the current background mix mode for a specified device context
; Syntax.........: _GDI_GetBkMode($hDC)
; Parameters ....: $hDC - Handle to the device context whose background mode is to be returned
; Return values .: Success      - Value specifies the current background mix mode, either OPAQUE or TRANSPARENT
;                  Failure      - 0
; Author ........: Zedna
; Modified.......:
; Remarks .......: The background mix mode of a device context affects text, hatched brushes, and pen styles that are not solid lines.
; Related .......: _GDI_SetBkMode, _GDI_DrawText, _GDI_CreatePen, _GDI_SelectObject
; Link ..........; @@MsdnLink@@ GetBkMode
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_GetBkMode($hDC)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetBkMode", "ptr", $hDC)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetBkMode

; Greenhorn
Func _GDI_InvalidateRgn ($hWnd, $hRgn, $bErase)

	Local $aRes = DllCall($__GDI_user32dll, 'int', 'InvalidateRgn', _
											  'hwnd', $hWnd, _   ; // handle to window
											  'ptr',  $hRgn, _   ; // handle to region
											  'int',  $bErase )  ; // erase state
	Return $aRes[0]

EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetBkColor
; Description ...: Sets the current background color to the specified color value
; Syntax.........: _GDI_SetBkColor($hDC, $iColor)
; Parameters ....: $hDC         - Handle to the device context
;                  $iColor      - Specifies the new background color
; Return values .: Success      - The previous background color
;                  Failure      - 0xFFFF
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ SetBkColor
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_SetBkColor($hDC, $iColor)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "SetBkColor", "ptr", $hDC, "int", $iColor)
	If @error Then Return SetError(@error, 0, 0xFFFF)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetBkColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetBkMode
; Description ...: Sets the background mix mode of the specified device context
; Syntax.........: _GDI_SetBkMode($hDC, $iBkMode)
; Parameters ....: $hDC - Handle to device context
;                  $iBkMode - Specifies the background mix mode. This parameter can be one of the following values.
;                  |OPAQUE - Background is filled with the current background color before the text, hatched brush, or pen is drawn.
;                  |TRANSPARENT - Background remains untouched.
; Return values .: Success      - Value specifies the previous background mix mode.
;                  Failure      - 0
; Author ........: Zedna
; Modified.......: Prog@ndy
; Remarks .......: The background mix mode is used with text, hatched brushes, and pen styles that are not solid lines.
;                  The SetBkMode function affects the line styles for lines drawn using a pen created by the CreatePen function.
;                  SetBkMode does not affect lines drawn using a pen created by the ExtCreatePen function.
;                  The $iBkMode parameter can also be set to driver-specific values. GDI passes such values to the device driver and otherwise ignores them.
; Related .......: _GDI_GetBkMode, _GDI_DrawText, _GDI_CreatePen, _GDI_SelectObject
; Link ..........; @@MsdnLink@@ SetBkMode
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_SetBkMode($hDC, $iBkMode)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SetBkMode", "ptr", $hDC, "int", $iBkMode)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetBkMode

;===============================================================================
;
; Function Name:   _GDI_SetWindowRgn()
; Description::    Applies a generated region to a window handle returned by GUICreate
; Parameter(s):    $h_win - window handle
;                  $rgn - The region returned by any Create..Rgn function
;                  $bRedraw - Specifies whether the window should be redrawn
; Requirement(s):
; Return Value(s): None
; Author(s):       Larry
;
;===============================================================================
;

Func _GDI_SetWindowRgn($h_win, $rgn,$bRedraw=1)
	Local $aResult = DllCall($__GDI_user32dll, "int", "SetWindowRgn", "hwnd", $h_win, "ptr", $rgn, "int", $bRedraw)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]<>0
EndFunc   ;==>_GDI_SetWindowRgn

#EndRegion
;*************************************************************
