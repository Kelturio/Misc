#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hBrush, $tRectF, $aBlends[5][2]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_LineBrushSetBlend", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	; Create the defining rectangle for the linear gradient brush
	$tRectF = _GDIPlus_RectFCreate(0, 0, 400, 200)
	; Create a linear gradient brush that changes gradually from red to green
	$hBrush = _GDIPlus_LineBrushCreateFromRect($tRectF, 0xFFFF0000, 0xFF00FF00, 0, 1) ; Horizontal direction
	
	; Define the linear gradient brush color positions and factors
	$aBlends[0][0] = 4 ; Using 4 factors and position
	
	$aBlends[1][0] = 0   ; Factor
	$aBlends[1][1] = 0   ; Position
	$aBlends[2][0] = 1   ; The percentage of the blending is 100% (red to green is gradually completed in just 20% from the left)
	$aBlends[2][1] = 0.2 ; The distance percentage from the left boundary of the brush is 20%
	$aBlends[3][0] = 0   ; The percentage of the blending is 0% (green to red is gradually completed from 20% to 70% from the left)
	$aBlends[3][1] = 0.7 ; The distance percentage from the left boundary of the brush is 70%
	$aBlends[4][0] = 1	 ; The percentage of the blending is 100% (red to green is gradually completed from 70% to 100% from the left)
	$aBlends[4][1] = 1	 ; The distance percentage from the left boundary of the brush is 100%
	
	; Set the linear gradient brush color positions and factors
	_GDIPlus_LineBrushSetBlend($hBrush, $aBlends)
	
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