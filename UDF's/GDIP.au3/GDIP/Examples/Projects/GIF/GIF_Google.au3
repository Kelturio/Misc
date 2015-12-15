#include "GIF.au3"

_GDIPlus_Startup()

$sGoogle = 'http://www.uclouvain.be/cps/ucl/doc/adcp/images/Google_logo.png'
$sFileName = @ScriptDir & "\Google.png"
If Not FileExists($sFileName) Then InetGet($sGoogle, $sFileName, 1)

$hImage = _GDIPlus_ImageLoadFromFile($sFileName)
$iWidth = _GDIPlus_ImageGetWidth($hImage)
$iHeight = _GDIPlus_ImageGetHeight($hImage)
$nRatio = $iWidth / $iHeight

$hSaveImg = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
$hGraphics = _GDIPlus_ImageGetGraphicsContext($hSaveImg)
_GDIPlus_GraphicsClear($hGraphics, 0xFFFFFFFF)

$fFirst = True
$hFile = 0

For $iNewWidth = 200 To @DesktopWidth/2 Step 20
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, $iWidth/2-$iNewWidth/2, $iHeight/2-($iNewWidth/$nRatio)/2, $iNewWidth, $iNewWidth/$nRatio)

	If Not $fFirst Then
		_GIF_FileAddFrame($hFile, $hSaveImg)
		_GIF_SetFrameDelay(0)
	Else
		$hFile = _GIF_CreateAnimatedGIF(@ScriptDir & "\AnimGIF_Google.gif", $hSaveImg)
		$fFirst = False
	EndIf
Next

If $hFile Then _GIF_FileFinalize($hFile)

_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_BitmapDispose($hSaveImg)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_Shutdown()