#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

Global Const $sFileName = @MyDocumentsDir & "\SampleMeta.emf"

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hMetafile, $hIA, $tColorMatrix, $pColorMatrix
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	
	$hGUI = GUICreate("_GDIPlus_ImageAttributesSetNoOp Example", 600, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_CreateTestMetafile($hGraphics)
	
	; Create a Metafile object from the sample metafile file and start playing the records
	$hMetafile = _GDIPlus_MetafileCreateFromFile($sFileName)
	
	; Create an ImageAttributes object used to adjust image colors
	$hIA = _GDIPlus_ImageAttributesCreate()
	
	; Create a ColorMatrix that converts red to green
	$tColorMatrix = _ColorMatrixCreateRedToGreen()
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
	
	; Set the ImageAttributes ColorMatrix, applies color adjustment to pens and brushes
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 2, True, $pColorMatrix)
	_GDIPlus_ImageAttributesSetColorMatrix($hIA, 3, True, $pColorMatrix)
	
	; Disable color adjustment to pens but enable color adjustment to brushes
	_GDIPlus_ImageAttributesSetNoOp($hIA, 2, False) ; Turn-on
	_GDIPlus_ImageAttributesSetNoOp($hIA, 3, True)  ; Turn-off

	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hMetafile, 0, 0, 200, 350, 0, 0, 200, 350, $hIA)
	
	; Disable color adjustment to brush color but enable color adjustment to  pen
	_GDIPlus_ImageAttributesSetNoOp($hIA, 2, True)  ; Turn-off
	_GDIPlus_ImageAttributesSetNoOp($hIA, 3, False) ; Turn-on
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hMetafile, 0, 0, 200, 350, 200, 0, 200, 350, $hIA)
	
	; Reinstate brush color adjustment but disable pen color adjustment
	_GDIPlus_ImageAttributesSetNoOp($hIA, 2, False) ; Turn-on
	_GDIPlus_ImageAttributesSetNoOp($hIA, 3, True)  ; Turn-off
	
	_GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hMetafile, 0, 0, 200, 350, 400, 0, 200, 350, $hIA)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_ImageAttributesDispose($hIA)
	_GDIPlus_ImageDispose($hMetafile)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc

; This function creates and saves the sample metafile
Func _CreateTestMetafile($hGraphics)
	Local $hDC, $hMetafile, $hRedBrush, $hRedPen, $hImageContext
	
	; Get the graphics device context that will be associate with the metafile
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)
	
	; Create a Metafile object for recording
	$hMetafile = _GDIPlus_MetafileRecordFileName($sFileName, $hDC)
	
	; Get the image graphics context, any drawing is persisted to the metafile
	$hImageContext = _GDIPlus_ImageGetGraphicsContext($hMetafile)
	
	; Record a filled red rectangle
	$hRedBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000) ; Red
	_GDIPlus_GraphicsFillRect($hImageContext, 0, 0, 200, 175, $hRedBrush)
	
	; Record another action by drawing an ellipse using a red pen
	$hRedPen = _GDIPlus_PenCreate(0xFFFF0000, 5)
	_GDIPlus_GraphicsDrawEllipse($hImageContext, 0, 175, 200, 175, $hRedPen)
	
	; Release the device context
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)
	
	; Now save metafile
	_GDIPlus_GraphicsDispose($hImageContext) ; Image persisted and exclusive lock is unlocked
	
	; Clean up
	_GDIPlus_PenDispose($hRedPen)
	_GDIPlus_BrushDispose($hRedBrush)
	_GDIPlus_ImageDispose($hMetafile)
EndFunc

; This function creates a ColorMatrix structure that convert red colors to green
Func _ColorMatrixCreateRedToGreen()
	Local $tColorMatrix
	
	$tColorMatrix = _GDIPlus_ColorMatrixCreate()
	DllStructSetData($tColorMatrix, "m", 0, 1) ; Scaling factor of red component is 0 (nothing)
	DllStructSetData($tColorMatrix, "m", 1, 2) ; Scaling factor of green component of the red channel is 1 (red becomes green)
	
	Return $tColorMatrix
EndFunc