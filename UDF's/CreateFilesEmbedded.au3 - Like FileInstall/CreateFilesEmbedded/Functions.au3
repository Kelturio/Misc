#include-once
; #INDEX# =======================================================================================================================
; Title .........: CreateFilesEmbedded™
; Module ........: Functions
; Author ........: João Carlos (jscript) - (C) DVI-Informática 2011.9-2012.9, dvi-suporte@hotmail.com
; Support .......:
; AutoIt Version.: 3.3.0.0++
; Language ......: English
; Description ...: Template for create files embedded in your escript.
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _LoadOSLang
; Description ...: Load language file.
; Syntax ........: _LoadOSLang(  )
; Parameters ....:
; Return values .: Success		- Returns None
;				   Failure		- Returns None
; Author ........: João Carlos (Jscript FROM Brazil)
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: _LoadOSLang(  )
; ===============================================================================================================================
Func _LoadOSLang($sLangPath)
	Local $asFileList

	$asFileList = _FileListToArray($sLangPath, "language.*", 1)
	If @error Then
		Return _DefaultLang()
	EndIf

	For $i = 1 To $asFileList[0]
		$asOSLang = IniReadSection($sLangPath & "\" & $asFileList[$i], @OSLang)
		If Not @error Then ExitLoop
	Next
	If @error Then
		Return _DefaultLang()
	EndIf
	ReDim $asOSLang[48][2]
EndFunc   ;==>_LoadOSLang

; #FUNCTION# ====================================================================================================================
; Module ........: Language
; Author ........: Reaper HGN
; Link ..........: http://www.autoitscript.com/forum/topic/132564-createfilesembeddedau3-like-fileinstall/#entry930932
; Language ......: English (United States)
; ===============================================================================================================================
Func _DefaultLang()
	Dim $asOSLang[48][2]

	$asOSLang[0][0] = 48
	$asOSLang[1][1] = "Options for the output file."
	$asOSLang[2][1] = "Create a function based on the output name."
	$asOSLang[3][1] = "Adding patterns of User Defined Functions (UDF)."
	$asOSLang[4][1] = "Only create the output file with the binary."
	$asOSLang[5][1] = "Adding native LZNT Windows compression."
	$asOSLang[6][1] = "Compression level"
	$asOSLang[7][1] = "&Open File"
	$asOSLang[8][1] = "Embedding file"
	$asOSLang[9][1] = "Test"
	$asOSLang[10][1] = "Default"
	$asOSLang[11][1] = "Conversion progress:"
	$asOSLang[12][1] = "Exit"
	$asOSLang[13][1] = "Converted Lines"
	$asOSLang[14][1] = "Choose a file to embed:"
	$asOSLang[15][1] = "The file"
	$asOSLang[16][1] = "no exist!"
	$asOSLang[17][1] = 'The test only with the option: "Create a function based on the output name" activated!'
	$asOSLang[18][1] = "Wait, creating the file. AU3 ->"
	$asOSLang[19][1] = "Save the file as built"
	$asOSLang[20][1] = "Compressing the file, wait..."
	$asOSLang[21][1] = "Done!"
	$asOSLang[22][1] = "The file"
	$asOSLang[23][1] = "was embedded in the format .AU3!"
EndFunc   ;==>_DefaultLang

; #FUNCTION# ====================================================================================================================
; Name ..........: _CtrlRead
; Description ...:
; Syntax ........: _CtrlRead( $iCltrlID , $vTypeRead  )
; Parameters ....: $iCltrlID            - A integer value.
;                  $vTypeRead           - A variant value.
; Return values .: None
; Author(s) .....: João Carlos (Jscript FROM Brazil)
; ===============================================================================================================================
Func _CtrlRead($iCltrlID, $vTypeRead)
	If GUICtrlRead($iCltrlID) = $vTypeRead Then Return 1
	Return 0
EndFunc   ;==>_CtrlRead

; #FUNCTION# ====================================================================================================================
; Name ..........: _EmbeddedFile
; Description ...:
; Syntax ........: _EmbeddedFile( )
; Parameters ....: none
; Return values .: None
; Author(s) .....: João Carlos (Jscript FROM Brazil)
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _EmbeddedFile()
	Local $hFileOpen, $bFileRead, $iBufferSize, $Slash
	Local $sCurrLine, $iCount = 1
	Local $iProgressStep = 0, $iProgress = 0

	$hSaveAu3File = FileSaveDialog($asOSLang[19][1], "", "au3 script (*.au3)", 18, $sFileName & ".au3")
	If @error Then Return 0

	$Slash = StringInStr($hSaveAu3File, "\", 0, -1)
	If Not StringInStr(StringTrimLeft($hSaveAu3File, $Slash), ".") Then $hSaveAu3File &= ".au3"
	If FileExists($hSaveAu3File) Then FileDelete($hSaveAu3File)
	;
	$sFunctionName = StringStripWS(StringReplace(StringReplace(StringTrimRight(StringTrimLeft( _
			$hSaveAu3File, $Slash), 4), "-", ""), ".", ""), 8)
	$hSaveAu3File = FileOpen($hSaveAu3File, 2)
	;
	If $iUDFDefault And $iFuncOutType = 2 And $asOSLang[25][1] = "" Then
		FileWriteLine($hSaveAu3File, "#include-once")
		FileWriteLine($hSaveAu3File, "; #INDEX# =======================================================================================================================")
		FileWriteLine($hSaveAu3File, "; Title .........: _" & $sFunctionName & "()")
		FileWriteLine($hSaveAu3File, "; AutoIt Version.: " & @AutoItVersion)
		FileWriteLine($hSaveAu3File, "; Language.......: " & _WinAPI_GetLocaleInfo(Dec(@OSLang), $LOCALE_SLANGUAGE) & " - " & _
				@OSLang & "(" & _WinAPI_GetLocaleInfo(Dec(@OSLang), $LOCALE_SABBREVLANGNAME) & ")")
		FileWriteLine($hSaveAu3File, "; Description ...: Compressed file embedded")
		FileWriteLine($hSaveAu3File, "; Author ........: " & @UserName)
		FileWriteLine($hSaveAu3File, "; ===============================================================================================================================")
		FileWriteLine($hSaveAu3File, "")
		FileWriteLine($hSaveAu3File, "; #CURRENT# =====================================================================================================================")
		FileWriteLine($hSaveAu3File, "; " & "_" & $sFunctionName & "()")
		FileWriteLine($hSaveAu3File, "; ===============================================================================================================================")
		FileWriteLine($hSaveAu3File, "")
		FileWriteLine($hSaveAu3File, "; #INTERNAL_USE_ONLY# ===========================================================================================================")
		If $iIsLZNT Then FileWriteLine($hSaveAu3File, "; __" & $sFunctionName & "()" & " ; _LZNTDecompress renamed!")
		FileWriteLine($hSaveAu3File, "; __" & $sFunctionName & "B64()" & " ; _Base64 renamed!")
		FileWriteLine($hSaveAu3File, "; ===============================================================================================================================")
		FileWriteLine($hSaveAu3File, "")
		FileWriteLine($hSaveAu3File, "; #VARIABLES# ===================================================================================================================")
		FileWriteLine($hSaveAu3File, "; ===============================================================================================================================")
		FileWriteLine($hSaveAu3File, "")
		FileWriteLine($hSaveAu3File, "; #FUNCTION# ====================================================================================================================")
		FileWriteLine($hSaveAu3File, "; Name ..........: _" & $sFunctionName & "()")
		FileWriteLine($hSaveAu3File, "; Description ...: Compressed file embedded in your .au3 file")
		FileWriteLine($hSaveAu3File, '; Syntax ........: _' & $sFunctionName & '( [ lToSave [, sPath [, lExecute ]]] )')
		FileWriteLine($hSaveAu3File, "; Parameters ....: lToSave             - [optional] If True, save the file, else, return binary data. Default is False.")
		FileWriteLine($hSaveAu3File, ";                  sPath               - [optional] The path of the file to be save. Default is @TempDir")
		FileWriteLine($hSaveAu3File, ";                  lExecute            - [optional] Flag to execute file saved. Default is False")
		FileWriteLine($hSaveAu3File, "; Return values .: Success             - Returns decompressed " & $sFileName & $sFileExt & " binary data or saved.")
		FileWriteLine($hSaveAu3File, ";				     Failure             - Returns 0 and set @error to 1.")
		FileWriteLine($hSaveAu3File, "; Author(s) .....: João Carlos (Jscript FROM Brazil)")
		FileWriteLine($hSaveAu3File, "; Modified ......: ")
		If $iIsLZNT Then
			FileWriteLine($hSaveAu3File, "; Remarks .......: This function uses _LZNTDecompress() and _Base64Decode() by trancexx.")
		Else
			FileWriteLine($hSaveAu3File, "; Remarks .......: This function uses _Base64Decode() by trancexx.")
		EndIf
		FileWriteLine($hSaveAu3File, "; Related .......: ")
		FileWriteLine($hSaveAu3File, "; Link ..........: ")
		FileWriteLine($hSaveAu3File, "; Example .......; _" & $sFunctionName & "()")
		FileWriteLine($hSaveAu3File, "; ===============================================================================================================================")
	EndIf
	If $iFuncOutType = 2 Then
		FileWriteLine($hSaveAu3File, "Func _" & $sFunctionName & "( $lToSave = False, $sPath = @TempDir, $lExecute = False )")
		FileWriteLine($hSaveAu3File, '	Local $hFileHwnd, $bData, $sFileName = $sPath & "\' & $sFileName & $sFileExt & '"')
		FileWriteLine($hSaveAu3File, "")
	EndIf

	If $iIsLZNT = 1 Then
		GUICtrlSetData($iLbl_LineCnv, $asOSLang[20][1])
		; Use UPX if file is PE executable.
		GUICtrlSetData($iPrg_Convert, Random(5, 45, 1))
		If $iUpxIng Then RunWait(_UpxLibrary(True) & " -9 -q -f " & FileGetShortName($sSelectFile), "", @SW_HIDE)
		; Use LZNT native compression.
		GUICtrlSetData($iPrg_Convert, GUICtrlRead($iPrg_Convert) + Random(25, 70, 1))
		$hFileOpen = FileOpen($sSelectFile, 16)
		$bFileRead = FileRead($hFileOpen)
		$bFileRead = StringReplace(_Base64Encode(_LZNTCompress($bFileRead, $iLZNTValue)), @CRLF, "")
		$iBufferSize = BinaryLen($bFileRead)
		For $i = GUICtrlRead($iPrg_Convert) To 100
			GUICtrlSetData($iPrg_Convert, $i)
			Sleep(Random(50, 250, 1))
		Next
	Else
		$hFileOpen = FileOpen($sSelectFile, 16)
		$bFileRead = FileRead($hFileOpen)
		If $iFuncOutType <> 4 Then
			$bFileRead = StringReplace(_Base64Encode($bFileRead), @CRLF, "")
		EndIf
		$iBufferSize = BinaryLen($bFileRead)
	EndIf
	FileWriteLine($hSaveAu3File, '	; Original: ' & $sSelectFile)
	;
	$iProgressStep = 100 / Int(StringLen($bFileRead) / 501)
	GUICtrlSetData($iPrg_Convert, 0)
	While 1
		$sCurrLine = StringMid($bFileRead, $iCount * 501 - 500, 501)
		If $sCurrLine = "" Then ExitLoop
		If $iCount = 1 Then
			FileWriteLine($hSaveAu3File, '	$bData = "' & $sCurrLine & '"')
		Else
			FileWriteLine($hSaveAu3File, '	$bData &= "' & $sCurrLine & '"')
		EndIf
		$iCount += 1
		$iProgress += $iProgressStep
		GUICtrlSetData($iPrg_Convert, Int($iProgress))
		GUICtrlSetData($iLbl_LineCnv, $iCount)
	WEnd
	If $iFuncOutType = 2 Then
		FileWriteLine($hSaveAu3File, "")
		FileWriteLine($hSaveAu3File, '	If $lToSave Then')
		FileWriteLine($hSaveAu3File, '		$hFileHwnd = FileOpen($sFileName, 10)')
		FileWriteLine($hSaveAu3File, '		If @error Then Return SetError(1, 0, 0)')
		If $iIsLZNT Then
			FileWriteLine($hSaveAu3File, '		FileWrite($hFileHwnd, __' & $sFunctionName & '(__' & $sFunctionName & 'B64($bData, ' & $iBufferSize & ')))')
		Else
			FileWriteLine($hSaveAu3File, '		FileWrite($hFileHwnd, __' & $sFunctionName & 'B64($bData, ' & $iBufferSize & '))')
		EndIf
		FileWriteLine($hSaveAu3File, '		FileClose($hFileHwnd)')
		FileWriteLine($hSaveAu3File, '		If $lExecute Then')
		FileWriteLine($hSaveAu3File, '			RunWait($sFileName, "")')
		FileWriteLine($hSaveAu3File, '			FileDelete($sFileName)')
		FileWriteLine($hSaveAu3File, '			Return 1')
		FileWriteLine($hSaveAu3File, '		EndIf')
		FileWriteLine($hSaveAu3File, '		If FileExists($sFileName) Then Return $sFileName')
		FileWriteLine($hSaveAu3File, '	Else')
		If $iIsLZNT Then
			FileWriteLine($hSaveAu3File, '		Return __' & $sFunctionName & '(__' & $sFunctionName & 'B64($bData, ' & $iBufferSize & '))')
		Else
			FileWriteLine($hSaveAu3File, '		Return __' & $sFunctionName & 'B64($bData, ' & $iBufferSize & ')')
		EndIf
		FileWriteLine($hSaveAu3File, '	EndIf')
		FileWriteLine($hSaveAu3File, '')
		FileWriteLine($hSaveAu3File, '	Return SetError(1, 0, 0)')
		FileWriteLine($hSaveAu3File, "EndFunc   ;==>_" & $sFunctionName)
		FileWriteLine($hSaveAu3File, "")
		; Base64Decode
		If $iUDFDefault Then
			FileWriteLine($hSaveAu3File, "; #INTERNAL_USE_ONLY# ===========================================================================================================")
			FileWriteLine($hSaveAu3File, '; Name...........: __' & $sFunctionName & 'B64')
			FileWriteLine($hSaveAu3File, '; Description ...: Base64 decode input data.')
			FileWriteLine($hSaveAu3File, '; Syntax.........: __' & $sFunctionName & 'B64' & '($bBinary, $iBufferSize)')
			FileWriteLine($hSaveAu3File, '; Parameters ....: $sInput      - String data to decode')
			FileWriteLine($hSaveAu3File, ';                  $iBufferSize - Buffer size')
			FileWriteLine($hSaveAu3File, '; Return values .: Success - Returns decode binary data.')
			FileWriteLine($hSaveAu3File, ';                          - Sets @error to 0')
			FileWriteLine($hSaveAu3File, ';                  Failure - Returns empty string and sets @error:')
			FileWriteLine($hSaveAu3File, ';                  |1 - Error calculating the length of the buffer needed.')
			FileWriteLine($hSaveAu3File, ';                  |2 - Error decoding.')
			FileWriteLine($hSaveAu3File, '; Author ........: trancexx')
			FileWriteLine($hSaveAu3File, '; Modified ......: João Carlos (Jscript FROM Brazil)')
			FileWriteLine($hSaveAu3File, '; Related .......: _Base64Encode()')
			FileWriteLine($hSaveAu3File, '; ===============================================================================================================================')
		EndIf
		FileWriteLine($hSaveAu3File, 'Func __' & $sFunctionName & 'B64($sInput, $iBufferSize)')
		FileWriteLine($hSaveAu3File, '	Local $struct = DllStructCreate("int")')
		FileWriteLine($hSaveAu3File, '	If Not $iBufferSize Then')
		FileWriteLine($hSaveAu3File, '		Return SetError(1, 0, "") ; error in the length of the buffer needed')
		FileWriteLine($hSaveAu3File, '	EndIf')
		FileWriteLine($hSaveAu3File, '	DllStructSetData($struct, 1, $iBufferSize)')
		FileWriteLine($hSaveAu3File, '	Local $a = DllStructCreate("byte[" & $iBufferSize & "]")')
		FileWriteLine($hSaveAu3File, '	$a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _')
		FileWriteLine($hSaveAu3File, '			"str", $sInput, _')
		FileWriteLine($hSaveAu3File, '			"int", 0, _')
		FileWriteLine($hSaveAu3File, '			"int", 1, _')
		FileWriteLine($hSaveAu3File, '			"ptr", DllStructGetPtr($a), _')
		FileWriteLine($hSaveAu3File, '			"ptr", DllStructGetPtr($struct, 1), _')
		FileWriteLine($hSaveAu3File, '			"ptr", 0, _')
		FileWriteLine($hSaveAu3File, '			"ptr", 0)')
		FileWriteLine($hSaveAu3File, '	If @error Or Not $a_Call[0] Then')
		FileWriteLine($hSaveAu3File, '		Return SetError(2, 0, ""); error decoding')
		FileWriteLine($hSaveAu3File, '	EndIf')
		FileWriteLine($hSaveAu3File, '	Return DllStructGetData($a, 1)')
		FileWriteLine($hSaveAu3File, 'EndFunc   ;==>__' & $sFunctionName & 'B64')
		If $iIsLZNT Then
			FileWriteLine($hSaveAu3File, "")
			; LZNTCompress
			If $iUDFDefault Then
				FileWriteLine($hSaveAu3File, "; #INTERNAL_USE_ONLY# ===========================================================================================================")
				FileWriteLine($hSaveAu3File, '; Name...........: __' & $sFunctionName)
				FileWriteLine($hSaveAu3File, '; Original Name..: _LZNTDecompress')
				FileWriteLine($hSaveAu3File, '; Description ...: Decompresses input data.')
				FileWriteLine($hSaveAu3File, '; Syntax.........: __' & $sFunctionName & '($bBinary)')
				FileWriteLine($hSaveAu3File, '; Parameters ....: $vInput - Binary data to decompress.')
				FileWriteLine($hSaveAu3File, '; Return values .: Success - Returns decompressed binary data.')
				FileWriteLine($hSaveAu3File, ';                          - Sets @error to 0')
				FileWriteLine($hSaveAu3File, ';                  Failure - Returns empty string and sets @error:')
				FileWriteLine($hSaveAu3File, ';                  |1 - Error decompressing.')
				FileWriteLine($hSaveAu3File, '; Author ........: trancexx')
				FileWriteLine($hSaveAu3File, '; Related .......: _LZNTCompress')
				FileWriteLine($hSaveAu3File, '; Link ..........; http://msdn.microsoft.com/en-us/library/bb981784.aspx')
				FileWriteLine($hSaveAu3File, '; ===============================================================================================================================')
			EndIf
			FileWriteLine($hSaveAu3File, 'Func __' & $sFunctionName & '($bBinary)')
			FileWriteLine($hSaveAu3File, '	$bBinary = Binary($bBinary)')
			FileWriteLine($hSaveAu3File, '	Local $tInput = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")')
			FileWriteLine($hSaveAu3File, '	DllStructSetData($tInput, 1, $bBinary)')
			FileWriteLine($hSaveAu3File, '	Local $tBuffer = DllStructCreate("byte[" & 16 * DllStructGetSize($tInput) & "]") ; initially oversizing buffer')
			FileWriteLine($hSaveAu3File, '	Local $a_Call = DllCall("ntdll.dll", "int", "RtlDecompressBuffer", _')
			FileWriteLine($hSaveAu3File, '			"ushort", 2, _')
			FileWriteLine($hSaveAu3File, '			"ptr", DllStructGetPtr($tBuffer), _')
			FileWriteLine($hSaveAu3File, '			"dword", DllStructGetSize($tBuffer), _')
			FileWriteLine($hSaveAu3File, '			"ptr", DllStructGetPtr($tInput), _')
			FileWriteLine($hSaveAu3File, '			"dword", DllStructGetSize($tInput), _')
			FileWriteLine($hSaveAu3File, '			"dword*", 0)')
			FileWriteLine($hSaveAu3File, '')
			FileWriteLine($hSaveAu3File, '	If @error Or $a_Call[0] Then')
			FileWriteLine($hSaveAu3File, '		Return SetError(1, 0, "") ; error decompressing')
			FileWriteLine($hSaveAu3File, '	EndIf')
			FileWriteLine($hSaveAu3File, '')
			FileWriteLine($hSaveAu3File, '	Local $tOutput = DllStructCreate("byte[" & $a_Call[6] & "]", DllStructGetPtr($tBuffer))')
			FileWriteLine($hSaveAu3File, '')
			FileWriteLine($hSaveAu3File, '	Return SetError(0, 0, DllStructGetData($tOutput, 1))')
			FileWriteLine($hSaveAu3File, 'EndFunc   ;==>__' & $sFunctionName)
		EndIf
	EndIf
	FileClose($hFileOpen)
	FileClose($hSaveAu3File)
	Sleep(1000)
	If $iUpxIng Then RunWait(_UpxLibrary(True) & " -d " & FileGetShortName($sSelectFile), "", @SW_HIDE)
	MsgBox(262208, $sTitle & " - " & $asOSLang[21][1], $asOSLang[22][1] &  ' "' & $sFileName & $sFileExt & '" ' & $asOSLang[23][1])

	Return 1
EndFunc   ;==>_EmbeddedFile

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlCreateLink
; Description ...: Emulates an control link.
; Syntax ........: _GUICtrlCreateLink( $sLinkText, $iLeft, $iTop[, $iWidth = -1[, $iHeight = -1]] )
; Parameters ....: $sLinkText           - A string value.
;                  $iLeft               - An integer value.
;                  $iTop                - An integer value.
;                  $iWidth              - [optional] An integer value. Default is -1.
;                  $iHeight             - [optional] An integer value. Default is -1.
; Return values .: Success		- Returns None
;				   Failure		- Returns None
; Author ........: João Carlos (Jscript FROM Brazil)
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: _GUICtrlCreateLink( $sLinkText, $iLeft, $iTop[, $iWidth = -1[, $iHeight = -1]] )
; ===============================================================================================================================
Func _GUICtrlCreateLink($sLinkText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1)
	Local $iLink

	GUICtrlCreateLabel("", $iLeft, $iTop + 13, $iWidth, 1)
	GUICtrlSetBkColor(-1, 0x0000FF)
	$iLink = GUICtrlCreateLabel($sLinkText, $iLeft, $iTop, $iWidth, $iHeight)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetBkColor(-1, -2);$GUI_BKCOLOR_TRANSPARENT
	Return $iLink
EndFunc   ;==>_GUICtrlCreateLink

; #FUNCTION# ====================================================================================================================
; Name...........: _StringSize
; Description ...: Returns the size (in pixels) of an string.
; Syntax.........: _StringSize( "string" [, size [, weight [, fontname ]]] )
; Parameters ....: string	- The string to evaluate the size.
;                  Size 	- [Optional] Fontsize (default is 9).
;                  Weight 	- [Optional] Font weight (default 400 = normal).
;                  FontName	- [Optional] Font to use (OS default GUI font is used if the font is "" or is not found).
; Requirement(s).:
; Return values .: Success 	- Returns a 2-element array containing the following information:
;							$array[0] = Width
;							$array[1] = Height
;				   Failure 	- Returns the same array with 0 and sets @error to 1.
; Author ........: jscript
; Example .......: _StringSize( "Text" )
; ===============================================================================================================================
Func _StrSize($sString, $iSize = 9, $iWeight = 400, $sFontName = "")
	Local $hWnd, $hGuiSwitch, $iCtrlID, $aCtrlSize, $aRetSize[2] = [0, 0]

	$hWnd = GUICreate("StringExInternalWin", 0, 0, 0, 0, BitOR(0x80000000, 0x20000000), BitOR(0x00000080, 0x00000020))
	$hGuiSwitch = GUISwitch($hWnd)

	GUISetFont($iSize, $iWeight, -1, $sFontName, $hWnd)
	$iCtrlID = GUICtrlCreateLabel($sString, 0, 0)

	$aCtrlSize = ControlGetPos($hWnd, "", $iCtrlID)
	GUIDelete($hWnd)
	GUISwitch($hGuiSwitch)

	If IsArray($aCtrlSize) Then
		$aRetSize[0] = $aCtrlSize[2]; Width
		$aRetSize[1] = $aCtrlSize[3]; Height
		Return SetError(0, 0, $aRetSize)
	EndIf
	Return SetError(1, 0, $aRetSize)
EndFunc   ;==>_StrSize

; #FUNCTION# ====================================================================================================================
; Name ..........: _Base64Encode
; Description ...:
; Syntax ........: _Base64Encode( $input )
; Parameters ....: $input               - An integer value.
; Return values .: Success		- Returns None
;				   Failure		- Returns None
; Author ........: trancexx
; Modified ......: João Carlos (Jscript FROM Brazil)
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: _Base64Encode( $input )
; ===============================================================================================================================
Func _Base64Encode($input)
	;$input = Binary($input)
	Local $struct = DllStructCreate("byte[" & BinaryLen($input) & "]")

	DllStructSetData($struct, 1, $input)

	Local $strc = DllStructCreate("int")

	Local $a_Call = DllCall("Crypt32.dll", "int", "CryptBinaryToString", _
			"ptr", DllStructGetPtr($struct), _
			"int", DllStructGetSize($struct), _
			"int", 1, _
			"ptr", 0, _
			"ptr", DllStructGetPtr($strc))

	If @error Or Not $a_Call[0] Then
		Return SetError(1, 0, "") ; error calculating the length of the buffer needed
	EndIf

	Local $a = DllStructCreate("char[" & DllStructGetData($strc, 1) & "]")

	$a_Call = DllCall("Crypt32.dll", "int", "CryptBinaryToString", _
			"ptr", DllStructGetPtr($struct), _
			"int", DllStructGetSize($struct), _
			"int", 1, _
			"ptr", DllStructGetPtr($a), _
			"ptr", DllStructGetPtr($strc))

	If @error Or Not $a_Call[0] Then
		Return SetError(2, 0, ""); error encoding
	EndIf

	Return DllStructGetData($a, 1)
EndFunc   ;==>_Base64Encode

; #FUNCTION# ;===============================================================================
; Name...........: _LZNTCompress
; Description ...: Compresses input data.
; Syntax.........: _LZNTCompress ($vInput [, $iCompressionFormatAndEngine])
; Parameters ....: $vInput - Data to compress.
;                  $iCompressionFormatAndEngine - Compression format and engine type. Default is 2 (standard compression). Can be:
;                  |2 - COMPRESSION_FORMAT_LZNT1 | COMPRESSION_ENGINE_STANDARD
;                  |258 - COMPRESSION_FORMAT_LZNT1 | COMPRESSION_ENGINE_MAXIMUM
; Return values .: Success - Returns compressed binary data.
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - Error determining workspace buffer size.
;                  |2 - Error compressing.
; Author ........: trancexx
; Related .......: _LZNTDecompress
; Link ..........; http://msdn.microsoft.com/en-us/library/bb981783.aspx
;==========================================================================================
Func _LZNTCompress($vInput, $iCompressionFormatAndEngine = 2)

	If Not ($iCompressionFormatAndEngine = 258) Then
		$iCompressionFormatAndEngine = 2
	EndIf

	Local $bBinary = Binary($vInput)

	Local $tInput = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tInput, 1, $bBinary)

	Local $a_Call = DllCall("ntdll.dll", "int", "RtlGetCompressionWorkSpaceSize", _
			"ushort", $iCompressionFormatAndEngine, _
			"dword*", 0, _
			"dword*", 0)

	If @error Or $a_Call[0] Then
		Return SetError(1, 0, "") ; error determining workspace buffer size
	EndIf

	Local $tWorkSpace = DllStructCreate("byte[" & $a_Call[2] & "]") ; workspace is needed for compression

	Local $tBuffer = DllStructCreate("byte[" & 16 * DllStructGetSize($tInput) & "]") ; initially oversizing buffer

	$a_Call = DllCall("ntdll.dll", "int", "RtlCompressBuffer", _
			"ushort", $iCompressionFormatAndEngine, _
			"ptr", DllStructGetPtr($tInput), _
			"dword", DllStructGetSize($tInput), _
			"ptr", DllStructGetPtr($tBuffer), _
			"dword", DllStructGetSize($tBuffer), _
			"dword", 4096, _
			"dword*", 0, _
			"ptr", DllStructGetPtr($tWorkSpace))

	If @error Or $a_Call[0] Then
		Return SetError(2, 0, "") ; error compressing
	EndIf

	Local $tOutput = DllStructCreate("byte[" & $a_Call[7] & "]", DllStructGetPtr($tBuffer))

	Return SetError(0, 0, DllStructGetData($tOutput, 1))
EndFunc   ;==>_LZNTCompress
