#include-once
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.12 (beta)
 Author:         Prog@ndy, Greenhorn

 Script Function:
	GDI32 UDF - Coordinate Spaces and Transformations

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region		Coordinate Spaces and Transformations
; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ClientToScreen
; Description ...: Converts the client coordinates of a specified point to screen coordinates
; Syntax.........: _GDI_ClientToScreen($hWnd, ByRef $tPoint)
; Parameters ....: $hWnd        - Identifies the window that will be used for the conversion
;                  $tPoint      - $tagPOINT structure that contains the client coordinates to be converted
; Return values .: If the function succeeds, the return value is nonzero.
;                  If the function fails, the return value is zero. 
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: The function replaces the client coordinates in the  $tagPOINT  structure  with  the  screen  coordinates.  The
;                  screen coordinates are relative to the upper-left corner of the screen.
; Related .......: _GDI_ScreenToClient, $tagPOINT
; Link ..........; @@MsdnLink@@ ClientToScreen
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_ClientToScreen($hWnd, ByRef $tPoint)
	Local $pPoint, $aResult

	$pPoint = DllStructGetPtr($tPoint)
	$aResult = DllCall($__GDI_user32dll, "int", "ClientToScreen", "hwnd", $hWnd, "ptr", $pPoint)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError($aResult[0]=False, 0, $aResult[0])
EndFunc   ;==>_GDI_ClientToScreen

;===============================================================================
;
; Function Name:   _GDI_CombineTransform
; Description::    The CombineTransform function concatenates two world-space to page-space transformations. 
; Parameter(s):    $xformResult - Pointer to an XFORM structure that receives the combined transformation. 
;                  $xform1      - Pointer to an XFORM structure that specifies the first transformation. 
;                  $xform2      - Pointer to an XFORM structure that specifies the second transformation.
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_CombineTransform (ByRef $xformResult, ByRef $xform1,ByRef  $xform2)
	Local $lpxform1=DllStructGetPtr($xform1),$lpxform2=DllStructGetPtr($xform2),$lpxformResult=DllStructGetPtr($xformResult)
	If IsPtr($xform1) Then $lpxform1 = $xform1
	If IsPtr($xform2) Then $lpxform2 = $xform2
	If IsPtr($xformResult) Then $lpxformResult = $xformResult
	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'CombineTransform', _
											 'ptr', $lpxformResult, _
											 'ptr', $lpxform1, _
											 'ptr', $lpxform2)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_DPtoLP
; Description::    The DPtoLP function converts device coordinates into logical coordinates. 
;                    The conversion depends on the mapping mode of the device context, the 
;                    settings of the origins and extents for the window and viewport, and
;                    the world transformation. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $lpPoints - Pointer to an array of POINT structures. The x- and y-coordinates contained in each POINT structure will be transformed.
;                  $nCount   - Specifies the number of points in the array. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_DPtoLP ($hdc, ByRef $Points, $nCount)
	Local $lpPoints = DllStructGetPtr($Points)
	If IsPtr($Points) Then $lpPoints = $Points

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'DPtoLP', _
											'ptr', $hdc, _ ;// handle to device context
											'ptr', $lpPoints, _ ; // array of points
											'int', $nCount) ;         // count of points in array

	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc



;===============================================================================
;
; Function Name:   _GDI_GetCurrentPositionEx
; Description::    The GetCurrentPositionEx function retrieves the current position in logical coordinates. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $lpPoint  - Pointer to a POINT structure that receives the logical coordinates of the current position. 
; Requirement(s):  
; Return Value(s): Success: nonzero
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetCurrentPositionEx ($hdc,ByRef $Point)
	Local $lpPoint = DllStructGetPtr($Point)
	If IsPtr($Point) Then $lpPoint = $Point

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetCurrentPositionEx', _
											 'ptr', $hdc, _
											 'ptr', $lpPoint)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_GetGraphicsMode
; Description::    The GetGraphicsMode function retrieves the current graphics mode for the specified device context. 
; Parameter(s):    $hdc      - Handle to the device context. 
; Requirement(s):  
; Return Value(s): If the function succeeds, the return value is the current graphics mode. 
;                  It can be one of the following values.
;                   $GM_COMPATIBLE - The current graphics mode is the compatible graphics mode, 
;                                     a mode that is compatible with 16-bit Windows. In this 
;                                     graphics mode, an application cannot set or modify the world
;                                     transformation for the specified device context. The compatible
;                                     graphics mode is the default graphics mode.
;                   $GM_ADVANCED   - Windows NT/2000/XP: The current graphics mode is the advanced 
;                                     graphics mode, a mode that allows world transformations. 
;                                     In this graphics mode, an application can set or modify the 
;                                     world transformation for the specified device context.
;                   Windows 95/98/Me: The $GM_ADVANCED value is not supported.
;                  Otherwise, the return value is zero. 
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetGraphicsMode ($hdc)

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetGraphicsMode', _
											 'ptr', $hdc)
	If @error Then Return SetError(@error, 0, 0)
	Return $aRes[0]

EndFunc
;===============================================================================
;
; Function Name:   _GDI_GetMapMode
; Description::    The GetMapMode function retrieves the current mapping mode. 
; Parameter(s):    $hdc      - Handle to the device context. 
; Requirement(s):  
; Return Value(s): If the function succeeds, the return value specifies the mapping mode.
;                  It can be one of the following values.
;                    | $MM_ANISOTROPIC  - Logical units are mapped to arbitrary units with arbitrarily scaled axes.
;                                         Use the SetWindowExtEx and SetViewportExtEx functions to specify the units, orientation, and scaling.
;                    | $MM_HIENGLISH    - Each logical unit is mapped to 0.001 inch. Positive x is to the right; positive y is up.
;                    | $MM_HIMETRIC     - Each logical unit is mapped to 0.01 millimeter. Positive x is to the right; positive y is up.
;                    | $MM_ISOTROPIC    - Logical units are mapped to arbitrary units with equally scaled axes; that is, one unit along 
;                                           the x-axis is equal to one unit along the y-axis. Use the SetWindowExtEx and SetViewportExtEx 
;                                           functions to specify the units and the orientation of the axes. Graphics device interface (GDI) 
;                                           makes adjustments as necessary to ensure the x and y units remain the same size (When the window 
;                                           extent is set, the viewport will be adjusted to keep the units isotropic).
;                    | $MM_LOENGLISH    - Each logical unit is mapped to 0.01 inch. Positive x is to the right; positive y is up.
;                    | $MM_LOMETRIC     - Each logical unit is mapped to 0.1 millimeter. Positive x is to the right; positive y is up.
;                    | $MM_TEXT         - Each logical unit is mapped to one device pixel. Positive x is to the right; positive y is down.
;                    | $MM_TWIPS        - Each logical unit is mapped to one twentieth of a printer's point (1/1440 inch, also called a twip). 
;                                           Positive x is to the right; positive y is up.
;                  Otherwise, the return value is zero. 
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetMapMode ($hdc)

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetMapMode', _
											 'ptr', $hdc)
	If @error Then Return SetError(@error, 0, 0)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_GetViewportExtEx
; Description::    The GetViewportExtEx function retrieves the x-extent and y-extent of the current viewport for the specified device context. 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $lpSize  - Pointer to a SIZE structure that receives the x- and y-extents, in device units. 
; Requirement(s):  
; Return Value(s): Success: nonzero
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetViewportExtEx ($hdc,ByRef $Size)
	Local $lpSize = DllStructGetPtr($Size)
	If IsPtr($Size) Then $lpSize = $Size

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetViewportExtEx', _
											 'ptr', $hdc, _
											 'ptr', $lpSize)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_GetViewportOrgEx
; Description::    The GetViewportOrgEx function retrieves the x-coordinates and y-coordinates of the viewport origin for the specified device context. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $lpPoint  - Pointer to a POINT structure that receives the coordinates of the origin, in device units. 
; Requirement(s):  
; Return Value(s): Success: nonzero
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetViewportOrgEx ($hdc,ByRef $Point)
	Local $lpPoint = DllStructGetPtr($Point)
	If IsPtr($Point) Then $lpPoint = $Point

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetViewportOrgEx', _
											 'ptr', $hdc, _
											 'ptr', $lpPoint)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_GetWindowExtEx
; Description::    This function retrieves the x-extent and y-extent of the window for the specified device context. 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $lpSize  - Pointer to a SIZE structure that receives the x- and y-extents in page-space units, that is, logical units. 
; Requirement(s):  
; Return Value(s): Success: nonzero
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetWindowExtEx ($hdc,ByRef $Size)
	Local $lpSize = DllStructGetPtr($Size)
	If IsPtr($Size) Then $lpSize = $Size

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetWindowExtEx', _
											 'ptr', $hdc, _
											 'ptr', $lpSize)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_GetWindowOrgEx
; Description::    The GetWindowOrgEx function retrieves the x-coordinates and y-coordinates of the window origin for the specified device context. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $lpPoint  - Pointer to a POINT structure that receives the coordinates, in logical units, of the window origin. 
; Requirement(s):  
; Return Value(s): Success: nonzero
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetWindowOrgEx ($hdc,ByRef $Point)
	Local $lpPoint = DllStructGetPtr($Point)
	If IsPtr($Point) Then $lpPoint = $Point

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetWindowOrgEx', _
											 'ptr', $hdc, _
											 'ptr', $lpPoint)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_GetWorldTransform
; Description::    The GetWorldTransform function retrieves the current world-space to page-space transformation. 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $lpXform - Pointer to an XFORM structure that receives the current world-space to page-space transformation. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_GetWorldTransform ($hdc, ByRef $XFORM)
	Local $lpXFORM = DllStructGetPtr($XFORM)
	If IsPtr($XFORM) Then $lpXFORM = $XFORM

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'GetWorldTransform', _
											 'ptr', $hdc, _      ; // handle to device context
											 'ptr', $lpXform ) ; // transformation data

	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_LPtoDP
; Description::    The LPtoDP function converts logical coordinates into device coordinates. 
;                    The conversion depends on the mapping mode of the device context, the 
;                    settings of the origins and extents for the window and viewport, 
;                    and the world transformation. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $lpPoints - Pointer to an array of POINT structures. The x- and y-coordinates contained in each POINT structure will be transformed.
;                  $nCount   - Specifies the number of points in the array. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_LPtoDP ($hdc, ByRef $Points, $nCount)
	Local $lpPoints = DllStructGetPtr($Points)
	If IsPtr($Points) Then $lpPoints = $Points

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'LPtoDP', _
											'ptr', $hdc, _ ;// handle to device context
											'ptr', $lpPoints, _ ; // array of points
											'int', $nCount) ;         // count of points in array

	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_MapWindowPoints
; Description::    The MapWindowPoints function converts (maps) a set of points from 
;                    a coordinate space relative to one window to a coordinate space
;                    relative to another window. 
; Parameter(s):    $hWndFrom - Handle to the window from which points are converted. 
;                               If this parameter is NULL or HWND_DESKTOP, the points 
;                               are presumed to be in screen coordinates. 
;                  $hWndTo   - Handle to the window to which points are converted. 
;                               If this parameter is NULL or HWND_DESKTOP, the points 
;                               are converted to screen coordinates. 
;                  $Points - Pointer to an array of POINT structures that contain 
;                               the set of points to be converted. The points are in 
;                               device units. This parameter can also point to a RECT
;                               structure, in which case the cPoints parameter should 
;                               be set to 2. 
;                  $cPoints  - Specifies the number of POINT structures in the array 
;                               pointed to by the lpPoints parameter. 
; Requirement(s):  
; Return Value(s): If the function succeeds, the low-order word of the return value is
;                   the number of pixels added to the horizontal coordinate of each 
;                   source point in order to compute the horizontal coordinate of each
;                   destination point; the high-order word is the number of pixels added 
;                   to the vertical coordinate of each source point in order to compute
;                   the vertical coordinate of each destination point. 
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_MapWindowPoints ($hWndFrom, $hWndTo, ByRef $Points, $cPoints)
	Local $lpPoints = DllStructGetPtr($Points)
	If IsPtr($Points) Then $lpPoints = $Points

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'MapWindowPoints', _
                                            'HWND', $hWndFrom, _ ;     // handle to source window
                                            'HWND', $hWndTo,  _ ;     // handle to destination window
                                            'ptr', $lpPoints, _ ; // array of points to map
                                            'int', $cPoints) ;         // count of points in array

	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_ModifyWorldTransform
; Description::    The MapWindowPoints function converts (maps) a set of points from 
;                    a coordinate space relative to one window to a coordinate space
;                    relative to another window. 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $lpXform - Pointer to an XFORM structure used to modify the world 
;                              transformation for the given device context. 
;                  $iMode   - Specifies how the transformation data modifies the current 
;                              world transformation. This parameter must be one of the 
;                              following values
;                              $MWT_IDENTITY      - Resets the current world transformation 
;                                                   by using the identity matrix. If this mode 
;                                                   is specified, the XFORM structure pointed 
;                                                   to by lpXform is ignored. 
;                              $MWT_LEFTMULTIPLY  - Multiplies the current transformation by
;                                                   the data in the XFORM structure. (The data in
;                                                   the XFORM structure becomes the left multiplicand,
;                                                   and the data for the current transformation 
;                                                   becomes the right multiplicand.) 
;                              $MWT_RIGHTMULTIPLY - Multiplies the current transformation by 
;                                                   the data in the XFORM structure. (The data 
;                                                   in the XFORM structure becomes the right
;                                                   multiplicand, and the data for the current 
;                                                   transformation becomes the left multiplicand.) 
; Requirement(s):  
; Return Value(s): If the function succeeds, the return value is nonzero.
;                  Error: zero
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_ModifyWorldTransform ($hdc, ByRef $XFORM, $iMode)
	Local $lpXFORM = DllStructGetPtr($XFORM)
	If IsPtr($XFORM) Then $lpXFORM = $XFORM

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'ModifyWorldTransform', _
                                              'ptr', $hdc,  _ ;             // handle to device context
                                              'ptr', $lpXFORM, _ ; // transformation data
                                              'DWORD', $iMode) ;           // modification mode


	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;----------------------------------------------
; MISSING FUNCTIONS
;----------------------------------------------

;===============================================================================
;
; Function Name:   _GDI_OffsetWindowOrgEx
; Description::    The OffsetWindowOrgEx function modifies the window origin for a device context using the specified horizontal and vertical offsets. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $nXOffset - Specifies the horizontal offset, in logical units. 
;                  $nYOffset - Specifies the vertical offset, in logical units. 
;                  $lpPoint  - Pointer to a POINT structure. The logical coordinates of the previous window origin are placed in this structure. If lpPoint is NULL, the previous origin is not returned. 
; Requirement(s):  
; Return Value(s): Success: nonzero
;                  Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_OffsetWindowOrgEx ($hdc, $nXOffset, $nYOffset,ByRef $Point)
	Local $lpPoint = DllStructGetPtr($Point)
	If IsPtr($Point) Then $lpPoint = $Point

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'OffsetWindowOrgEx', _
											 'ptr', $hdc, _
											 'int', $nXOffset, _
											 'int', $nYOffset, _
											 'ptr', $lpPoint)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_SetMapMode
; Description::    The SetMapMode function sets the mapping mode of the specified device context. 
;                   The mapping mode defines the unit of measure used to transform page-space units 
;                   into device-space units, and also defines the orientation of the device's x and y axes. 
; Parameter(s):    $hdc       - Handle to the device context. 
;                  $fnMapMode - Specifies the new mapping mode. This parameter can be one of the following values.
;                    | $MM_ANISOTROPIC  - Logical units are mapped to arbitrary units with arbitrarily scaled axes.
;                                         Use the SetWindowExtEx and SetViewportExtEx functions to specify the units, orientation, and scaling.
;                    | $MM_HIENGLISH    - Each logical unit is mapped to 0.001 inch. Positive x is to the right; positive y is up.
;                    | $MM_HIMETRIC     - Each logical unit is mapped to 0.01 millimeter. Positive x is to the right; positive y is up.
;                    | $MM_ISOTROPIC    - Logical units are mapped to arbitrary units with equally scaled axes; that is, one unit along 
;                                           the x-axis is equal to one unit along the y-axis. Use the SetWindowExtEx and SetViewportExtEx 
;                                           functions to specify the units and the orientation of the axes. Graphics device interface (GDI) 
;                                           makes adjustments as necessary to ensure the x and y units remain the same size (When the window 
;                                           extent is set, the viewport will be adjusted to keep the units isotropic).
;                    | $MM_LOENGLISH    - Each logical unit is mapped to 0.01 inch. Positive x is to the right; positive y is up.
;                    | $MM_LOMETRIC     - Each logical unit is mapped to 0.1 millimeter. Positive x is to the right; positive y is up.
;                    | $MM_TEXT         - Each logical unit is mapped to one device pixel. Positive x is to the right; positive y is down.
;                    | $MM_TWIPS        - Each logical unit is mapped to one twentieth of a printer's point (1/1440 inch, also called a twip). 
;                                           Positive x is to the right; positive y is up.
; Requirement(s):  
; Return Value(s): 
; Author(s):       Greenhorn
;
;===============================================================================
;
Func _GDI_SetMapMode ($hdc, $fnMapMode)

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'SetMapMode', _
											 'ptr', $hdc, _
											 'int', $fnMapMode)
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_SetViewportExtEx
; Description::    The SetViewportExtEx function sets the horizontal and vertical 
;                   extents of the viewport for a device context by using the specified values. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $nXExtent - Specifies the horizontal extent, in device units, of the viewport. 
;                  $nYExtent - Specifies the vertical extent, in device units, of the viewport. 
;                  $lpSize   - Pointer to a SIZE structure that receives the previous viewport extents,
;                                in device units. If lpSize is NULL, this parameter is not used. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_SetViewportExtEx ($hdc, $nXExtent, $nYExtent,ByRef $Size)
	Local $lpSize = DllStructGetPtr($Size)
	If IsPtr($Size) Then $lpSize = $Size
	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'SetViewportExtEx', _
											 'ptr', $hdc, _      ; // handle to device context
											 'int', $nXExtent, _ ; // new horizontal viewport extent
											 'int', $nYExtent, _ ; // new vertical viewport extent
											 'ptr', $lpSize)     ; // original viewport extent
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_SetViewportOrgEx
; Description::    The SetViewportOrgEx function specifies which device point maps to the window origin (0,0). 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $X       - Specifies the x-coordinate, in device units, of the new viewport origin. 
;                  $Y       - Specifies the y-coordinate, in device units, of the new viewport origin. 
;                  $lpPoint - Pointer to a POINT structure that receives the previous viewport origin, in device coordinates. If lpPoint is NULL, this parameter is not used. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_SetViewportOrgEx ($hdc, $X, $Y, ByRef $Point)
	Local $lpPoint = DllStructGetPtr($Point)
	If IsPtr($Point) Then $lpPoint = $Point

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'SetViewportOrgEx', _
											 'ptr', $hdc, _      ; // handle to device context
											 'int', $X, _        ; // new x-coordinate of viewport origin
											 'int', $Y, _        ; // new y-coordinate of viewport origin
											 'ptr', $lpPoint)    ; // original viewport origin
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_SetWindowExtEx
; Description::    The SetWindowExtEx function sets the horizontal and vertical extents
;                    of the window for a device context by using the specified values. 
; Parameter(s):    $hdc      - Handle to the device context. 
;                  $nXExtent - Specifies the window's horizontal extent in logical units. 
;                  $nYExtent - Specifies the window's vertical extent in logical units. 
;                  $lpSize   - Pointer to a SIZE structure that receives the previous window extents, 
;                                in logical units. If lpSize is NULL, this parameter is not used. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_SetWindowExtEx ($hdc, $nXExtent, $nYExtent, ByRef $Size)
	Local $lpSize = DllStructGetPtr($Size)
	If IsPtr($Size) Then $lpSize = $Size

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'SetWindowExtEx', _
											 'ptr', $hdc, _      ; // handle to device context
											 'int', $nXExtent, _ ; // new horizontal window extent
											 'int', $nYExtent, _ ; // new vertical window extent
											 'ptr', $lpSize)     ; // original viewport extent
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_SetWindowOrgEx
; Description::    The SetWindowOrgEx function specifies which window point maps to the viewport origin (0,0). 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $X       - Specifies the x-coordinate, in logical units, of the new window origin. 
;                  $Y       - Specifies the y-coordinate, in logical units, of the new window origin. 
;                  $lpPoint - Pointer to a POINT structure that receives the previous origin of the window, 
;                              in logical units. If lpPoint is NULL, this parameter is not used. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_SetWindowOrgEx ($hdc, $X, $Y, $lpPoint)

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'SetWindowOrgEx', _
											 'ptr', $hdc, _      ; // handle to device context
											 'int', $X, _        ; // new x-coordinate of window origin
											 'int', $Y, _        ; // new y-coordinate of window origin
											 'ptr', $lpPoint)    ; // original viewport origin
	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

;===============================================================================
;
; Function Name:   _GDI_SetWorldTransform
; Description::    The SetWorldTransform function sets a two-dimensional linear transformation 
;                    between world space and page space for the specified device context. This 
;                    transformation can be used to scale, rotate, shear, or translate graphics output. 
; Parameter(s):    $hdc     - Handle to the device context. 
;                  $lpXform - Pointer to an XFORM structure that contains the transformation data. 
; Requirement(s):  
; Return Value(s): Success: nonzero, Error: zero
; Author(s):       Greenhorn, Prog@ndy
;
;===============================================================================
;
Func _GDI_SetWorldTransform ($hdc, ByRef $XFORM)
	Local $lpXFORM = DllStructGetPtr($XFORM)
	If IsPtr($XFORM) Then $lpXFORM = $XFORM

	Local $aRes = DllCall ($__GDI_gdi32dll, 'int', 'SetWorldTransform', _
											 'ptr', $hdc, _      ; // handle to device context
											 'ptr', $lpXform ) ; // transformation data

	If @error Then Return SetError(@error, 0, False)
	Return $aRes[0]

EndFunc

#EndRegion
;*************************************************************