#include<GDI\GDI.au3>
#include<Memory.au3>
#include<Misc.au3>

;-------------------------------------
; GUI to get text
GUICreate("Your text to print",400,440)
$Edit = GUICtrlCreateEdit("",0,0,400,400)
$BTN = GUICtrlCreateButton("OK",10,405,80,30)
$Select = GUICtrlCreateButton("... Choose File",100,405,80,30)
GUISetState()

While 1
	$nMSG = GUIGetMsg()
	Switch $nMSG
		Case -3 ; $GUI_EVENT_CLOSE
			Exit ; exit
		Case $BTN
			ExitLoop ; Exit GUI loop and start to print
		Case $Select
			; choose a textfile
			$Path = FileOpenDialog("Open Textfile",@MyDocumentsDir,"Text (*.txt)|All (*.*)","",3)
			If Not @error Then GUICtrlSetData($Edit,FileRead($Path))
		EndSwitch
WEnd
GUISetState(@SW_HIDE)
; End GUI ---------------------------------------

; Get text to print
Global Const $PRINTTEXT = GUICtrlRead($Edit)

; Printing
SplashTextOn("Printing...","Printing text",200,50,10,10,16,"",12,1000)

; show Printer dialog
$PrinterStruct = _GDI_PrintDlg()
If @error Then
; on error free all memory possibly allocated by _GDI_PrintDlg
		If DllStructGetData($PrinterStruct, "hDC") Then _GDI_DeleteDC(DllStructGetData($PrinterStruct, "hDC"))
		_MemGlobalFree(DllStructGetData($PrinterStruct, 3))
		_MemGlobalFree(DllStructGetData($PrinterStruct, 4))
		Exit ; then Exit
EndIf
	
; get the DC handle for Printer DC	
Local $pDC = DllStructGetData($PrinterStruct, "hDC")
If $pDC Then
	; If it is a valid DC then print
	
	$TotalHeight = _GDI_GetDeviceCaps($pDC, $PHYSICALHEIGHT)   ; the total height of the page in pixels
	$TotalWidth = _GDI_GetDeviceCaps($pDC, $PHYSICALWIDTH)     ; the total wodth in pixels
	$PrintOffsetX = _GDI_GetDeviceCaps($pDC, $PHYSICALOFFSETX) ; x-offset of printable area
	$PrintOffsetY = _GDI_GetDeviceCaps($pDC, $PHYSICALOFFSETY) ; y-offset of printable area
	$PrintableWidth = _GDI_GetDeviceCaps($pDC, $HORZRES)       ; the printable width
	$PrintableHeight = _GDI_GetDeviceCaps($pDC, $VERTRES)      ; the printable height
	If $PrintOffsetX = 0 Then ; at least 50 px border
		$PrintOffsetX = 50
		$PrintableWidth -= 50
	EndIf
	If $PrintOffsetY = 0 Then ; at least 50 px border
		$PrintOffsetY = 50
		$PrintableHeight -= 50
	EndIf
	
	; set Info for Document (title shown in Print Spooler)
	$DocumentInfo = DllStructCreate($tagDOCINFO)
	DllStructSetData($DocumentInfo, 1, DllStructGetSize($DocumentInfo))
	$DocName = _PrintUDF_CreateTextStruct("Test Doc") ; we need an extra struct for the text
	DllStructSetData($DocumentInfo, "lpszDocName", DllStructGetPtr($DocName)) ; set the text-pointer to the Infostruct
	
	; Structure for printing of multiple pages
	$DRAWTEXTPARAMS = DllStructCreate($tagDRAWTEXTPARAMS)
	DllStructSetData($DRAWTEXTPARAMS,1,DllStructGetSize($DRAWTEXTPARAMS)) ; initialise ParamStruct
	DllStructSetData($DRAWTEXTPARAMS,2,4) ; set size of tabstob to 4 characters
	
	; rectangel in wich to print text
	$RECT = DllStructCreate($tagRECT)
	DllStructSetData($RECT,1,$PrintOffsetX)   ; left border: x-offset
	DllStructSetData($RECT,2,$PrintOffsetY)   ; top border: y-offset
	DllStructSetData($RECT,3,$PrintableWidth) ; width: printable width
	DllStructSetData($RECT,4,$PrintableHeight); width: printable height
	
	; start printing
	_GDI_StartDoc($pDC, $DocumentInfo)
	
	; Choose a font
	$Font = _ChooseFont("Arial",12)
	;If no font chosen (Cancel), set default values:
	If Not IsArray($Font) Then Dim $Font[8] = [7,0,"Arial",11,400,0,"000000","000000"]
	
	; set font color
	_GDI_SetTextColor($pDC,$Font[5])
	; create font and set it as default in printer DC
	$hFont = _GDI_CreateFont(_FonSizePT($pDC,$Font[3]),0,0,0,$Font[4],BitAND($Font[1],2)=2,BitAND($Font[1],4)=4,BitAND($Font[1],8)=8,1, $OUT_TT_PRECIS, $CLIP_DEFAULT_PRECIS, $ANTIALIASED_QUALITY, $DEFAULT_PITCH, $Font[2])
	$hOldFont = _GDI_SelectObject($pDC,$hFont)
	
	; Get Text to print
	$Text = $PRINTTEXT
	; chack, if text is empty
	If $Text="" Then
		If MsgBox(36, 'Warning', "No text to print. Abort?")=6 Then
			; if Printing should be aborted, abort it ;)
			_GDI_AbortDoc($pDC)
		Else
			$Text = " "; space, so it will print
		EndIf
	EndIf
	
	While $Text
		; while text is not empty, print a new page
		_GDI_StartPage($pDC)
			; draw the text on the page
			_GDI_DrawTextEx($pDC,$Text,$RECT,BitOR($DT_WORDBREAK,$DT_NOPREFIX,$DT_TABSTOP,$DT_EDITCONTROL),$DRAWTEXTPARAMS,StringLen($Text))
		_GDI_EndPage($pDC)
		; remove the drawn text from buffer
		$Text = StringTrimLeft($Text,DllStructGetData($DRAWTEXTPARAMS,"uiLengthDrawn"))
	WEnd

	; delete font -> clean up resources
	_GDI_SelectObject($pDC,$hOldFont)
	_GDI_DeleteObject($hFont)
	
	; end printing, printer can now print your Doc
	_GDI_EndDoc($pDC)
	
EndIf
; free memory allocated by _GDI_PrintDlg
_MemGlobalFree(DllStructGetData($PrinterStruct, 3))
_MemGlobalFree(DllStructGetData($PrinterStruct, 4))	

; calcualte font size for printer (from MSDN)
; by Prog@ndy
Func _FonSizePT($pDC, $Pt)
	Return -_MulDiv($Pt, _GDI_GetDeviceCaps($pDC, $LOGPIXELSY), 72)
EndFunc   ;==>_FonSizePT
; Function to muliply and divide in ine step, from MSDN
; by Prog@ndy
Func _MulDiv($nNumber, $nNumerator, $nDenominator)
	Local $res = DllCall("Kernel32.dll", "int", "MulDiv", "int", $nNumber, "int", $nNumerator, "int", $nDenominator)
	If @error Then Return SetError(1, 0, 0)
	Return $res[0]
EndFunc   ;==>_MulDiv