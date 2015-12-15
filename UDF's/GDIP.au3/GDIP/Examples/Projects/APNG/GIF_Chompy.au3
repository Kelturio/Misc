#include <Array.au3>
#include <File.au3>
#include "..\GIF\GIF.au3"

Local Const $sChompyDir = "Chompy"
Local $aFiles = _FileListToArray($sChompyDir, "*.png", 1)

_ArraySort($aFiles)

Local $hImage, $hFile
_GIF_SetFrameDelay(7)

For $i = 1 To $aFiles[0]
	$hImage = _GDIPlus_ImageLoadFromFile($sChompyDir & "\" & $aFiles[$i])
	If Not $hImage Then ExitLoop

	If $i <> 1 Then
		_GIF_FileAddFrame($hFile, $hImage)
	Else
		$hFile = _GIF_CreateAnimatedGIF(@ScriptDir & "\ChompyGIF.gif", $hImage)
	EndIf

	_GDIPlus_ImageDispose($hImage)
Next

_GIF_FileFinalize($hFile)

_GDIPlus_Shutdown()