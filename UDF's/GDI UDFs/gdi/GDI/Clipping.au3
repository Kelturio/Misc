#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region					Clipping

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ExcludeClipRect
; Description ...: Creates a new clipping region that consists of the existing clipping region minus the specified rectangle.
; Syntax.........: _GDI_ExcludeClipRect($hdc, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect)
; Parameters ....: $hdc          - [in] Handle to the device context.
;                  $nLeftRect    - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the rectangle.
;                  $nTopRect     - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the rectangle.
;                  $nRightRect   - [in] Specifies the x-coordinate, in logical units, of the lower-right corner of the rectangle.
;                  $nBottomRect  - [in] Specifies the y-coordinate, in logical units, of the lower-right corner of the rectangle.
; Return values .: Success      - nonzero, specifies the new clipping region's complexity:
;                                 $NULLREGION    - Region is empty.
;                                 $SIMPLEREGION  - Region is a single rectangle.
;                                 $COMPLEXREGION - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The lower and right edges of the specified rectangle are not excluded from the clipping region.
; Related .......: 
; Link ..........; @@MsdnLink@@ ExcludeClipRect
; Example .......;
; ===============================================================================================================================
Func _GDI_ExcludeClipRect($hdc, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "ExcludeClipRect", "ptr", $hdc, "int", $nLeftRect, "int", $nTopRect, "int", $nRightRect, "int", $nBottomRect)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ExtSelectClipRgn
; Description ...: Combines the specified region with the current clipping region using the specified mode.
; Syntax.........: _GDI_ExtSelectClipRgn($hdc, $hrgn, $fnMode)
; Parameters ....: $hdc     - [in] Handle to the device context.
;                  $hrgn    - [in] Handle to the region to be selected. This handle can only be NULL when the RGN_COPY mode is specified.
;                  $fnMode  - [in] Specifies the operation to be performed. It must be one of the following values.
;                             $RGN_AND   - The new clipping region combines the overlapping areas of the current clipping region
;                                            and the region identified by hrgn.
;                             $RGN_COPY  - The new clipping region is a copy of the region identified by hrgn. This is identical to 
;                                            SelectClipRgn. If the region identified by hrgn is NULL, the new clipping region is the 
;                                            default clipping region (the default clipping region is a null region).
;                             $RGN_DIFF  - The new clipping region combines the areas of the current clipping region with those areas 
;                                            excluded from the region identified by hrgn.
;                             $RGN_OR    - The new clipping region combines the current clipping region and the region identified by hrgn.
;                             $RGN_XOR   - The new clipping region combines the current clipping region and the region identified by hrgn
;                                            but excludes any overlapping areas.
; Return values .: Success      - nonzero, specifies the new clipping region's complexity:
;                                 $NULLREGION    - Region is empty.
;                                 $SIMPLEREGION  - Region is a single rectangle.
;                                 $COMPLEXREGION - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: If an error occurs when this function is called, the previous clipping region for the specified device 
;                    context is not affected.
;                  The ExtSelectClipRgn function assumes that the coordinates for the specified region are specified in device units.
;                  Only a copy of the region identified by the hrgn parameter is used. The region itself can be reused after 
;                    this call or it can be deleted.
; Related .......: 
; Link ..........; @@MsdnLink@@ ExtSelectClipRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_ExtSelectClipRgn($hdc, $hrgn, $fnMode)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "ExtSelectClipRgn", "ptr", $hdc, "ptr", $hrgn, "int", $fnMode)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetClipBox
; Description ...: Retrieves the dimensions of the tightest bounding rectangle that can be drawn around the current visible area
;                    on the device. The visible area is defined by the current clipping region or clip path, as well as any
;                    overlapping windows.
; Syntax.........: _GDI_GetClipBox($hdc, $lprc)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $lprc  - [out] Pointer to a RECT structure that is to receive the rectangle dimensions, in logical units.
; Return values .: Success      - specifies the clipping box's complexity:
;                                 $NULLREGION    - Region is empty.
;                                 $SIMPLEREGION  - Region is a single rectangle.
;                                 $COMPLEXREGION - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: GetClipBox returns logical coordinates based on the given device context.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetClipBox
; Example .......;
; ===============================================================================================================================
Func _GDI_GetClipBox($hdc, $lprc)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetClipBox", "ptr", $hdc, "ptr", $lprc)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetClipRgn
; Description ...: Retrieves a handle identifying the current application-defined clipping region for the specified device context.
; Syntax.........: _GDI_GetClipRgn($hdc, $hrgn)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $hrgn  - [in] Handle to an existing region before the function is called. After the function returns, 
;                                this parameter is a handle to a copy of the current clipping region.
; Return values .: Success      - if there is a clipping region: 1
;                                 if there is no Clipping region: 0
;                  Failure      - -1
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: An application-defined clipping region is a clipping region identified by the SelectClipRgn function.
;                    It is not a clipping region created when the application calls the BeginPaint function.
;                  If the function succeeds, the hrgn parameter is a handle to a copy of the current clipping region. 
;                    Subsequent changes to this copy will not affect the current clipping region.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetClipRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_GetClipRgn($hdc, $hrgn)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetClipRgn", "ptr", $hdc, "ptr", $hrgn)
	If @error Then Return SetError(@error,0,-1)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetMetaRgn
; Description ...: retrieves the current metaregion for the specified device context.
; Syntax.........: _GDI_GetMetaRgn($hdc, $hrgn)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $hrgn  - [in] Handle to an existing region before the function is called. After the function returns,
;                                this parameter is a handle to a copy of the current metaregion.
; Return values .: Success      - nonzero (true)
;                  Failure      - 0 (False)
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: If the function succeeds, hrgn is a handle to a copy of the current metaregion. 
;                    Subsequent changes to this copy will not affect the current metaregion.
;                  The current clipping region of a device context is defined by the intersection of its 
;                    clipping region and its metaregion.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetMetaRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_GetMetaRgn($hdc, $hrgn)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetMetaRgn",  "ptr", $hdc, "ptr", $hrgn)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetRandomRgn
; Description ...: copies the system clipping region of a specified device context to a specific region.
; Syntax.........: _GDI_GetRandomRgn($hdc, $hrgn, $iNum = $SYSRGN)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $hrgn  - [in] Handle to a region. Before the function is called, this identifies an existing region. 
;                                 After the function returns, this identifies a copy of the current system region.
;                                 The old region identified by hrgn is overwritten.
;                  $iNum  - [in] This parameter must be SYSRGN.
; Return values .: Success      - 1 or: If the region to be retrieved is NULL, the return value is 0. 
;                  Failure      - -1
;                  If the function fails or the region to be retrieved is NULL, hrgn is not initialized.
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: When using the SYSRGN flag, note that the system clipping region might not be current because of window 
;                    movements. Nonetheless, it is safe to retrieve and use the system clipping region within the
;                    BeginPaint-EndPaint block during WM_PAINT processing. In this case, the system region is the intersection
;                    of the update region and the current visible area of the window. Any window movement following the return 
;                    of GetRandomRgn and before EndPaint will result in a new WM_PAINT message. Any other use of the SYSRGN flag 
;                    may result in painting errors in your application.
;                  Windows NT/2000/XP: The region returned is in screen coordinates.
;                  Windows 95/98/Me: The region returned is in window coordinates.
; Related .......: 
; Link ..........; @@MsdnLink@@ GetRandomRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_GetRandomRgn($hdc, $hrgn, $iNum = $SYSRGN)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "GetRandomRgn",  "ptr", $hdc, "ptr", $hrgn, "INT", $iNum)
	If @error Then Return SetError(@error,0,-1)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_IntersectClipRect
; Description ...: creates a new clipping region from the intersection of the current clipping region and the specified rectangle.
; Syntax.........: _GDI_IntersectClipRect($hdc, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect)
; Parameters ....: $hdc          - [in] Handle to the device context.
;                  $nLeftRect    - [in] Specifies the x-coordinate, in logical units, of the upper-left corner of the rectangle.
;                  $nTopRect     - [in] Specifies the y-coordinate, in logical units, of the upper-left corner of the rectangle.
;                  $nRightRect   - [in] Specifies the x-coordinate, in logical units, of the lower-right corner of the rectangle.
;                  $nBottomRect  - [in] Specifies the y-coordinate, in logical units, of the lower-right corner of the rectangle.
; Return values .: Success      - specifies the new clipping region's type:
;                                 $NULLREGION    - Region is empty.
;                                 $SIMPLEREGION  - Region is a single rectangle.
;                                 $COMPLEXREGION - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The lower and right-most edges of the given rectangle are excluded from the clipping region.
; Related .......: 
; Link ..........; @@MsdnLink@@ IntersectClipRect
; Example .......;
; ===============================================================================================================================
Func _GDI_IntersectClipRect($hdc, $nLeftRect, $nTopRect, $nRightRect, $nBottomRect)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "IntersectClipRect", "ptr", $hdc, "int", $nLeftRect, "int", $nTopRect, "int", $nRightRect, "int", $nBottomRect)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_OffsetClipRgn
; Description ...: moves the clipping region of a device context by the specified offsets.
; Syntax.........: _GDI_OffsetClipRgn($hdc, $nXOffset, $nYOffset)
; Parameters ....: $hdc       - [in] Handle to the device context.
;                  $nXOffset  - [in] Specifies the number of logical units to move left or right.
;                  $nYOffset  - [in] Specifies the number of logical units to move up or down.
; Return values .: Success      - specifies the new region's complexity:
;                                 $NULLREGION    - Region is empty.
;                                 $SIMPLEREGION  - Region is a single rectangle.
;                                 $COMPLEXREGION - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........; @@MsdnLink@@ OffsetClipRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_OffsetClipRgn($hdc, $nXOffset, $nYOffset)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "OffsetClipRgn",  "ptr", $hdc, "int", $nXOffset, "int", $nYOffset)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PtVisible
; Description ...: determines whether the specified point is within the clipping region of a device context.
; Syntax.........: _GDI_PtVisible($hdc, $X, $Y)
; Parameters ....: $hdc  - [in] Handle to the device context.
;                  $X    - [in] Specifies the x-coordinate, in logical units, of the point.
;                  $Y    - [in] Specifies the y-coordinate, in logical units, of the point.
; Return values .: Success      - TRUE (1): the specified point is within the clipping region of the device context.
;                  Failure      - FALSE (0): the specified point is not within the clipping region of the device context.
;                                 -1 : the hdc is not valid
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........; @@MsdnLink@@ PtVisible
; Example .......;
; ===============================================================================================================================
Func _GDI_PtVisible($hdc, $X, $Y)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "PtVisible", "ptr", $hdc, "int", $X, "int", $Y)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_RectVisible
; Description ...: determines whether any part of the specified rectangle lies within the clipping region of a device context.
; Syntax.........: _GDI_RectVisible($hdc, $lprc)
; Parameters ....: $hdc   - [in] Handle to the device context.
;                  $lprc  - [in] Pointer to a RECT structure that contains the logical coordinates of the specified rectangle.
; Return values .: TRUE (1): the current transform does not have a rotation and the rectangle lies within the clipping region
;                  FALSE(0): the current transform does not have a rotation and the rectangle does not lie within the clipping region
;                     2    : the current transform has a rotation and the rectangle lies within the clipping region
;                     1    : the current transform has a rotation and the rectangle does not lie within the clipping region
;                  All other return values are considered error codes. If the any parameter is not valid, the return value is undefined.
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........; @@MsdnLink@@ RectVisible
; Example .......;
; ===============================================================================================================================
Func _GDI_RectVisible($hdc, $lprc)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "RectVisible", "ptr", $hdc, "ptr", $lprc)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SelectClipPath
; Description ...: selects the current path as a clipping region for a device context, combining the new region with any 
;                    existing clipping region using the specified mode.
; Syntax.........: _GDI_SelectClipPath($hdc, $iMode)
; Parameters ....: $hdc    - [in] Handle to the device context of the path.
;                  $iMode  - [in] Specifies the way to use the path. This parameter can be one of the following values.
;                               $RGN_AND    - The new clipping region includes the intersection (overlapping areas) of the 
;                                               current clipping region and the current path.
;                               $RGN_COPY   - The new clipping region is the current path.
;                               $RGN_DIFF   - The new clipping region includes the areas of the current clipping region with 
;                                               those of the current path excluded.
;                               $RGN_OR     - The new clipping region includes the union (combined areas) of the current 
;                                               clipping region and the current path.
;                               $RGN_XOR    - The new clipping region includes the union of the current clipping region and 
;                                               the current path but without the overlapping areas.
; Return values .: Success      - nonzero (True)
;                  Failure      - 0 (False)
;                    Windows NT/2000/XP:GetLastError may return one of the following error codes:
;                      $ERROR_CAN_NOT_COMPLETE, $ERROR_INVALID_PARAMETER, $ERROR_NOT_ENOUGH_MEMORY
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The device context identified by the hdc parameter must contain a closed path.
; Related .......: 
; Link ..........; @@MsdnLink@@ SelectClipPath
; Example .......;
; ===============================================================================================================================
Func _GDI_SelectClipPath($hdc, $iMode)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SelectClipPath", "ptr", $hdc, "int", $iMode)
	If @error Then Return SetError(@error,0,0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SelectClipRgn
; Description ...: Applies a generated region as the current clipping region for the specified device context. 
; Syntax.........: _GDI_SelectClipRgn($h_win, $rgn)
; Parameters ....: $h_win - window handle
;                  $rgn - The region returned by any Create..Rgn function
; Return values .: Success      - The return value specifies the region's complexity and can be one of the following values.
;                                 $NULLREGION     - Region is empty.
;                                 $SIMPLEREGION   - Region is a single rectangle.
;                                 $COMPLEXREGION  - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: Only a copy of the selected region is used. The region itself can be selected for any number of other 
;                    device contexts or it can be deleted.
;                  The SelectClipRgn function assumes that the coordinates for a region are specified in device units.
;                  To remove a device-context's clipping region, specify a NULL region handle.
; Related .......: 
; Link ..........; @@MsdnLink@@ SelectClipRgn
; Example .......;
; ===============================================================================================================================
Func _GDI_SelectClipRgn($h_win, $rgn)
	Local $aResult = DllCall("user32.dll", "long", "SelectClipRgn", "hwnd", $h_win, "ptr", $rgn)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]
EndFunc   ;==>_GDI_SelectClipRgn

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetMetaRgn
; Description ...: intersects the current clipping region for the specified device context with the current metaregion and 
;                    saves the combined region as the new metaregion for the specified device context.
;                    The clipping region is reset to a null region.
; Syntax.........: _GDI_SetMetaRgn($hdc)
; Parameters ....: $hdc   - [in] Handle to the device context.
; Return values .: Success      - specifies the new clipping region's complexity:
;                                 $NULLREGION     - Region is empty.
;                                 $SIMPLEREGION   - Region is a single rectangle.
;                                 $COMPLEXREGION  - Region is more than one rectangle.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......: 
; Remarks .......: The current clipping region of a device context is defined by the intersection of its 
;                    clipping region and its metaregion.
;                  The SetMetaRgn function should only be called after an application's original device context was 
;                    saved by calling the SaveDC function.
; Related .......: 
; Link ..........; @@MsdnLink@@ 
; Example .......;
; ===============================================================================================================================
Func _GDI_SetMetaRgn($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SetMetaRgn",  "ptr", $hdc)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]
EndFunc

#EndRegion
;*************************************************************