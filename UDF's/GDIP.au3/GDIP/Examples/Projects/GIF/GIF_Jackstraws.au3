#include "GIF.au3"

Local $hBitmap = _GDIPlus_BitmapCreateFromScan0(500, 500)
Local $hGraphics = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsSetSmoothingMode($hGraphics, 4)
_GDIPlus_GraphicsClear($hGraphics, 0xFFFFFFFF)
Local $hPen = _GDIPlus_PenCreate(_GetRandomColor(), 3)

_GIF_SetFrameDelay()
_GDIPlus_GraphicsDrawLine($hGraphics, Random(0, 500, 1), Random(0, 500, 1), Random(0, 500, 1), Random(0, 500, 1), $hPen)
_GDIPlus_PenSetColor($hPen, _GetRandomColor())

Local $hFile = _GIF_CreateAnimatedGIF(@ScriptDir & "\testGIF.gif", $hBitmap)

For $i = 1 To 100
	_GDIPlus_GraphicsDrawLine($hGraphics, Random(0, 500, 1), Random(0, 500, 1), Random(0, 500, 1), Random(0, 500, 1), $hPen)
	_GDIPlus_PenSetColor($hPen, _GetRandomColor())

	_GIF_FileAddFrame($hFile, $hBitmap)
Next

_GIF_FileFinalize($hFile)
_GDIPlus_PenDispose($hPen)
_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_GraphicsDispose($hGraphics)

_GDIPlus_Shutdown()


Func _GetRandomColor()
	Return Random(4278190080, 4294967295, 1)
EndFunc