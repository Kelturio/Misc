#include-once

#cs ----------------------------------------------------------------------------
	
	AutoIt Version: 3.2.13.12 (beta)
	Author:         Prog@ndy, Greenhorn
	
	Script Function:
	GDI functions for Printing and Print Spooler
	
#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region			Printing and Print Spooler

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_AbortDoc
; Description ...: Aborts a print job
; Syntax.........: _GDI_AbortDoc($hDC)
; Parameters ....: $hDC - Identifies the device context
; Author.........: Prog@ndy
; Return values .: If the function succeeds, the return value is greater than zero.
;                  If the function fails, the return value is SP_ERROR.
; ====================================================================================================
Func _GDI_AbortDoc($hDC)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "AbortDoc", "ptr", $hDC)
	Return $aResult[0]
EndFunc   ;==>_GDI_AbortDoc

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_StartDoc
; Description ...: Starts a print job
; Syntax.........: _GDI_StartDoc($hDC, $tDocInfo)
; Parameters ....: $hDC - Identifies the device context
;                  $tDocInfo - $tagDOCINFO structure that specifies document info
; Author.........: Prog@ndy
; Return values .: Success - print job identifier for the document
; ====================================================================================================
Func _GDI_StartDoc($hDC, ByRef $tDocInfo)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "StartDocW", "ptr", $hDC, "ptr", DllStructGetPtr($tDocInfo))
	Return $aResult[0]
EndFunc   ;==>_GDI_StartDoc

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_EndDoc
; Description ...: Ends a print job
; Syntax.........: _GDI_EndDoc($hDC)
; Parameters ....: $hDC - Identifies the device contex
; Author.........: Prog@ndy
; Return values .: Success - return value greater than zero
; ====================================================================================================
Func _GDI_EndDoc($hDC)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "EndDoc", "ptr", $hDC)
	Return $aResult[0]
EndFunc   ;==>_GDI_EndDoc

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_StartPage
; Description ...: Prepares the printer driver to accept data
; Syntax.........: _GDI_StartPage($hDC)
; Parameters ....: $hDC - Identifies the device contex
; Author.........: Prog@ndy
; Return values .: Success - return value greater than zero
; ====================================================================================================
Func _GDI_StartPage($hDC)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "StartPage", "ptr", $hDC)
	Return $aResult[0]
EndFunc   ;==>_GDI_StartPage

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_EndPage
; Description ...: Notifies the device that the application has finished writing to a page
; Syntax.........: _GDI_EndPage($hDC)
; Parameters ....: $hDC - Identifies the device contex
; Author.........: Prog@ndy
; Return values .: Success - return value greater than zero
; ====================================================================================================
Func _GDI_EndPage($hDC)
	Local $aResult
	$aResult = DllCall($__GDI_gdi32dll, "long", "EndPage", "ptr", $hDC)
	Return $aResult[0]
EndFunc   ;==>_GDI_EndPage

;/*************************************************************************
#Region Print DLG
; Prog@ndy
Func _PrintUDF_CreateTextStruct($text)
	Local $s = DllStructCreate("wchar[" & StringLen($text) + 1 & "]")
	DllStructSetData($s, 1, $text)
	Return $s
EndFunc   ;==>_PrintUDF_CreateTextStruct

; Prog@ndy
Func _GDI_PrintDlg($hWnd = 0, $pd = Default)
	If Not IsDllStruct($pd) Then
		$pd = DllStructCreate($tagPD)
		DllStructSetData($pd, "lStructSize", DllStructGetSize($pd))
		DllStructSetData($pd, "hwndOwner", $hWnd)
		DllStructSetData($pd, "Flags", BitOR($PD_ALLPAGES, $PD_COLLATE, $PD_RETURNDC, $PD_NOSELECTION, $PD_NOPAGENUMS, $PD_USEDEVMODECOPIESANDCOLLATE))
	EndIf
	If $hWnd Then DllStructSetData($pd, "hwndOwner", $hWnd)
	Local $ret = DllCall("comdlg32.dll", "int", "PrintDlgW", "ptr", DllStructGetPtr($pd))
	If Not IsArray($ret) Or $ret[0] = 0 Then Return SetError(1, 0, 0)

	Return $pd
EndFunc   ;==>_GDI_PrintDlg

; Prog@ndy
Func _GDI_PrintDlgEx($hWnd = 0, $pd = Default)
	If Not IsDllStruct($pd) Then
		$pd = DllStructCreate($tagPDEX)

		If Not WinExists($hWnd) Then
			Local $wintile = AutoItWinGetTitle()
			AutoItWinSetTitle(@ScriptFullPath & Random(1246, 34679))
			$hWnd = WinGetHandle(AutoItWinGetTitle())
			AutoItWinSetTitle($wintile)
		EndIf
		DllStructSetData($pd, "lStructSize", DllStructGetSize($pd))
		DllStructSetData($pd, "hwndOwner", $hWnd)
		DllStructSetData($pd, "Flags", BitOR($PD_ALLPAGES, $PD_NOPAGENUMS, $PD_USEDEVMODECOPIESANDCOLLATE, $PD_RETURNDC, $PD_NOSELECTION, $PD_NOCURRENTPAGE))
		DllStructSetData($pd, "nCopies", 1)
		DllStructSetData($pd, "nStartPage", 0xFFFFFFFF)
;~ 		DllStructSetData($pd, "Flags", BitOR($PD_ALLPAGES, $PD_COLLATE, $PD_RETURNDC, $PD_NOPAGENUMS, $PD_NOSELECTION));,$PD_NOCURRENTPAGE))
;~          .Flags          = PD_ALLPAGES Or PD_COLLATE Or PD_RETURNDC Or PD_NOSELECTION
	EndIf

;~      PrintDlg(@pd)
	Local $ret = DllCall("comdlg32.dll", "int", "PrintDlgExW", "ptr", DllStructGetPtr($pd))
	If Not IsArray($ret) Or $ret[0] = 0 Then Return SetError(1, 0, 0)
	If $ret[0] > 2 Or $ret[0] < 0 Then Return SetError($ret[0], 0, 0)

	SetExtended($ret[0])
	Return $pd
;~      Return pd
EndFunc   ;==>_GDI_PrintDlgEx
#EndRegion Print DLG
;/*************************************************************************


;/*************************************************************************
#Region WinSpool

;===============================================================================
;
; Function Name:   _GDI_GetDefaultPrinter()
; Description::    Gets the DefaultPrinter Name :)
; Parameter(s):    --
; Requirement(s):  Winspool.drv -> Win2000 or newer
; Return Value(s): Path/Name of default Printer
; Author(s):       martin
;
;===============================================================================
;
Func _GDI_GetDefaultPrinter($WinspoolDrv = "Winspool.drv")
;~ 	Local $szDefPrinterName
;~ 	Local $Size
	Local $namesize = DllStructCreate("dword")
	DllCall($WinspoolDrv, "int", "GetDefaultPrinter", "str", '', "ptr", DllStructGetPtr($namesize))
	Local $pname = DllStructCreate("char[" & DllStructGetData($namesize, 1) & "]")
	DllCall($WinspoolDrv, "int", "GetDefaultPrinter", "ptr", DllStructGetPtr($pname), "ptr", DllStructGetPtr($namesize))
	Return DllStructGetData($pname, 1)
EndFunc   ;==>_GDI_GetDefaultPrinter

;===============================================================================
;
; Function Name:   _GDI_GetDefaultPrinterDC()
; Description::    Get DC of Default Printer
; Parameter(s):    --
; Requirement(s):  Winspool.drv -> Win2000 or newer
; Return Value(s): Handle to DC
; Author(s):       Prog@ndy
;
;===============================================================================
;
Func _GDI_GetDefaultPrinterDC($WinspoolDrv = "Winspool.drv")
	Local $DC = Call("_" & "GDI_CreateDC", "winspool", _GDI_GetDefaultPrinter($WinspoolDrv))
	Return $DC
EndFunc   ;==>_GDI_GetDefaultPrinterDC

; by Prog@ndy
Func _GDI_OpenPrinter($PrinterName, $WinspoolDrv = "Winspool.drv")
	Local $open = DllCall($WinspoolDrv, "long", "OpenPrinter", "str", $PrinterName, "ptr*", 0, "ptr", 0)
	Return $open[2]
EndFunc   ;==>_GDI_OpenPrinter
; by Prog@ndy
Func _GDI_ClosePrinter($PrinterHandle, $WinspoolDrv = "Winspool.drv")
	Local $open = DllCall($WinspoolDrv, "long", "ClosePrinter", "ptr", $PrinterHandle)
	Return $open[0]
EndFunc   ;==>_GDI_ClosePrinter
; by Prog@ndy
Func _GDI_DocumentProperties($hWnd, $Printer, $String = 0, $ptrInput = 0, $options = $DM_COPY, $WinspoolDrv = "Winspool.drv")
	Local $ptrOut = DllStructCreate($Printer_devicemode)
	DllStructSetData($ptrOut, "dmSize", DllStructGetSize($ptrOut))
	DllCall($WinspoolDrv, "long", "DocumentProperties", "hwnd", $hWnd, "ptr", $Printer, "ptr", $String, "ptr", DllStructGetPtr($ptrOut), "ptr", $ptrInput, "dword", $options)
	Return $ptrOut
EndFunc   ;==>_GDI_DocumentProperties


#EndRegion WinSpool
;/*************************************************************************

#EndRegion			Printing and Print Spooler
;*************************************************************