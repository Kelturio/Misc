#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt("MustDeclareVars", 1)

Global $iARGBBackground, $hGraphics, $aFontFamilies

_Example()

Func _Example()
	Local $hGUI, $hFontCollection

	; Initialize GDI+
	_GDIPlus_Startup()

	$hGUI = GUICreate("_GDIPlus_FontCollectionCreate Example", 400, 200)
	GUISetState()

	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	; Create an InstalledFontCollection object containing the supported fonts on the system
	$hFontCollection = _GDIPlus_FontCollectionCreate()

	; Get all font families
	$aFontFamilies = _GDIPlus_FontCollectionGetFamilyList($hFontCollection)

	; Get the background color of a typical dialog box
	$iARGBBackground = BitOR(0xFF000000, _WinAPI_GetSysColor($COLOR_BTNFACE))

	; Now draw three strings using random font families each 2 seconds
	_PrintFonts()
	AdlibRegister("_PrintFonts", 2000)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	AdlibUnRegister("_PrintFonts")

	; Clean up
	_GDIPlus_GraphicsDispose($hGraphics)

	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc

Func _PrintFonts()
	Local $iI, $iIndex, $iMaxIndex, $hFontFamily, $sFamilyName

	If IsArray($aFontFamilies) Then
		$iMaxIndex = $aFontFamilies[0]
		_GDIPlus_GraphicsClear($hGraphics, $iARGBBackground)

		For $iI = 1 To 3
			$iIndex = Random(1, $iMaxIndex, 1)

			; Get a random font family object from the collection
			$hFontFamily = $aFontFamilies[$iIndex]
			; Get the font family name
			$sFamilyName = _GDIPlus_FontFamilyGetFamilyName($hFontFamily)
			; Draw the font family name using the same font family as the font
			_GDIPlus_GraphicsDrawString($hGraphics, $sFamilyName, 20, $iI*40, $sFamilyName, 15)
		Next
	EndIf
EndFunc