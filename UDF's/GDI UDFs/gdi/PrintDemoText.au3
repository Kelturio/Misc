;This is the script used to produce the graph in the example above.
#include 'GDI\GDI.au3';the print UDF
#include 'Constants.au3'
#include 'WinAPI.au3'
Global $hp
Local $mmssgg, $marginx, $marginy
$File = FileOpenDialog("Textdatei", @WindowsDir, "Textdateien (*.log;*.txt;*.xml)")
If Not FileExists($File) Then Exit MsgBox(0, '', "Keine Datei ausgewählt")
$sText = FileRead($File)
$GUI = GUICreate("")
$PrinterStruct = _GDI_PrintDlg($GUI)
If @error Then
	If _WinAPI_CommDlgExtendedError() = 0 Then
		MsgBox(0, '', "Druckdialog abgebrochen")
	Else
		MsgBox(0, '', "Fehler beim Druckdialog")
	EndIf
	Exit
EndIf

$pDC = DllStructGetData($PrinterStruct, "hDC")

If $pDC Then
	$TotalHeight = _GDI_GetDeviceCaps($pDC, $PHYSICALHEIGHT)
	$TotalWidth = _GDI_GetDeviceCaps($pDC, $PHYSICALWIDTH)
	$PrintOffsetX = _GDI_GetDeviceCaps($pDC, $PHYSICALOFFSETX)
	$PrintOffsetY = _GDI_GetDeviceCaps($pDC, $PHYSICALOFFSETY)
	$PrintableWidth = _GDI_GetDeviceCaps($pDC, $HORZRES)
	$PrintableHeight = _GDI_GetDeviceCaps($pDC, $VERTRES)
	If $PrintOffsetX = 0 Then
		$PrintOffsetX = 50
		$PrintableWidth -= 50
	EndIf
	If $PrintOffsetY = 0 Then
		$PrintOffsetY = 50
		$PrintableHeight -= 50
	EndIf
	
	$tDocInfo = DllStructCreate($tagDOCINFO)
	DllStructSetData($tDocInfo, 1, DllStructGetSize($tDocInfo))
	$DocName = _PrintUDF_CreateTextStruct("Test Doc")
	DllStructSetData($tDocInfo, "lpszDocName", DllStructGetPtr($DocName))


	_GDI_StartDoc($pDC, $tDocInfo) ; Dokument beginnen

	$Font = _GDI_CreateFont(_FonSizePT($pDC, 12), 0, 0, 0, 700, 0, 1, 0, 0, $OUT_TT_ONLY_PRECIS, 0, 0, 0, "Arial") ; Schrift erstellen
	$OLDFONT = _GDI_SelectObject($pDC, $Font) ; schrift auswählen
	
	$tRect = _GDI_RectCreate($PrintOffsetX,$PrintOffsetY, $PrintOffsetX+$PrintableWidth-50, $PrintOffsetY+$PrintableHeight) ; Druckbereich festelgen
	
	$tParams = DllStructCreate($tagDRAWTEXTPARAMS) ; Druckparameter erzeigen
	DllStructSetData($tParams,1,DllStructGetSize($tParams))
	DllStructSetData($tParams,"iTabLength",4) ; Tabstops sind etwa 4 Zeichen lang.
	
	Do
		_GDI_StartPage($pDC) ; Seite starten
		DllStructSetData($tParams,"uiLengthDrawn",0) ; Gedruckte zeichen auf dieser Seite auf 0 setzen
		$res = _GDI_DrawTextEx($pDC, $sText, $tRect, BitOR($DT_EDITCONTROL, $DT_NOPREFIX, $DT_WORDBREAK, $DT_TABSTOP) , $tParams) ; drucken
		$sText = StringTrimLeft($sText,DllStructGetData($tParams,"uiLengthDrawn") ) ; gedruckte Zeichen aus dem Buffer entfernen
		_GDI_EndPage($pDC) ;Seite beenden
	Until $sText = "" ; wenn kein Text mehr da ist, abbrechen
	
	_GDI_SelectObject($pDC,$OLDFONT) ; Schrift entfernen
	_GDI_DeleteObject($Font) ; schrift löschen
	
	_GDI_EndDoc($pDC) ; Dokument beenden
EndIf

; Schriftgröße für den DeviceContext aus Punkt berechen berechnen
Func _FonSizePT($pDC, $Pt)
	Return _MulDiv($Pt, _GDI_GetDeviceCaps($pDC, $LOGPIXELSY), 72)
EndFunc   ;==>_FonSizePT
Func _MulDiv($nNumber, $nNumerator, $nDenominator)
	; Prog@ndy
	Local $res = DllCall("Kernel32.dll", "int", "MulDiv", "int", $nNumber, "int", $nNumerator, "int", $nDenominator)
	If @error Then Return SetError(1, 0, 0)
	Return $res[0]
EndFunc   ;==>_MulDiv