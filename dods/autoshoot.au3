#include <HotKeySetEx.au3>
#include <ToolTipTimer.au3>


Global $Aimbot = 0
Global $Pause = 1
Global $t1 = 12
Global $t2 = 66
Global $variation = 37
;~ Global $hwnd = "Day of Defeat Source"
Global $hwnd = default
Global $active = True
Global $px = (@DesktopWidth / 2) + 3
Global $py = (@DesktopHeight / 2) + 22
Global $prectx1 = $px -1
Global $precty1 = $py -1
Global $prectx2 = $px +1
Global $precty2 = $py +1
Global $button = 'left'
Global $aColorAxis[4] = [0xFF2C23, 0xC00000, 0xFF0195, 0x990045]
Global $aColorAllies[4] = [0x100FFF, 0x000075, 0x26FF2B, 0x00AA0D]
Global $aColorT[4] = [0xFF0200, 0xFF0200, 0xFF0200, 0xFF0200]
Global $aColorCT[4] = [0x0000FF, 0x000091, 0x00005B, 0x000048]
Global $game = 'dods'
Global $ColorR
Global $ColorB

if $game = 'dods' Then
	$ColorR = $aColorAxis
	$ColorB = $aColorAllies
EndIf
if $game = 'css' Then
	$ColorR = $aColorT
	$ColorB = $aColorCT
EndIf

Opt("MouseCoordMode", 0)
Opt("PixelCoordMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 0)

HotKeySet("{HOME}", "ToggleAimbot")
HotKeySet("{END}", "TurnOffAimbot")
HotKeySetEx("{XClick1}", "XClick1")

While 1
	If $active Then
		If $Aimbot = 1 Then;
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorR[0], $variation, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorR[1], $variation * 1.2, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
;~ 			HEADSHOT
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorR[2], $variation, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorR[3], $variation * 1.25, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
		EndIf
		If $Aimbot = 2 Then;
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorB[0], $variation, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorB[1], $variation * 1.2, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
;~ 			HEADSHOT
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorB[2], $variation, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
			$coord = PixelSearch($prectx1, $precty1, $prectx2, $precty2, $ColorB[3], $variation * 1.25, Default, $hwnd)
			If Not @error Then
				MouseClick($button)
				Sleep($t1)
			EndIf
		EndIf
	EndIf
	If $Aimbot = 0 Then;
		Sleep($t2)
	EndIf
WEnd

Func XClick1()
	$active = Not $active
	ToolTip($active, 0, 0)
EndFunc   ;==>XClick1

Func ToggleAimbot()
	If $Aimbot < 2 Then
		$Aimbot = $Aimbot + 1
	Else
		$Aimbot = 0
	EndIf
	Select
		Case $Aimbot = 0
			ToolTip("Aimbot Status: Off", 0, 0)
		Case $Aimbot = 1
			ToolTip("Aimbot Status: Red", 0, 0)
		Case $Aimbot = 2
			ToolTip("Aimbot Status: Blue", 0, 0)

	EndSelect
EndFunc   ;==>ToggleAimbot

Func TurnOffAimbot()
	$Aimbot = 0
	ToolTip("Aimbot Status: Off", 0, 0)
EndFunc   ;==>TurnOffAimbot