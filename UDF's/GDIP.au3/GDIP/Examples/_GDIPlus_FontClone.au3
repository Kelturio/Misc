#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hFontFamily, $hFont, $hFontCloned, $hBrush, $tLayout
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_FontClone Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	;  Create the font
	$hFontFamily = _GDIPlus_FontFamilyCreate("Arial")
	$hFont = _GDIPlus_FontCreate($hFontFamily, 24)
	
	; Create a clone of the font
	$hFontCloned = _GDIPlus_FontClone($hFont)
	
	; Create a solid brush
	$hBrush = _GDIPlus_BrushCreateSolid()
	
	; Draw a string
	$tLayout = _GDIPlus_RectFCreate(30, 30)
	_GDIPlus_GraphicsDrawStringEx($hGraphics, "This is a cloned Font", $hFontCloned, $tLayout, 0, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_FontFamilyDispose($hFontFamily)
	_GDIPlus_FontDispose($hFontCloned)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc