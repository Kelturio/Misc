#include <GDIP.au3>
#include "APNG.au3"
HotKeySet("{ESC}", "_Quit")

_GDIPlus_Startup()

Global Const $iWidth = 400, $iHeight = 400

Global $hBitmap = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
Global $hGraphics = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsSetSmoothingMode($hGraphics, 4)
_GDIPlus_GraphicsClear($hGraphics, 0xFFFFFFFF)

Global $aMax[4] = [$iWidth, $iHeight, $iWidth, $iHeight]
Global $aLine[4] = [Random(0, $aMax[0], 1), Random(0, $aMax[1], 1), Random(0, $aMax[2], 1), Random(0, $aMax[3], 1)]
Global $aMove[4] = [Random(1, 4, 1), Random(1, 4, 1), Random(1, 4, 1), Random(1, 4, 1)]
Global $hPen = _GDIPlus_PenCreate(0x44000000, 1)
Global $iJump = 2
Global $PenColor = False
Global $QUIT = False
Global $fFirst = True
Global $Counter = 0
Global $oAPNG = _APNG_CreateObject()

AdlibRegister('_FlipColor', 4000)
Do
	For $j = 1 To $iJump
		_GDIPlus_GraphicsDrawLine($hGraphics, $aLine[0], $aLine[1], $aLine[2], $aLine[3], $hPen)

		For $i = 0 To 3
			$aLine[$i] += $aMove[$i]
			If $aLine[$i] < ($aMax[$i] * - 0.1) Then
				$aMove[$i] = Random(1, 4, 1)
			ElseIf $aLine[$i] > ($aMax[$i] + $aMax[$i] * 0.1) Then
				$aMove[$i] = Random(1, 4, 1) * - 1
			EndIf
		Next
		$Counter += 1
	Next
	If $Counter >= 15 Then
		$Counter = 0

		_APNG_AddFrame($oAPNG, $hBitmap, 75)
	EndIf

	Sleep(10)
Until $QUIT
AdlibUnRegister("_FlipColor")

_APNG_SaveToFile($oAPNG, @ScriptDir & "\APNG_Lines.png")
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_BitmapDispose($hBitmap)

_GDIPlus_Shutdown()

Func _FlipColor()
	$PenColor = Not $PenColor

	If $PenColor Then
		_GDIPlus_PenSetColor($hPen, 0x44FFFFFF)
	Else
		_GDIPlus_PenSetColor($hPen, 0x44000000)
	EndIf
EndFunc

Func _Quit()
    $QUIT = True
EndFunc