;This is the script used to produce the graph in the example above.
#include 'GDI.au3';the print UDF
#include 'GDIplus.au3';the print UDF
#include 'Constants.au3';the print UDF
Global $hp
Local $mmssgg, $marginx, $marginy

;~ _GDI_CreateFont(
;choose the printer if you don't want the default printer
$PrinterStruct = _GDI_PrintDlg(0)
If @error Then
	If _GDI_CommDlgExtendedError() = 0 Then
		Exit
;~ 		Return SetError(1,0,0)
	EndIf
	_GDI_FatalAppExit("Fehler beim Drucken")
;~ 	Return SetError(Dec(Hex(_GDI_CommDlgExtendedError())),0,0)
EndIf
$pDC = DllStructGetData($PrinterStruct, "hDC")

$logopath = @ScriptDir & "\Banner.bmp"
InetGet("http://www.abload.de/img/banner1n1r.bmp",$logopath)
If Not FileExists($logopath) Then
MsgBox(0, '', "konnte bild nicht downloaden. Beenden")
; Cleanup resources
_GDI_DeleteDC($pDC)
Exit
EndIf
    ; Initialize GDI+ library
    _GDIPlus_Startup ()

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


;#######################################################

;~ 	$Image = _GDI_LoadImage(0, FileGetShortName($logopath), $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
	$hImage = _GDIPlus_ImageLoadFromFile(FileGetShortName($logopath))

; gewünschte Größe in cm:
	$cmX = 10
	$cmY = 3

; größe in Pixel der Bitmap
Local $size[2]
	$size[0] = _GDIPlus_ImageGetHeight($hImage)
	$size[1] = _GDIPlus_ImageGetHeight($hImage)
	
; DC für kopieren
	$DC = _GDI_CreateCompatibleDC(0)
	$old = _GDI_SelectObject($DC, $hImage)
$Graph2 = _GDIPlus_ImageGetGraphicsContext($hImage)
; PPI des Druckers
	$PixelPerInchX = _GdipGetDpiX($Graph2)
;~ 	$PixelPerInchX = _GDI_GetDeviceCaps($pDC, $LOGPIXELSX)
	$PixelPerInchY = _GdipGetDpiY($Graph2)
;~ 	$PixelPerInchY = _GDI_GetDeviceCaps($pDC, $LOGPIXELSY)

; Pixel, zum Drucken in gewünschter cm-Auflösung nötig:
	$DruckPixelX = Int($cmX * $PixelPerInchX / 2.54)
	$DruckPixelY = Int($cmY * $PixelPerInchY / 2.54)
$Graph = _GDIPlus_GraphicsCreateFromHDC($pDC)



;~ DrawInsert($Graph,$hImage,30,30,90,$DruckPixelX,$DruckPixelY)
;~ _GDIPlus_GraphicsDrawImageRect($Graph,$hImage,10,10,$DruckPixelX,$DruckPixelY)
DrawInsert($Graph,$hImage,30,-$DruckPixelY,90,$DruckPixelX,$DruckPixelY)
_GDIPlus_GraphicsDispose($Graph)
_GDIPlus_ImageDispose($hImage)
;~ ; Zwischenbild für vergrößerung erstellen ( ging irgendwie nicht direkt...
;~ 	$DC2 = _GDI_CreateCompatibleDC(0)
;~ 	$BMP2 = _GDI_CreateCompatibleBitmap($pDC, $DruckPixelX, $DruckPixelY)
;~ 	$old2 = _GDI_SelectObject($DC2, $BMP2)

;~ ; schönere Vergrößerung :)
;~ 	_GDI_SetStretchBltMode($DC2, $HALFTONE)
;~ ; Vergrößern
;~ 	_GDI_StretchBlt($DC2, 0, 0, $DruckPixelX, $DruckPixelY, $DC, 0, 0, $size[0], $size[1], 0xCC0020)
;~ ;Vergrößertes Bild drucken
;~ 	_GDI_TextOut($pDC,$PrintOffsetX, $PrintOffsetY,"Skaliertes Bild auf " & $cmX & "x" & $cmY & " cm")
;~ 	_GDI_BitBlt($pDC, $PrintOffsetX, $PrintOffsetY+40, $DruckPixelX, $DruckPixelY, $DC2, 0, 0, $SRCCOPY)
;~ ; original drucken
;~ 	_GDI_TextOut($pDC,$PrintOffsetX, $PrintOffsetY+$DruckPixelY+50,"Originales Bild")	
;~ 	_GDI_BitBlt($pDC, $PrintOffsetX, $PrintOffsetY+$DruckPixelY+100, $size[0], $size[1], $DC, 0, 0, $SRCCOPY)

;~ ; löschen Vergrößrungsbild
;~ 	_GDI_SelectObject($DC2, $old2)
;~ 	_GDI_DeleteDC($DC2)
;~ 	_GDI_DeleteObject($BMP2)

;~ ; löschen Originalbild
;~ 	_GDI_SelectObject($DC, $old)
;~ 	_GDI_DeleteDC($DC)
;~ 	_GDI_DeleteObject($Image)
;#######################################################

	_GDI_EndPage($pDC)
	_GDI_EndDoc($pDC)
EndIf

; Cleanup resources
_GDI_DeleteDC($pDC)
FileDelete($logopath)
Func _GdipGetDpiX($Graphics)
	Local $ret = DllCall($ghGDIPDLL,"int","GdipGetDpiX","hwnd",$Graphics,"float*",0)
	Return $ret[2]
EndFunc
Func _GdipGetDpiY($Graphics)
	Local $ret = DllCall($ghGDIPDLL,"int","GdipGetDpiY","hwnd",$Graphics,"float*",0)
	Return $ret[2]
EndFunc
; #FUNCTION# ==================================================================================================
 ;Name...........: DrawInsert
; Description ...: Draw one image in another
; Syntax.........: DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle, $iWidth, $iHeight, $iARGB = 0xFF000000, $nWidth = 1)
; inserts Graphics $hImage2 into $hGraphic
; Parameters ....: $hGraphics   - Handle to a Graphics object
;                  $hImage      - Handle to an Image object to be inserted
;                  $iX          - The X coordinate of the upper left corner of the inserted image
;                  $iY          - The Y coordinate of the upper left corner of the inserted image
;                  $iWidth      - The width of the rectangle Border around insert
;                  $iHeight     - The height of the rectangle Border around insert

; Return values .: Success      - True
;                  Failure      - False
;==================================================================================================
Func DrawInsert($hGraphic, $hImage2, $iX, $iY, $nAngle, $iWidth, $iHeight)
    dim $hMatrix, $hPen2
   
    ;Rotation Matrix
    $hMatrix = _GDIPlus_MatrixCreate()
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False")   
    _GDIPlus_GraphicsSetTransform($hGraphic , $hMatrix)
   
    _GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage2, $iX, $iY,$iWidth,$iHeight)   
   
    ; Clean up resources
    _GDIPlus_MatrixDispose($hMatrix)
    Return 1
EndFunc

; Returns Array with w and h
; Prog@ndy
Func _GetBitMapSize($hBitmap)
	Local $RetArray[2] = [-1, -1]
	Local $BITMAP = DllStructCreate("LONG   bmType; LONG   bmWidth; LONG   bmHeight; LONG   bmWidthBytes; ubyte   bmPlanes; ubyte   bmBitsPixel; ptr bmBits;")
	Local $res = _GDI_GetObject($hBitmap, DllStructGetSize($BITMAP), DllStructGetPtr($BITMAP))
	If @error Or $res = 0 Then Return SetError(1, 0, $RetArray)
	Local $RetArray[2] = [DllStructGetData($BITMAP, 2), DllStructGetData($BITMAP, 3)]
	Return $RetArray
EndFunc   ;==>_GetBitMapSize

Func _FonSizePT($pDC, $Pt)
	Return _MulDiv($Pt, _GDI_GetDeviceCaps($pDC, $LOGPIXELSY), 72)
EndFunc   ;==>_FonSizePT
Func _MulDiv($nNumber, $nNumerator, $nDenominator)
	Local $res = DllCall("Kernel32.dll", "int", "MulDiv", "int", $nNumber, "int", $nNumerator, "int", $nDenominator)
	If @error Then Return SetError(1, 0, "")
	Return $res[0]
EndFunc   ;==>_MulDiv