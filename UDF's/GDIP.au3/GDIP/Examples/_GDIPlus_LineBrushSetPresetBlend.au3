#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $aInterpolations[5][2]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushSetPresetBlend", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create a linear gradient brush that changes gradually from black to white
	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 400, 200, 0xFF000000, 0xFFFFFFFF, 1) ; Flip the brush
	
	; Define the interpolated colors and positions
	$aInterpolations[0][0] = 4
	
	$aInterpolations[1][0] = 0xFFFF0000 ; Red
	$aInterpolations[1][1] = 0			; 0% from the left
	$aInterpolations[2][0] = 0xFF00FF00 ; Green
	$aInterpolations[2][1] = 0.3		; To 30% from the left
	$aInterpolations[3][0] = 0xFF0000FF ; Blue
	$aInterpolations[3][1] = 0.7		; To 70% from the left
	$aInterpolations[4][0] = 0xFFFFFF00 ; Yellow
	$aInterpolations[4][1] = 1			; To 100% from the left
	
	; Set the linear gradient brush colors and position
	_GDIPlus_LineBrushSetPresetBlend($hBrush, $aInterpolations)
	; Fill a rectangle with the linear gradient brush
	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 400, 200, $hBrush)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc