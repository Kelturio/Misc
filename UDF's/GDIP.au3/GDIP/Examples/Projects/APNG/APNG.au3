#include-once
#include <Array.au3>
#include <CRC32.au3>
#include <GDIP.au3>
#include <Memory.au3>

_GDIPlus_Startup()

; AreaDisposal
Global Const $APNG_DISPOSE_OP_NONE = 0 ; No disposal is done
Global Const $APNG_DISPOSE_OP_BACKGROUND = 1 ; Dispose background
Global Const $APNG_DISPOSE_OP_PREVIOUS = 2 ; Dispose to the previous buffer content

; AreaRendering
Global Const $APNG_BLEND_OP_SOURCE = 0 ; Overwrite the current contents of the frame's output buffer
Global Const $APNG_BLEND_OP_OVER = 1 ; Composite onto the output buffer based on its alpha


; Animation control chunk
Global Const $__APNG_tagACTL = "uint FrameCount;uint LoopCount"
; Frame control chunk
Global Const $__APNG_tagFCTL = "uint FrameId;uint Width;uint Height;uint xOffset;uint yOffset;word DelayNumerator;word DelayDenominator;byte AreaDisposal;byte AreaRendering"
; Frame data chunk
;~ Global Const $__APNG_tagFDAT = "uint FrameId;byte Data[0]"

Global Enum $__APNG_PNG, $__APNG_IHDR, $__APNG_FCTL, $__APNG_IEND, $__APNG_Data, $__APNG_Width, $__APNG_Height, $__APNG_Repeat, $__APNG_Counter, $__APNG_FCounter, $__APNG_MaxIndex

Global Const $__APNG_tCLSID = _WinAPI_GUIDFromString(_GDIPlus_EncodersGetCLSID("png"))
Global Const $__APNG_pCLSID = DllStructGetPtr($__APNG_tCLSID)


Func _APNG_CreateObject($iRepeat = 0)
	Local $avAPNG[$__APNG_MaxIndex]

	$tfcTL = __InitFCTL(0, 0, 0, 0, 0, 0, 1000, $APNG_DISPOSE_OP_BACKGROUND, $APNG_BLEND_OP_SOURCE)

	If $iRepeat < 0 Then $iRepeat = 0

	$avAPNG[$__APNG_PNG]		= 0
	$avAPNG[$__APNG_IHDR]		= 0
	$avAPNG[$__APNG_FCTL]		= $tfcTL
	$avAPNG[$__APNG_IEND]		= 0
	$avAPNG[$__APNG_Data]		= 0
	$avAPNG[$__APNG_Width]		= 0
	$avAPNG[$__APNG_Height]		= 0
	$avAPNG[$__APNG_Repeat]		= $iRepeat
	$avAPNG[$__APNG_Counter]	= 0
	$avAPNG[$__APNG_FCounter]	= 0

	Return $avAPNG
EndFunc

Func _APNG_AddFrame(ByRef $avAPNG, $hImage, $iDelay = 0, $iWidth = 0, $iHeight = 0, $ixOffset = 0, $iyOffset = 0, $iAreaDisposal = 1, $iAreaRendering = 1)

	If UBound($avAPNG) <> $__APNG_MaxIndex Then Return SetError(1, 0, False)

	Local $pStream, $hMemory, $pMemory, $iMemSize, $tBuffer, $xBuffer
	Local $xfcTL, $xIDAT, $tfdAT, $xfdAT, $iCounter, $iSize
	Local $iW, $iH, $iFW, $iFH
	Local $fOk

	$pStream = _WinAPI_CreateStreamOnHGlobal()
	$fOk = _GDIPlus_ImageSaveToStream($hImage, $pStream, $__APNG_pCLSID)

	If $fOk Then
		$hMemory  = _WinAPI_GetHGlobalFromStream($pStream)
		$iMemSize = _MemGlobalSize($hMemory)
		$hMemory  = _MemGlobalAlloc($iMemSize, $GMEM_MOVEABLE)
		$pMemory  = _MemGlobalLock($hMemory)
		_MemGlobalUnlock($hMemory)

		$pStream = _WinAPI_CreateStreamOnHGlobal($pMemory)
		_GDIPlus_ImageSaveToStream($hImage, $pStream, $__APNG_pCLSID)

		$tBuffer = DllStructCreate("byte[" & $iMemSize & "]", $pMemory)
		$xBuffer = DllStructGetData($tBuffer, 1)
		_MemGlobalFree($hMemory)

		$iCounter = $avAPNG[$__APNG_Counter]

		If $iCounter <> 0 Then ; Add the next frame and update counters

			$iW = $avAPNG[$__APNG_Width]
			$iH = $avAPNG[$__APNG_Height]

			If $iWidth > 0 And $iWidth < $iW Then
				DllStructSetData($avAPNG[$__APNG_FCTL], "Width", $iWidth)
			Else
				DllStructSetData($avAPNG[$__APNG_FCTL], "Width", $iW)
			EndIf

			If $iHeight > 0 And $iHeight < $iH Then
				DllStructSetData($avAPNG[$__APNG_FCTL], "Height", $iHeight)
			Else
				DllStructSetData($avAPNG[$__APNG_FCTL], "Height", $iH)
			EndIf

			If ($ixOffset + $iWidth)  > $iW Then $ixOffset = 0
			if ($iyOffset + $iHeight) > $iH Then $iyOffset = 0

			DllStructSetData($avAPNG[$__APNG_FCTL], "FrameId", $iCounter)
			DllStructSetData($avAPNG[$__APNG_FCTL], "xOffset", $ixOffset)
			DllStructSetData($avAPNG[$__APNG_FCTL], "yOffset", $iyOffset)
			DllStructSetData($avAPNG[$__APNG_FCTL], "DelayNumerator", $iDelay)
			DllStructSetData($avAPNG[$__APNG_FCTL], "AreaDisposal", $iAreaDisposal)
			DllStructSetData($avAPNG[$__APNG_FCTL], "AreaRendering", $iAreaRendering)

			$xfcTL = __Serialize_FCTL($avAPNG[$__APNG_FCTL])
			$iCounter += 1

			$xIDAT = __GetIDAT($xBuffer)
			$iSize = Dec(Hex(BinaryMid($xIDAT, 1, 4)))
			$tfdAT = DllStructCreate("uint FrameId;byte Data[" & $iSize & "]")
			DllStructSetData($tfdAT, "FrameId", $iCounter)
			DllStructSetData($tfdAT, "Data", BinaryMid($xIDAT, 9, $iSize))

			$xfdAT = __Serialize_FDAT($tfdAT, $iSize)
			$iCounter += 1
			$avAPNG[$__APNG_Data]		= Binary($avAPNG[$__APNG_Data] & $xfcTL & $xfdAT)
			$avAPNG[$__APNG_Counter]  	= $iCounter
			$avAPNG[$__APNG_FCounter]  += 1

		Else ; Create the first frame, update counters and store headers

			Local $xPNG, $xIHDR, $xiEND

			$xPNG = BinaryMid($xBuffer, 1, 8)
			$xIHDR = BinaryMid($xBuffer, 9, 25)
			$xiEND = BinaryMid($xBuffer, BinaryLen($xBuffer)-11)
			$iW = Dec(Hex(BinaryMid($xIHDR, 9, 4)))
			$iH = Dec(Hex(BinaryMid($xIHDR, 13, 4)))
			$xIDAT = __GetIDAT($xBuffer)

			If $iWidth > 0 And $iWidth < $iW Then
				DllStructSetData($avAPNG[$__APNG_FCTL], "Width", $iWidth)
			Else
				DllStructSetData($avAPNG[$__APNG_FCTL], "Width", $iW)
			EndIf

			If $iHeight > 0 And $iHeight < $iH Then
				DllStructSetData($avAPNG[$__APNG_FCTL], "Height", $iHeight)
			Else
				DllStructSetData($avAPNG[$__APNG_FCTL], "Height", $iH)
			EndIf

			If ($ixOffset + $iWidth)  > $iW Then $ixOffset = 0
			if ($iyOffset + $iHeight) > $iH Then $iyOffset = 0

			DllStructSetData($avAPNG[$__APNG_FCTL], "FrameId", 0)
			DllStructSetData($avAPNG[$__APNG_FCTL], "xOffset", $ixOffset)
			DllStructSetData($avAPNG[$__APNG_FCTL], "yOffset", $iyOffset)
			DllStructSetData($avAPNG[$__APNG_FCTL], "DelayNumerator", $iDelay)
			DllStructSetData($avAPNG[$__APNG_FCTL], "AreaDisposal", $iAreaDisposal)
			DllStructSetData($avAPNG[$__APNG_FCTL], "AreaRendering", $iAreaRendering)

			$xfcTL = __Serialize_FCTL($avAPNG[$__APNG_FCTL])
			$avAPNG[$__APNG_PNG]		= $xPNG
			$avAPNG[$__APNG_IHDR]		= $xIHDR
			$avAPNG[$__APNG_IEND]		= $xiEND
			$avAPNG[$__APNG_Data]		= Binary($xfcTL & $xIDAT)
			$avAPNG[$__APNG_Width] 		= $iW
			$avAPNG[$__APNG_Height] 	= $iH
			$avAPNG[$__APNG_Counter]	= 1
			$avAPNG[$__APNG_FCounter]	= 1

		EndIf
	Else
		Return SetError(2, 0, False)
	EndIf

	Return SetError(0, 0, True)
EndFunc

Func _APNG_SaveToFile(ByRef $avAPNG, $sFilename, $fFreeArray = True)

	If UBound($avAPNG) <> $__APNG_MaxIndex Then Return SetError(1, 0, 0)


	Local $hFile, $xFile, $tacTL, $xacTL
	Local $xPNG, $xIHDR, $xData, $xiEND
	Local $iFCounter, $iRepeat

	If __IsValidObject($avAPNG) Then
		Local $hFile = FileOpen($sFilename, 18)
		If $hFile = 0 Then Return SetError(3, 0, False) ; Cannot open file

		$xPNG 		= $avAPNG[$__APNG_PNG]
		$xIHDR		= $avAPNG[$__APNG_IHDR]
		$xData		= $avAPNG[$__APNG_Data]
		$xiEND		= $avAPNG[$__APNG_IEND]
		$iRepeat	= $avAPNG[$__APNG_Repeat]
		$iFCounter	= $avAPNG[$__APNG_FCounter]

		$tacTL = __InitACTL($iFCounter, $iRepeat)
		$xacTL = __Serialize_ACTL($tacTL)
		$xFile = Binary($xPNG & $xIHDR & $xacTL & $xData & $xiEND)

		FileWrite($hFile, $xFile)
		FileClose($hFile)
	Else
		Return SetError(2, 0, False) ; Object is not valid
	EndIf

	If $fFreeArray Then $avAPNG = 0

	Return SetError(0, 0, True)
EndFunc


#region Internal Use Only

Func __InitACTL($iFrameCount, $iLoopCount = 0)
	Local $tacTL = DllStructCreate($__APNG_tagACTL)
	DllStructSetData($tacTL, "FrameCount", $iFrameCount)
	DllStructSetData($tacTL, "LoopCount", $iLoopCount)

	Return $tacTL
EndFunc

Func __IsValidObject(ByRef $avAPNG)
	If $avAPNG[$__APNG_PNG] == "" Or _
	   $avAPNG[$__APNG_IHDR] == "" Or _
	   $avAPNG[$__APNG_IEND] == "" Or _
	   $avAPNG[$__APNG_Data] == "" Or _
	   $avAPNG[$__APNG_Counter] = 0 Or _
	   $avAPNG[$__APNG_FCounter] = 0 Or _
	   IsDllStruct($avAPNG[$__APNG_FCTL]) = 0 Then Return False

	Return True
EndFunc

Func __InitFCTL($iFrameId, $iW, $iH, $ixOffset, $iyOffset, $iwDelayNumerator, $iwDelayDenominator, $iAreaDisposal = 1, $iAreaRendering = 1)
	Local $tfcTL = DllStructCreate($__APNG_tagFCTL)
	DllStructSetData($tfcTL, "FrameId", $iFrameId)
	DllStructSetData($tfcTL, "Width", $iW)
	DllStructSetData($tfcTL, "Height", $iH)
	DllStructSetData($tfcTL, "xOffset", $ixOffset)
	DllStructSetData($tfcTL, "yOffset", $iyOffset)
	DllStructSetData($tfcTL, "DelayNumerator", $iwDelayNumerator)
	DllStructSetData($tfcTL, "DelayDenominator", $iwDelayDenominator)
	DllStructSetData($tfcTL, "AreaDisposal", $iAreaDisposal)
	DllStructSetData($tfcTL, "AreaRendering", $iAreaRendering)

	Return $tfcTL
EndFunc

Func __Serialize_ACTL($tStruct)
	If Not IsDllStruct($tStruct) Then Return SetError(1, 0, 0)

	Local $xRet = "6163544c" & StringFormat("%08x%08x", DllStructGetData($tStruct, 1) , DllStructGetData($tStruct, 2))
	Return Binary("0x00000008" & $xRet & Hex(_CRC32("0x" & $xRet)))
EndFunc

Func __Serialize_FCTL($tStruct)
	If Not IsDllStruct($tStruct) Then Return SetError(1, 0, 0)
	Local $a[9]
	For $i = 1 To 9
		$a[$i-1] = DllStructGetData($tStruct, $i)
	Next

	Local $xRet = "6663544c" & StringFormat("%08x%08x%08x%08x%08x%04x%04x%02x%02x", $a[0], $a[1], $a[2], $a[3], $a[4], $a[5], $a[6], $a[7], $a[8])
	Return Binary("0x0000001a" & $xRet & Hex(_CRC32("0x" & $xRet)))
EndFunc

Func __Serialize_FDAT($tStruct, $iDataSize)
	If Not IsDllStruct($tStruct) Then Return SetError(1, 0, 0)

	Local $xRet = "66644154" & StringFormat("%08x", DllStructGetData($tStruct, 1)) & StringTrimLeft(DllStructGetData($tStruct, 2), 2)
	Return Binary("0x" & Hex(4+$iDataSize) & $xRet & Hex(_CRC32("0x" & $xRet)))
EndFunc

Func __GetIDAT($xData)
	Local $iLen = BinaryLen($xData)
	If $iLen = 0 Then Return SetError(1, 0, 0)

	Local $iFrames, $iSize, $iTotalSize, $sType, $fFound = False, $iPos = 34
	Local $xIDAT = "49444154"

	While $iPos < $iLen
		$iSize = Dec(Hex(BinaryMid($xData, $iPos, 4)))
		If $iSize = 0 Then ExitLoop

		$sType = BinaryToString(BinaryMid($xData, $iPos+4, 4))
		If $sType = "IDAT" Then
			$xIDAT &= StringTrimLeft(BinaryMid($xData, $iPos+8, $iSize), 2)
			$iTotalSize += $iSize
			$fFound = True
		ElseIf $fFound Then
			ExitLoop
		EndIf

		$iPos += $iSize+12
	WEnd

	If Not $fFound Then Return SetError(2, 0, 0)
	Return Binary("0x" & Hex($iTotalSize) & $xIDAT & Hex(_CRC32("0x" & $xIDAT)))
EndFunc

#endregion Internal Use Only


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