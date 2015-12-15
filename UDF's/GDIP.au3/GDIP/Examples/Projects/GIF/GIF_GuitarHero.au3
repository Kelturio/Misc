#include "GIF.au3"

_GDIPlus_Startup()

$sGuitarHero = 'http://upload.wikimedia.org/wikipedia/fr/3/38/Guitar_Hero_Logo.png'
$sFileName = @ScriptDir & "\GuitarHero.png"
If Not FileExists($sFileName) Then InetGet($sGuitarHero, $sFileName, 1)

$hImage = _GDIPlus_ImageLoadFromFile($sFileName)
$iWidth = _GDIPlus_ImageGetWidth($hImage)
$iHeight = _GDIPlus_ImageGetHeight($hImage)
$nRatio = $iWidth / $iHeight

$hSaveImg = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
$hGraphics = _GDIPlus_ImageGetGraphicsContext($hSaveImg)
_GDIPlus_GraphicsClear($hGraphics, 0xFFFFFFFF)

$fFirst = True
$hFile = 0
$iDelay = 30

For $iNewWidth = 200 To @DesktopWidth/2 Step 20
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, $iWidth/2-$iNewWidth/2, $iHeight/2-($iNewWidth/$nRatio)/2, $iNewWidth, $iNewWidth/$nRatio)

	If Not $fFirst Then
		$iDelay -= 5
		If $iDelay <= 0 Then $iDelay = 0
		_GIF_SetFrameDelay($iDelay)
		_GIF_FileAddFrame($hFile, $hSaveImg)
	Else
		$hFile = _GIF_CreateAnimatedGIF(@ScriptDir & "\AnimGIF_GuitarHero.gif", $hSaveImg)
		$fFirst = False
	EndIf
Next

If $hFile Then _GIF_FileFinalize($hFile)

_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_BitmapDispose($hSaveImg)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_Shutdown()