#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $hIA, $tColorPalette, $pColorPalette, $aRemap[2][2], $iI
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_ImageAttributesGetAdjustedPalette", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a palette that has four entries
	$tColorPalette = DllStructCreate("uint Flags;uint Count;uint Entries[4]")
	$pColorPalette = DllStructGetPtr($tColorPalette)
	
	DllStructSetData($tColorPalette, "Flags", 0)
	DllStructSetData($tColorPalette, "Count", 4)
	DllStructSetData($tColorPalette, "Entries", 0xFF00FFFF, 1) ; Aqua
	DllStructSetData($tColorPalette, "Entries", 0xFF000000, 2) ; Black
	DllStructSetData($tColorPalette, "Entries", 0xFFFF0000, 3) ; Red
	DllStructSetData($tColorPalette, "Entries", 0xFF00FF00, 4) ; Green
	
	; Create a Brush to fill the drawn rectangles
	$hBrush = _GDIPlus_BrushCreateSolid()
	
	; Display the four palette colors with no adjustment
	For $iI = 1 to 4
		_GDIPlus_BrushSetFillColor($hBrush, DllStructGetData($tColorPalette, "Entries", $iI))
		_GDIPlus_GraphicsFillRect($hGraphics, $iI*30, 10, 20, 20, $hBrush)
	Next
	
	; Create a remap table that converts green to blue
	$aRemap[0][0] = 1
	$aRemap[1][0] = 0xFF00FF00 ; Green as the old color
	$aRemap[1][1] = 0xFF0000FF ; Blue as the new color
	
	; Create an ImageAttribute object, and set it's bitmap remap table
	$hIA = _GDIPlus_ImageAttributesCreate()
	_GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemap)
	; Adjust the palette
	_GDIPlus_ImageAttributesGetAdjustedPalette($hIA, $pColorPalette, 1)
	
	; Display the four palette colors after adjustment
	For $iI = 1 To 4
		_GDIPlus_BrushSetFillColor($hBrush, DllStructGetData($tColorPalette, "Entries", $iI))
		_GDIPlus_GraphicsFillRect($hGraphics, $iI*30, 40, 20, 20, $hBrush)
	Next
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc