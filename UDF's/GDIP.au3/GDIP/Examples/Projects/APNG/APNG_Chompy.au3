#include <Array.au3>
#include <File.au3>
#include "APNG.au3"

_GDIPlus_Startup()

Local Const $sChompyDir = "Chompy"
Local $aFiles = _FileListToArray($sChompyDir, "*.png", 1)

_ArraySort($aFiles)

Local $hImage, $oAPNG

$oAPNG = _APNG_CreateObject(0) ; 0, repeat indefinitely

For $i = 1 To $aFiles[0]
	$hImage = _GDIPlus_ImageLoadFromFile($sChompyDir & "\" & $aFiles[$i])
	If Not $hImage Then ExitLoop

	; APNG object, Image handle, Delay (ms), Width, Height, xOffset, yOffset, AreaDisposal, AreaRendering
	_APNG_AddFrame($oAPNG, $hImage, 75)

	_GDIPlus_ImageDispose($hImage)
Next

; Open the file with Firefox to see the animation
_APNG_SaveToFile($oAPNG, @ScriptDir & "\Chompy.png")

_GDIPlus_Shutdown()