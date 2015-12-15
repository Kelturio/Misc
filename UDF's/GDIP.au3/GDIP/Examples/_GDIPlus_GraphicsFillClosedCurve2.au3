#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hHatchBrush, $aPoints[11][2], $iI, $iJ
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_GraphicsFillClosedCurve2 Example", 400, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Using antialiasing
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $SmoothingModeAntiAlias)
	
	; Create a few points
	$aPoints[0][0] = 10
	
	For $iI = 0 To 1
		For $iJ = 1 To 5
			$aPoints[$iI*5+$iJ][0] = 300*$iI+50
			$aPoints[$iI*5+$iJ][1] = $iJ*50
		Next
	Next
	
	; Create a HatchBrush to fill the closed curve
	$hHatchBrush = _GDIPlus_HatchBrushCreate($HatchStyleZigZag, 0xCC00FF80, 0x40000000)
	
	; Fill the closed curve specifying a tension value
	_GDIPlus_GraphicsFillClosedCurve2($hGraphics, $aPoints, 1.5, $hHatchBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hHatchBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc