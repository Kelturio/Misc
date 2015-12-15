#include-once
#include <GDIP.au3>
#include <Memory.au3>

_GDIPlus_Startup()

; Use gif encoder to save image to stream
Global Const $__GIF_tCLSID = _WinAPI_GUIDFromString(_GDIPlus_EncodersGetCLSID("gif"))
Global Const $__GIF_pCLSID = DllStructGetPtr($__GIF_tCLSID)

; Application and Graphics extension blocks used in subsequent frames
Global $__GIF_tGfxEx, $__GIF_bGfxEx
Global $__GIF_tAppEx, $__GIF_bAppEx

_GIF_InitializeVars()

; $iRepeat = 0, repeat GIF indefinitely
Func _GIF_CreateAnimatedGIF($sFilename, $hFirstFrame, $iRepeat = 0)
	Local $hGIFFile = FileOpen($sFilename, 18) ; binary + erase
	If $hGIFFile = 0 Then Return SetError(1, 0, False)

	Local $pStream, $hMemory, $pMemory, $iMemSize
	Local $tImageData, $bImageData
	Local $iLow = $iRepeat, $iHigh = 0
	Local $fOk

	$pStream = _WinAPI_CreateStreamOnHGlobal()
	$fOk = _GDIPlus_ImageSaveToStream($hFirstFrame, $pStream, $__GIF_pCLSID)

	If $fOk Then
		$hMemory  = _WinAPI_GetHGlobalFromStream($pStream)
		$iMemSize = _MemGlobalSize($hMemory)
		$hMemory  = _MemGlobalAlloc($iMemSize, $GMEM_MOVEABLE)
		$pMemory  = _MemGlobalLock($hMemory)
		_MemGlobalUnlock($hMemory)

		$pStream = _WinAPI_CreateStreamOnHGlobal($pMemory)
		_GDIPlus_ImageSaveToStream($hFirstFrame, $pStream, $__GIF_pCLSID)

		$tImageData = DllStructCreate("byte[" & $iMemSize & "]", $pMemory)
		$bImageData = DllStructGetData($tImageData, 1)
		_MemGlobalFree($hMemory)

		If $iRepeat > 255 Then
			$iRepeat = BitAND($iRepeat, 0xFFFF)
			$iLow = BitAND($iRepeat, 0xFF)
			$iHigh = BitShift($iRepeat, 8)
		EndIf

		DllStructSetData($__GIF_tAppEx, 1, $iLow, 17)
		DllStructSetData($__GIF_tAppEx, 1, $iHigh, 18)
		$__GIF_bAppEx = DllStructGetData($__GIF_tAppEx, 1)

		FileWrite($hGIFFile, BinaryMid($bImageData, 1, 781))
		FileWrite($hGIFFile, $__GIF_bAppEx)
		FileWrite($hGIFFile, $__GIF_bGfxEx)
		FileWrite($hGIFFile, BinaryMid($bImageData, 790, BinaryLen($bImageData)-790))

		Return $hGIFFile
	Else
		Return SetError(2, 0, False)
	EndIf
EndFunc

Func _GIF_FileAddFrame($hGIFFile, $hFrame)
	If $hGIFFile = 0 Then Return SetError(1, 0, False)

	Local $pStream, $hMemory, $pMemory, $iMemSize
	Local $tImageData, $bImageData
	Local $fOk

	$pStream = _WinAPI_CreateStreamOnHGlobal()
	$fOk = _GDIPlus_ImageSaveToStream($hFrame, $pStream, $__GIF_pCLSID)

	If $fOk Then
		$hMemory  = _WinAPI_GetHGlobalFromStream($pStream)
		$iMemSize = _MemGlobalSize($hMemory)
		$hMemory  = _MemGlobalAlloc($iMemSize, $GMEM_MOVEABLE)
		$pMemory  = _MemGlobalLock($hMemory)
		_MemGlobalUnlock($hMemory)

		$pStream = _WinAPI_CreateStreamOnHGlobal($pMemory)
		_GDIPlus_ImageSaveToStream($hFrame, $pStream, $__GIF_pCLSID)

		$tImageData = DllStructCreate("byte[" & $iMemSize & "]", $pMemory)
		$bImageData = DllStructGetData($tImageData, 1)
		_MemGlobalFree($hMemory)

		FileWrite($hGIFFile, $__GIF_bGfxEx)
		FileWrite($hGIFFile, BinaryMid($bImageData, 790, BinaryLen($bImageData)-790))

		Return True
	Else
		Return SetError(2, 0, False)
	EndIf
EndFunc

Func _GIF_FileFinalize($hGIFFile)
	If $hGIFFile = 0 Then Return SetError(1, 0, False)
	FileWrite($hGIFFile, ";")
	FileClose($hGIFFile)

	Return True
EndFunc

; 0 = No delay
Func _GIF_SetFrameDelay($iDelay = 0)
	Local $iLow = $iDelay, $iHigh = 0

	If $iDelay > 255 Then
		$iDelay = BitAND($iDelay, 0xFFFF)
		$iLow = BitAND($iDelay, 0xFF)
		$iHigh = BitShift($iDelay, 8)
	EndIf

	DllStructSetData($__GIF_tGfxEx, 1, $iLow, 5)
	DllStructSetData($__GIF_tGfxEx, 1, $iHigh, 6)
	$__GIF_bGfxEx = DllStructGetData($__GIF_tGfxEx, 1)
EndFunc

Func _GIF_SetTransparentColorEntry($iColorEntry = 0)
	DllStructSetData($__GIF_tGfxEx, 1, $iColorEntry, 7)
EndFunc

Func _GIF_InitializeVars()
	$__GIF_tAppEx = DllStructCreate("byte[19]")
	DllStructSetData($__GIF_tAppEx, 1, 33, 1)	; Extension introducer
	DllStructSetData($__GIF_tAppEx, 1, 255, 2)	; Application extension
	DllStructSetData($__GIF_tAppEx, 1, 11, 3)	; size of block
	DllStructSetData($__GIF_tAppEx, 1, 78, 4)	; N
	DllStructSetData($__GIF_tAppEx, 1, 69, 5)	; E
	DllStructSetData($__GIF_tAppEx, 1, 84, 6)	; T
	DllStructSetData($__GIF_tAppEx, 1, 83, 7)	; S
	DllStructSetData($__GIF_tAppEx, 1, 67, 8)	; C
	DllStructSetData($__GIF_tAppEx, 1, 65, 9)	; A
	DllStructSetData($__GIF_tAppEx, 1, 80, 10)	; P
	DllStructSetData($__GIF_tAppEx, 1, 69, 11)	; E
	DllStructSetData($__GIF_tAppEx, 1, 50, 12)	; 2
	DllStructSetData($__GIF_tAppEx, 1, 46, 13)	; .
	DllStructSetData($__GIF_tAppEx, 1, 48, 14)	; 0
	DllStructSetData($__GIF_tAppEx, 1, 3, 15)	; Size of block
	DllStructSetData($__GIF_tAppEx, 1, 1, 16)	;
	DllStructSetData($__GIF_tAppEx, 1, 0, 17)	; Number of repetitions LowByte (0 = repeat indefinitely)
	DllStructSetData($__GIF_tAppEx, 1, 0, 18)	; Number of repetitions HighByte (0 = repeat indefinitely)
	DllStructSetData($__GIF_tAppEx, 1, 0, 19)	; Block terminator

	$__GIF_tGfxEx = DllStructCreate("byte[8]")
	DllStructSetData($__GIF_tGfxEx, 1, 33, 1)	; Extension introducer
	DllStructSetData($__GIF_tGfxEx, 1, 249, 2)	; Graphic control extension
	DllStructSetData($__GIF_tGfxEx, 1, 4, 3)	; Size of block
	DllStructSetData($__GIF_tGfxEx, 1, 9, 4)	; Flags: reserved, disposal method, user input, transparent color
	DllStructSetData($__GIF_tGfxEx, 1, 25, 5)	; Delay time low byte
	DllStructSetData($__GIF_tGfxEx, 1, 0, 6)	; Delay time high byte
	DllStructSetData($__GIF_tGfxEx, 1, 255, 7)	; Transparent color index
	DllStructSetData($__GIF_tGfxEx, 1, 0, 8)	; Block terminator

	$__GIF_bAppEx = DllStructGetData($__GIF_tAppEx, 1)
	$__GIF_bGfxEx = DllStructGetData($__GIF_tGfxEx, 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_CreateStreamOnHGlobal
; Description ...: Creates a stream object that uses an HGLOBAL memory handle to store the stream contents
; Syntax.........: _WinAPI_CreateStreamOnHGlobal([$hGlobal = 0[, $fDeleteOnRelease = True]])
; Parameters ....: $hGlobal 	     - A memory handle. If 0, a new handle is to be allocated instead
;                  $fDeleteOnRelease - If True, the release of the IStream interface releases the memory handle as well.
;                  Otherwise, it's the responsibility of the user to release this memory handle.
; Return values .: Success      - A pointer to new stream object
;                  Failure      - 0
; Remarks .......: None
; Related .......: _MemGlobalFree
; Link ..........; @@MsdnLink@@ CreateStreamOnHGlobal
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $fDeleteOnRelease = True)
	Local $aResult = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", "hwnd", $hGlobal, "int", $fDeleteOnRelease, "ptr*", 0)

	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_WinAPI_CreateStreamOnHGlobal

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_GetHGlobalFromStream
; Description ...: Retrieves the global memory handle to a stream that was previously created
; Syntax.........: _WinAPI_GetHGlobalFromStream($pStream)
; Parameters ....: $pStream - Pointer to the stream object previously created by a call to _WinAPI_CreateStreamOnHGlobal
; Return values .: Success      - The memory handle used by the specified stream object
;                  Failure      - 0
; Remarks .......: None
; Related .......: _WinAPI_CreateStreamOnHGlobal
; Link ..........; @@MsdnLink@@ GetHGlobalFromStream
; Example .......; No
; ===============================================================================================================================
Func _WinAPI_GetHGlobalFromStream($pStream)
	Local $aResult = DllCall("ole32.dll", "int", "GetHGlobalFromStream", "ptr", $pStream, "ptr*", 0)

	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[2]
EndFunc   ;==>_WinAPI_GetHGlobalFromStream