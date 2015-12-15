; Note: This file is a mess heh

#include <GDIP.au3>
#include <GUIButton.au3>
#include <GUIConstantsEx.au3>
#include <GUIImageList.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Local $hGUI, $Btn1, $Btn2, $Btn3, $Btn4, $aAccelTable[4][2], $fChanged = False

_GDIPlus_Startup()

$hGUI = GUICreate("Title", 300, 300)

GUIRegisterMsg($WM_ERASEBKGND, "_WM_ERASEBKGND")

; Left, Top, Width, Height, Ellipse width, Ellipse height, Start color, End color, Invert colors when hot/pressed, _
; Text color, Font size, Bold, Italic, Font typeface name
$Btn1 = _CreateAdvancedButton("Button &A", 75, 30, 150, 75, 50, 20, 0xAAFFFFFF, 0xFF000000, False, 0xFFFFFFFF, 12, True)
$Btn2 = _CreateAdvancedButton("Button &B", 75, 135, 150, 75, 75, 35, 0xFFFF0000, 0xFF800000, True, 0xFFFFFFFF, 15, True, True, "Courier New")
$Btn3 = _CreateAdvancedButton("Button &C", 125, 240, 50, 40, 10, 10, 0xFF80A0FF, 0xFF0000FF, False, 0xFFFFFFFF)
$Btn4 = _CreateAdvancedButton("E&xit", 220, 260, 70, 30, 10, 10, 0xFFF0F000, 0xFFF0A000, True) ; My favorite

$aAccelTable[0][0] = "!a"
$aAccelTable[0][1] = $Btn1
$aAccelTable[1][0] = "!b"
$aAccelTable[1][1] = $Btn2
$aAccelTable[2][0] = "!c"
$aAccelTable[2][1] = $Btn3
$aAccelTable[3][0] = "!x"
$aAccelTable[3][1] = $Btn4
GUISetAccelerators($aAccelTable)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $Btn1
			If Not $fChanged Then
				GUICtrlSetState($Btn2, $GUI_DISABLE)
				$fChanged = True
			EndIf

		Case $Btn3
			If $fChanged Then
				GUICtrlSetState($Btn2, $GUI_ENABLE)
				$fChanged = False
			EndIf

		Case $GUI_EVENT_CLOSE, $Btn4
			ExitLoop
	EndSwitch
WEnd

GUIDelete()

_GDIPlus_Shutdown()
Exit

Func _WM_ERASEBKGND($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hGraphics, $hLineBrush

	$hGraphics = _GDIPlus_GraphicsCreateFromHDC($iwParam)
	$hLineBrush = _GDIPlus_LineBrushCreate(0, 0, 300, 300, 0x202020CC, 0xFF60A0FF)

	_GDIPlus_GraphicsClear($hGraphics, 0xFFFFFFFF)
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 300, 300, $hLineBrush)
	_GDIPlus_BrushDispose($hLineBrush)
	_GDIPlus_GraphicsDispose($hGraphics)

	Return True
EndFunc

Func _CreateAdvancedButton($sText, $iLeft, $iTop, $iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClr1, $iClr2, $fInvert = False, $iTextClr = 0xFF000000, $iFontSize = 9, $fBold = False, $fItalic = False, $sFont = "Arial")
	Local $Button, $hButton, $hBmp, $hImageList, $iClrInvert1, $iClrInvert2
	Local $hGraphics, $hImageText, $hImageGraphics, $hBrush, $hFormat, $hFamily, $hFont
	Local $tLayout, $tRectF, $aMeasure, $iFontStyle, $nSWidth, $nSHeight

	$Button = _CreateRoundButton($iLeft, $iTop, $iWidth, $iHeight, $iWidthEllipse, $iWidthEllipse)
	If @error Then Return SetError(@error, 0, 0)
	$hButton = GUICtrlGetHandle($Button)

	$hImageList = _GUIImageList_Create($iWidth, $iHeight, 5, 3, 7)
	If $hImageList = 0 Then
		GUICtrlDelete($Button)
		Return SetError(4, 0, 0)
	EndIf

	If Not ($sText == "") Then
		If $fBold Then $iFontStyle = BitOR($iFontStyle, 1)
		If $fItalic Then $iFontStyle = BitOR($iFontStyle, 2)

		$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hButton)
		$hBrush = _GDIPlus_BrushCreateSolid($iTextClr)
		$hFormat = _GDIPlus_StringFormatCreate()
		_GDIPlus_StringFormatSetHotkeyPrefix($hFormat, 1)
		$hFamily = _GDIPlus_FontFamilyCreate($sFont)
		$hFont = _GDIPlus_FontCreate($hFamily, $iFontSize, $iFontStyle)
		$tLayout = _GDIPlus_RectFCreate(0, 0, $iWidth, $iHeight)

		$aMeasure = _GDIPlus_GraphicsMeasureString($hGraphics, $sText, $hFont, $tLayout, $hFormat)
		If IsArray($aMeasure) Then $tRectF = $aMeasure[0]

		$nSWidth = DllStructGetData($tRectF, "Width")
		$nSHeight = DllStructGetData($tRectF, "Height")
		$tLayout = _GDIPlus_RectFCreate(0, 0, $nSWidth, $nSHeight)

		$hImageText = _GDIPlus_BitmapCreateFromScan0($nSWidth, $nSHeight)
		$hImageGraphics = _GDIPlus_ImageGetGraphicsContext($hImageText)

		_GDIPlus_GraphicsDrawStringEx($hImageGraphics, $sText, $hFont, $tLayout, $hFormat, $hBrush)

		_GDIPlus_GraphicsDispose($hImageGraphics)
		_GDIPlus_FontDispose($hFont)
		_GDIPlus_FontFamilyDispose($hFamily)
		_GDIPlus_StringFormatDispose($hFormat)
		_GDIPlus_BrushDispose($hBrush)
		_GDIPlus_GraphicsDispose($hGraphics)
	EndIf

	If $fInvert Then
		$iClrInvert1 = $iClr2
		$iClrInvert2 = $iClr1
	Else
		$iClrInvert1 = $iClr1
		$iClrInvert2 = $iClr2
	EndIf

	; Normal
	$hBmp = _CreateButtonBmp($iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClr1, $iClr2, 0.85, $hImageText) ; 85% brightness
	_GUIImageList_Add($hImageList, $hBmp)
	_WinAPI_DeleteObject($hBmp)

	; Hot (mouse hover)
	$hBmp = _CreateButtonBmp($iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClrInvert1, $iClrInvert2, 0.9, $hImageText) ; 90% brightness
	_GUIImageList_Add($hImageList, $hBmp)
	_WinAPI_DeleteObject($hBmp)

	; Pressed
	$hBmp = _CreateButtonBmp($iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClrInvert1, $iClrInvert2, 1.0, $hImageText) ; 100% brightness
	_GUIImageList_Add($hImageList, $hBmp)
	_WinAPI_DeleteObject($hBmp)

	; Disabled (grayed-out)
	$hBmp = _CreateButtonBmp($iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClr1, $iClr2, 0.65, $hImageText) ; 65% brightness
	_GUIImageList_Add($hImageList, $hBmp)
	_WinAPI_DeleteObject($hBmp)

	; Defaulted (focused/not hot)
	$hBmp = _CreateButtonBmp($iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClr1, $iClr2, 0.85, $hImageText) ; 80% brightness
	_GUIImageList_Add($hImageList, $hBmp)
	_WinAPI_DeleteObject($hBmp)

	_GUICtrlButton_SetImageList($hButton, $hImageList, 4)
	If $hImageText Then _GDIPlus_BitmapDispose($hImageText)
	Return $Button
EndFunc

Func _CreateRoundButton($iLeft, $iTop, $iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse)
	Local $Button, $hButton, $hRgn

	$Button = GUICtrlCreateButton("", $iLeft, $iTop, $iWidth, $iHeight)
	If @error Then Return SetError(1, 0, 0)
	$hButton = GUICtrlGetHandle($Button)
	If $hButton = 0 Then Return SetError(2, 0, 0)

	$hRgn = _WinAPI_CreateRoundRectRgn(4, 4, $iWidth-4, $iHeight-4, $iWidthEllipse, $iHeightEllipse)
	If $hRgn = 0 Then
		GUICtrlDelete($Button)
		Return SetError(3, 0, 0)
	EndIf

	; GCL_STYLE (-26), CS_PARENTDC (126)
	_WinAPI_SetClassLong($hButton, -26, BitAND(_WinAPI_GetClassLong($hButton, -26), BitNOT(162)))
	_WinAPI_SetWindowRgn($hButton, $hRgn)

	_WinAPI_DeleteObject($hRgn)
	Return SetError(0, 0, $Button)
EndFunc

Func _CreateButtonBmp($iWidth, $iHeight, $iWidthEllipse, $iHeightEllipse, $iClr1, $iClr2, $nBrightness, $hImageText)
	Local $hImage, $hImageBirght, $hGraphics, $hGraphicsBright, $hLineBrushCtrl, $hLineBrushShade, $hIA, $tCM, $pCM, $hPath
	Local $hBmp, $iT, $iX, $iY
	Local $iTxtWidth, $iTxtHeight

	$hImage = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	$hGraphics = _GDIPlus_ImageGetGraphicsContext($hImage)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, 4)
	$hImageBirght = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	$hGraphicsBright = _GDIPlus_ImageGetGraphicsContext($hImageBirght)
	$hLineBrushCtrl = _GDIPlus_LineBrushCreate(0, 0, 0, $iHeight, $iClr1, $iClr2)
	$hLineBrushShade = _GDIPlus_LineBrushCreate(0, 0, 0, $iHeight/2, $iClr2, $iClr1)
	$hIA = _GDIPlus_ImageAttributesCreate()
	$tCM = _GDIPlus_ColorMatrixCreateScale($nBrightness, $nBrightness, $nBrightness)
	$pCM = DllStructGetPtr($tCM)

	$iT = 3
	$iX = 0
	$iY = $iHeight/2

	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddArc($hPath, $iX+$iT*2, $iY, $iWidthEllipse, $iHeightEllipse, 180, 90)
	_GDIPlus_PathAddArc($hPath, $iX+($iWidth-$iWidthEllipse-$iT*2), $iY, $iWidthEllipse, $iHeightEllipse, -90, 90)
	_GDIPlus_PathAddLine($hPath, $iWidth, $iHeight, 0, $iHeight)
	_GDIPlus_PathCloseFigure($hPath)

	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, $iWidth, $iHeight, $hLineBrushCtrl)
	_GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hLineBrushShade)

	If $hImageText <> 0 Then
		$iTxtWidth = _GDIPlus_ImageGetWidth($hImageText)
		$iTxtHeight = _GDIPlus_ImageGetHeight($hImageText)
		_GDIPlus_GraphicsDrawImage($hGraphics, $hImageText, $iWidth/2-$iTxtWidth/2, $iHeight/2-$iTxtHeight/2)
	EndIf

	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pCM)
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphicsBright, $hImage, 0, 0, $iWidth, $iHeight, 0, 0, $iWidth, $iHeight, $hIA)

	$hBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageBirght)

	_GDIPlus_PathDispose($hPath)
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_BrushDispose($hLineBrushShade)
	_GDIPlus_BrushDispose($hLineBrushCtrl)
	_GDIPlus_GraphicsDispose($hGraphicsBright)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_ImageDispose($hImageBirght)
	_GDIPlus_ImageDispose($hImage)

	Return $hBmp
EndFunc

Func _WinAPI_GetClassLong($hWnd, $iIndex)
	Local $aResult = DllCall("user32.dll", "uint", "GetClassLongW", "hwnd", $hWnd, "int", $iIndex)

	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0]
EndFunc

Func _WinAPI_SetClassLong($hWnd, $iIndex, $iNewVal)
	Local $aResult = DllCall("user32.dll", "uint", "SetClassLongW", "hwnd", $hWnd, "int", $iIndex, "int", $iNewVal)

	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0]
EndFunc