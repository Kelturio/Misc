#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

Global $sText

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hDC, $hBrush, $hImageGraphics, $hMetafile, $pData, $tData, $iData, $sFileName, $hCallback, $pCallback
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$sFileName = @MyDocumentsDir & "\SampleMeta.emf"
	
	$hGUI = GUICreate("_GDIPlus_GraphicsComment Example", 400, 350)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Get the graphics device context that will be associate with the metafile
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)
	
	; Create a Metafile object for recording
	$hMetafile = _GDIPlus_MetafileRecordFileName($sFileName, $hDC)
	
	; Get the image graphics context, any drawing is persisted to the metafile
	$hImageGraphics = _GDIPlus_ImageGetGraphicsContext($hMetafile)
	
	; Record a semi-transparent filled green rectangle
	$hBrush = _GDIPlus_BrushCreateSolid(0x8000FF00) ; Semi-transparent green
	_GDIPlus_GraphicsFillRect($hImageGraphics, 0, 0, 200, 200, $hBrush)

	; Create the comment data
	$tData = DllStructCreate("char[9]")
	$pData = DllStructGetPtr($tData)
	$iData = 9
	DllStructSetData($tData, 1, "AutoIt v3")
	
	; Add a comment to the metafile
	_GDIPlus_GraphicsComment($hImageGraphics, $pData, $iData)
	
	; Record another action by filling an ellipse and adding additional comment
	_GDIPlus_BrushSetFillColor($hBrush, 0x80FF00FF)
	_GDIPlus_GraphicsFillEllipse($hImageGraphics, 200, 0, 150, 200, $hBrush)
	; Change the comment
	DllStructSetData($tData, 1, "Commented")
	_GDIPlus_GraphicsComment($hImageGraphics, $pData, $iData)
	
	; Release the device context
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)
	
	; Now save metafile
	_GDIPlus_GraphicsDispose($hImageGraphics) ; Image persisted and exclusive lock is unlocked
	_GDIPlus_ImageDispose($hMetafile)
	
	; Create the enumeration callback function to call for each record in the metafile
	$hCallback = DllCallbackRegister("_MetafileEnum", "int", "int;uint;uint;ptr;ptr")
	$pCallback = DllCallbackGetPtr($hCallback)
	
	; Create a Metafile object from the sample metafile file and start playing the records
	$hMetafile = _GDIPlus_MetafileCreateFromFile($sFileName)
	
	; Start enumerating the metafile records
	_GDIPlus_MetafileEnumerateDestPoint($hGraphics, $hMetafile, 0, 0, $pCallback, $hMetafile)
	
	; Draw the comments
	_GDIPlus_GraphicsDrawString($hGraphics, $sText, 20, 20)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	DllCallbackFree($pCallback)
	_GDIPlus_ImageDispose($hMetafile)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc

; $iRecordType - One of the predefined record type (ellipse, rectangle, comment, etc..)
; $iFlags	   - Set of flags that specify attributes of the record
; $iDataSize   - Number of bytes in the record data
; $pRecordData - Pointer to a buffer that contains the record data
; $pUserData   - The user defined data previously passed to the one of the Metafile enumeration functions

; Return False to abort the enumeration, True to proceed.
Func _MetafileEnum($iRecordType, $iFlags, $iDataSize, $pRecordData, $pUserData)
	Local $tText
	
	; Play only the ellipse and the comments
	Switch $iRecordType
		; Filled ellipse
		Case $GDIP_EMFPLUSRECORDTYPEFILLELLIPSE
			_GDIPlus_MetafilePlayRecord($pUserData, $iRecordType, $iFlags, $iDataSize, $pRecordData)
			
		Case $GDIP_EMFPLUSRECORDTYPECOMMENT
			$tText = DllStructCreate("char[" & $iDataSize & "]", $pRecordData)
			$sText &= DllStructGetData($tText, 1) & @CRLF
	EndSwitch
		
	; Continue to enumerate
	Return True
EndFunc