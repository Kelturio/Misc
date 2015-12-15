#include-once
#include "GDI\Macros.au3"
#include <StructureConstants.au3>
#include <WindowsConstants.au3>
#include <GDIConstants.au3>
#include <GDIStructures.au3>
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.13.13 (beta)
 Author:         Prog@ndy

 Script Function:
	Opens DLLs for GDI UDFs

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

Global $__GDI_gdi32dll = DllOpen('gdi32.dll')
Global $__GDI_user32dll = DllOpen('user32.dll')
Global $__GDI_msimg32dll = DllOpen('msimg32.dll')

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PointArCreate
; Description ...: Create a PointArray-structure
; Syntax.........: _GDI_PointArCreate($arPoints)
; Parameters ....: $arPoints - 2D-Array of X and Y Value of Points
; Return values .: Success      - $tagPOINT array structure
; Author ........: Prog@ndy
; Modified.......:
; ===============================================================================================================================
Func _GDI_PointArCreate(ByRef $arPoints)
	If UBound($arPoints, 2) <> 2 Then Return SetError(1)
	Local $Pointsstruct
	For $i = 1 To UBound($arPoints)
		$Pointsstruct &= "long[2];"
	Next
	Local $Points = DllStructCreate($Pointsstruct)
	For $i = 1 To UBound($arPoints)
		DllStructSetData($Points, $i, $arPoints[$i - 1][0], 1)
		DllStructSetData($Points, $i, $arPoints[$i - 1][1], 2)
	Next
	Return $Points
EndFunc   ;==>_GDI_PointArCreate


; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_PointStructRead
; Description ...: Create a PointArray-structure
; Syntax.........: _GDI_PointStructRead($sPoints)
; Parameters ....: $sPoints - $tagPOINT array structure
; Return values .: Success      - 2D-Array of X and Y Value of Points
; Author ........: Prog@ndy
; Modified.......:
; ===============================================================================================================================
Func _GDI_PointStructRead(ByRef $sPoints)
	If Not IsDllStruct($sPoints) Then Return SetError(1, 0, 0)
	Local $Points = Int(DllStructGetSize($sPoints)/DllStructGetSize(DllStructCreate("long[2]",1)))
	If $Points Then
		Local $arPoints[$Points][2]
		For $i = 1 To $Points
			$arPoints[$i-1][0] = DllStructGetData($sPoints, $i, 1)
			$arPoints[$i-1][1] = DllStructGetData($sPoints, $i, 2)
		Next
		Return $arPoints
	EndIf
	Return SetError(2,0,0)
EndFunc   ;==>_GDI_PointArCreate