;This is the script used to produce the graph in the example above.
#include 'GDI.au3';the print UDF
#include 'Constants.au3'
#include 'WinAPI.au3'
Global $hp
Local $mmssgg, $marginx, $marginy

;~ _GDI_CreateFont(
;choose the printer if you don't want the default printer
$PrinterStruct = _GDI_PrintDlg(0)
If @error Then
	If _GDI_CommDlgExtendedError() = 0 Then
		
;~ 		Return SetError(1,0,0)
	EndIf
	
;~ 	Return SetError(Dec(Hex(_GDI_CommDlgExtendedError())),0,0)
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
	
	$di = DllStructCreate($tagDOCINFO)
	DllStructSetData($di, 1, DllStructGetSize($di))
	$DocName = _PrintUDF_CreateTextStruct("Test Doc")
	DllStructSetData($di, "lpszDocName", DllStructGetPtr($DocName))


	_GDI_StartDoc($pDC, $di)
	_GDI_StartPage($pDC)
	$pght = $PrintableHeight
	$pgwd = $PrintableWidth

	$axisx = Round($pgwd * 0.8)
	$axisy = Round($pght * 0.8)
;~ _PrintSetFont($hp,'Arial',18,0,'bold,underline')
	$Font = _GDI_CreateFont(_FonSizePT($pDC, 18), 0, 0, 0, 700, 0, 1, 0, 0, $OUT_TT_ONLY_PRECIS, 0, 0, 0, "Arial")
	_GDI_SelectObject($pDC, $Font)



	$Title = "Sales for 2006"
	$size = _GDI_GetTextExtentPoint32($pDC, $Title)
	$tw = DllStructGetData($size, 1);_PrintGetTextWidth($hp,$Title)
	$th = DllStructGetData($size, 2);_PrintGetTextHeight($hp,$title)
	_GDI_TextOut($pDC, Int($pgwd / 2 - $tw / 2), $PrintOffsetY, $Title)

	$size = _GDI_GetTextExtentPoint32($pDC, "Jan")
	;_PrintGetTextHeight($hp,$title)
	$basey = 2 * DllStructGetData($size, 2)
	$basex = $basey + 200
	$Pen = _GDI_CreatePen(0, 2, 0)
	_GDI_SelectObject($pDC, $Pen)
	_GDI_MoveToEx($pDC, $basex, $pght - $basey)
	_GDI_lineTo($pDC, $axisx + $basex, $pght - $basey)

	_GDI_MoveToEx($pDC, $basex, $pght - $basey)
	_GDI_lineTo($pDC, $basex, $pght - $basey - $axisy)

	$Font2 = _GDI_CreateFont(_FonSizePT($pDC, 12), 0, 0, 0, 400, 0, 0, 0, 0, $OUT_TT_ONLY_PRECIS, 0, 0, 0, "Times New Roman")
	_GDI_DeleteObject(_GDI_SelectObject($pDC, $Font2))

	$xdiv = Int(($axisx - $basey) / 12)
	$ydiv = Int($axisy / 10)

	$months = StringSplit("Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sept|Oct|Nov|Dec", '|')
	For $n = 1 To 12
		$size = _GDI_GetTextExtentPoint32($pDC, $months[$n])
		;_PrintGetTextHeight($hp,$title)
		_GDI_TextOut($pDC, $basex + $n * $xdiv - Int(DllStructGetData($size, 2) / 2), $pght - $basey + 5, $months[$n])
		_GDI_MoveToEx($pDC, $basex + $n * $xdiv, $pght - $basey - 10)
		_GDI_lineTo($pDC, $basex + $n * $xdiv, $pght - $basey + 10)
;~     _PrintLine($hp,$Basex + $n*$xdiv,$pght - $basey - 10,$Basex + $n*$xdiv,$pght - $basey + 10)

	Next
	$size = _GDI_GetTextExtentPoint32($pDC, "10")
	For $n = 1 To 10
		$size2 = _GDI_GetTextExtentPoint32($pDC, $n)
		_GDI_TextOut($pDC, $basex - DllStructGetData($size, 2) - 20, $pght - $basey - $n * $ydiv - Int(DllStructGetData($size, 2) / 2), $n)
		_GDI_MoveToEx($pDC, $basex - 5, $pght - $basey - $n * $ydiv)
		_GDI_lineTo($pDC, $basex + 5, $pght - $basey - $n * $ydiv)
;~   _PrintLIne($hp,$basex - 5,$pght - $basey - $n*$ydiv,$basex + 5,$pght - $basey - $n*$ydiv)

	Next
	$Font2 = _GDI_CreateFont(_FonSizePT($pDC, 12), 0, 900, 0, 400, 0, 0, 0, 0, $OUT_TT_ONLY_PRECIS, 0, 0, 0, "Times New Roman")
	$Font = _GDI_SelectObject($pDC, $Font2)
	$size = _GDI_GetTextExtentPoint32($pDC, "£")
	_GDI_TextOut($pDC, $basex - 3 * DllStructGetData($size, 2), $pght - $basey - 100, "£ x 1000,000")
	_GDI_DeleteObject(_GDI_SelectObject($pDC, $Font))

	Dim $sales[13] = [0, 20, 25, 20, 18, 10, 17, 20, 10, 80, 90, 100, 100]
;~ _PrintSetLineCol($hp,0x0000ff)
	$Pen = _GDI_CreatePen(0, 2, 0x0000ff)
	_GDI_DeleteObject(_GDI_SelectObject($pDC, $Pen))


	$brusch = _GDI_CreateSolidBrush(0x55FF55)
	_GDI_SelectObject($pDC, $brusch)
;~ _PrintSetBrushCol($hp,0x55FF55)
	For $n = 1 To 12
		_GDI_Rectangle($pDC, $basex + $n * $xdiv - 50, $pght - $basey - Int($sales[$n] * $ydiv / 10), _
				$basex + $n * $xdiv + 50, $pght - $basey - 0.2)
	Next

	$Pen = _GDI_CreatePen(0, 2, 0x000000)
	_GDI_DeleteObject(_GDI_SelectObject($pDC, $Pen))

	_GDI_MoveToEx($pDC, Int($pgwd / 2), 2 * $th + 125)
	_GDI_LineTo($pDC, $basex + 8 * $xdiv, $pght - $basey - Int($sales[8] * $ydiv / 10))

	$Pen = _GDI_CreatePen(0, 10, 0x0000ff)
	_GDI_DeleteObject(_GDI_SelectObject($pDC, $Pen))
	$brusch = _GDI_CreateSolidBrush(0xbbccee)
	_GDI_DeleteObject(_GDI_SelectObject($pDC, $brusch))
	_GDI_Ellipse($pDC, Int($pgwd / 2) - 200, 2 * $th, Int($pgwd / 2) + 200, 2 * $th + 250)

	$label = "I started work"
	$size = _GDI_GetTextExtentPoint32($pDC, $label)
	_GDI_SetBKMode($pDC, 1)
	_GDI_TextOut($pDC, Int($pgwd / 2 - DllStructGetData($size, 1) / 2), 2 * $th + 125 - Int(DllStructGetData($size, 2) / 2), $label)
	
	$Image = _WinAPI_LoadImage(0, FileGetShortName("D:\Dokumente\Dateien von Andreas\Eigene Bilder\Banner.bmp"), $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
	$size = _GetBitMapSize($Image)
	$DC = _GDI_CreateCompatibleDC(0)
;~ 	$DC = _GDI_CreateDC(0)
	$old = _GDI_SelectObject($DC,$Image)
	_GDI_BitBlt($pDC,Int($pgwd/2) - 150,2*$th+260,$size[0],$size[1],$DC,1,1,$SRCCOPY)
	_GDI_SelectObject($DC,$old)
	_GDI_DeleteDC($DC)
	_GDI_DeleteObject($Image)

	_GDI_EndPage($pDC)
	_GDI_EndDoc($pDC)
EndIf

; Returns Array with w and h
; Prog@ndy
Func _GetBitMapSize($hBitmap)
	Local $RetArray[2] = [-1,-1]
	Local $BITMAP = DllStructCreate("LONG   bmType; LONG   bmWidth; LONG   bmHeight; LONG   bmWidthBytes; ubyte   bmPlanes; ubyte   bmBitsPixel; ptr bmBits;")
	Local $res = _GDI_GetObject($hBitmap,DllStructGetSize($BITMAP),DllStructGetPtr($BITMAP))
	If @error Or $res = 0 Then Return SetError(1,0,$RetArray)
	Local $RetArray[2] = [DllStructGetData($BITMAP,2),DllStructGetData($BITMAP,3)]
	Return $RetArray
EndFunc

Func _FonSizePT($pDC, $Pt)
	Return _MulDiv($Pt, _GDI_GetDeviceCaps($pDC, $LOGPIXELSY), 72)
EndFunc   ;==>_FonSizePT
Func _MulDiv($nNumber, $nNumerator, $nDenominator)
	Local $res = DllCall("Kernel32.dll", "int", "MulDiv", "int", $nNumber, "int", $nNumerator, "int", $nDenominator)
	If @error Then Return SetError(1, 0, 0)
	Return $res[0]
EndFunc   ;==>_MulDiv