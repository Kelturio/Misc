#include-once
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.2.13.12 (beta)
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region				  Fonts and Text

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_AddFontMemResourceEx
; Description ...: adds the font resource from a memory image to the system.
; Syntax.........: _GDI_AddFontMemResourceEx($pbFont, $cbFont, $pdv, $pcFonts)
; Parameters ....: $pbFont   - [in] Pointer to a font resource.
;                  $cbFont   - [in] Number of bytes in the font resource that is pointed to by pbFont.
;                  $pdv      - [in] Reserved. Must be 0.
;                  $pcFonts  - [in] Pointer to a variable that specifies the number of fonts installed.
; Return values .: Success      - handle to the font added. This handle uniquely identifies the fonts that were installed on the system.
;                  Failure      - 0 (No extended error information is available.)
; Author ........: Greenhorn
; Modified.......:
; Remarks .......: This function allows an application to get a font that is embedded in a document or a Web page. A font that
;                    is added by AddFontMemResourceEx is always private to the process that made the call and is not enumerable.
;                  A memory image can contain more than one font. When this function succeeds, pcFonts is a pointer to a DWORD
;                    whose value is the number of fonts added to the system as a result of this call. For example, this number
;                    could be 2 for the vertical and horizontal faces of an Asian font.
;                  When the function succeeds, the caller of this function can free the memory pointed to by pbFont because the
;                    system has made its own copy of the memory. To remove the fonts that were installed, call
;                    RemoveFontMemResourceEx. However, when the process goes away, the system will unload the fonts even if the
;                    process did not call RemoveFontMemResource.
; Related .......:
; Link ..........; @@MsdnLink@@ AddFontMemResourceEx
; Example .......;
; ===============================================================================================================================
Func _GDI_AddFontMemResourceEx($pbFont, $cbFont, $pdv, $pcFonts)

	Local $aRes = DllCall($__GDI_gdi32dll, 'ptr', 'AddFontMemResourceEx', _
			'ptr', $pbFont, _  ; // font resource
			'dword', $cbFont, _    ; // number of bytes in font resource
			'ptr', $pdv, _  ; // Reserved. Must be 0.
			'dword*', $pcFonts) ; // number of fonts installed
	If @error Then Return SetError(@error, 0, 0)
	Return $aRes[0]

EndFunc   ;==>_GDI_AddFontMemResourceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_AddFontResource
; Description ...: Adds the font resource from the specified file to the system font table.
;                   The font can subsequently be used for text output by any application.
; Syntax.........: _GDI_AddFontResource($lpszFilename)
; Parameters ....: $lpszFilename  - Pointer to a null-terminated character string that contains a valid font file name.
;                                    This parameter can specify any of the following files.
;                                   File Extension                      Meaning
;                                       .fon                       Font resource file.
;                                       .fnt                       Raw bitmap font file.
;                                       .ttf                       Raw TrueType file.
;                                       .ttc                       East Asian Windows: TrueType font collection.
;                                       .fot                       TrueType resource file.
;                                       .otf                       PostScript OpenType font.
;                                       .mmm                       Multiple master Type1 font resource file. It must be used with .pfm and .pfb files.
;                                       .pfb                       Type 1 font bits file. It is used with a .pfm file.
;                                       .pfm                       Type 1 font metrics file. It is used with a .pfb file.
;                                  Windows 2000/XP: To add a font whose information comes from several resource files,
;                                    have lpszFileName point to a string with the file names separated
;                                    by a "|" --for example, abcxxxxx.pfm | abcxxxxx.pfb.
; Return values .: Success      - the number of fonts added.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Any application that adds or removes fonts from the system font table should notify other windows of
;                    the change by sending a WM_FONTCHANGE message to all top-level windows in the operating system.
;                    The application should send this message by calling the SendMessage function and setting the hwnd
;                    parameter to HWND_BROADCAST.
;                  When an application no longer needs a font resource that it loaded by calling the AddFontResource
;                    function, it must remove that resource by calling the RemoveFontResource function.
;                  This function installs the font only for the current session. When the system restarts, the font will not
;                    be present. To have the font installed even after restarting the system, the font must be listed in the registry.
; Related .......:
; Link ..........; @@MsdnLink@@ AddFontResource
; Example .......;
; ===============================================================================================================================
Func _GDI_AddFontResource($lpszFilename)
	Local $aRes = DllCall($__GDI_gdi32dll, "int", "AddFontResourceW", "wstr", $lpszFilename)
	If @error Then Return SetError(@error,0,0)
	Return $aRes[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_AddFontResourceEx
; Description ...: adds the font resource from the specified file to the system.
;                   Fonts added with the AddFontResourceEx function can be marked as private and not enumerable.
; Syntax.........: _GDI_AddFontResourceEx($lpszFilename, $fl, $pdv = 0)
; Parameters ....: $lpszFilename  - [in] Pointer to a null-terminated character string that contains a valid font file name.
;                                         This parameter can specify any of the following files.
;                                        File Extension                      Meaning
;                                            .fon                       Font resource file.
;                                            .fnt                       Raw bitmap font file.
;                                            .ttf                       Raw TrueType file.
;                                            .ttc                       East Asian Windows: TrueType font collection.
;                                            .fot                       TrueType resource file.
;                                            .otf                       PostScript OpenType font.
;                                            .mmm                       Multiple master Type1 font resource file.
;                                                                         It must be used with .pfm and .pfb files.
;                                            .pfb                       Type 1 font bits file. It is used with a .pfm file.
;                                            .pfm                       Type 1 font metrics file. It is used with a .pfb file.
;                                        To add a font whose information comes from several resource files,
;                                          point lpszFileName to a string with the file names separated
;                                          by a | --for example, abcxxxxx.pfm | abcxxxxx.pfb.
;                  $fl            - [in] Specifies characteristics of the font to be added to the system.
;                                          This parameter can be one of the following values.
;                                        $FR_PRIVATE    Specifies that only the process that called the AddFontResourceEx
;                                                        function can use this font. When the font name matches a public
;                                                        font, the private font will be chosen. When the process terminates,
;                                                        the system will remove all fonts installed by the process with
;                                                        the AddFontResourceEx function.
;                                        $FR_NOT_ENUM   Specifies that no process, including the process that called the
;                                                        AddFontResourceEx function, can enumerate this font.
;                  $pdv           - [in] Reserved. Must be zero.
; Return values .: Success      - the number of fonts added.
;                  Failure      - 0 (No extended error information is available.)
; Author ........: Greenhorn
; Modified.......:
; Remarks .......: This function allows a process to use fonts without allowing other processes access to the fonts.
;                  When an application no longer needs a font resource it loaded by calling the AddFontResourceEx function,
;                    it must remove the resource by calling the RemoveFontResourceEx function.
;                  This function installs the font only for the current session. When the system restarts, the font will not
;                    be present. To have the font installed even after restarting the system, the font must be listed in the registry.
; Related .......:
; Link ..........; @@MsdnLink@@ AddFontResourceEx
; Example .......;
; ===============================================================================================================================
Func _GDI_AddFontResourceEx($lpszFilename, $fl, $pdv = 0)

	If Not IsNumber($pdv) Or $pdv <> 0 Then $pdv = 0
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'AddFontResourceExW', 'wstr', $lpszFilename, 'dword', $fl, 'ptr', $pdv)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]

EndFunc   ;==>_GDI_AddFontResourceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateFont
; Description ...: Creates a logical font with the specified characteristics
; Syntax.........: _GDI_CreateFont($nHeight, $nWidth[, $nEscape = 0[, $nOrientn = 0[, $fnWeight = $FW_NORMAL[, $bItalic = False[, $bUnderline = False[, $bStrikeout = False[, $nCharset = $DEFAULT_CHARSET[, $nOutputPrec = $OUT_DEFAULT_PRECIS[, $nClipPrec = $CLIP_DEFAULT_PRECIS[, $nQuality = $DEFAULT_QUALITY[, $nPitch = 0[, $szFace = 'Arial']]]]]]]]]]]])
; Parameters ....: $nHeight            - height of font
;                  $nWidth             - average character width
;                  $nEscape            - angle of escapement
;                  $nOrientn           - base-line orientation angle
;                  $fnWeight           - font weight, The following values are defined for convenience:
;                  |$FW_DONTCARE   - 0
;                  |$FW_THIN       - 100
;                  |$FW_EXTRALIGHT - 200
;                  |$FW_LIGHT      - 300
;                  |$FW_NORMAL     - 400
;                  |$FW_MEDIUM     - 500
;                  |$FW_SEMIBOLD   - 600
;                  |$FW_BOLD       - 700
;                  |$FW_EXTRABOLD  - 800
;                  |$FW_HEAVY      - 900
;                  $bItalic            - italic attribute option
;                  $bUnderline         - underline attribute option
;                  $bStrikeout         - strikeout attribute option
;                  $nCharset           - Specifies the character set. The following values are predefined:
;                  |$ANSI_CHARSET        - 0
;                  |$BALTIC_CHARSET      - 186
;                  |$CHINESEBIG5_CHARSET - 136
;                  |$DEFAULT_CHARSET     - 1
;                  |$EASTEUROPE_CHARSET  - 238
;                  |$GB2312_CHARSET      - 134
;                  |$GREEK_CHARSET       - 161
;                  |$HANGEUL_CHARSET     - 129
;                  |$MAC_CHARSET         - 77
;                  |$OEM_CHARSET         - 255
;                  |$RUSSIAN_CHARSET     - 204
;                  |$SHIFTJIS_CHARSET    - 128
;                  |$SYMBOL_CHARSET      - 2
;                  |$TURKISH_CHARSET     - 162
;                  |$VIETNAMESE_CHARSET  - 163
;                  $nOutputPrec        - Specifies the output precision, It can be one of the following values:
;                  |$OUT_CHARACTER_PRECIS - Not used
;                  |$OUT_DEFAULT_PRECIS   - Specifies the default font mapper behavior
;                  |$OUT_DEVICE_PRECIS    - Instructs the font mapper to choose a Device font when the system contains multiple fonts with the same name
;                  |$OUT_OUTLINE_PRECIS   - Windows NT/2000/XP: This value instructs the font mapper to choose from TrueType and other outline-based fonts
;                  |$OUT_PS_ONLY_PRECIS   - Windows 2000/XP: Instructs the font mapper to choose from only PostScript fonts.
;                  +If there are no PostScript fonts installed in the system, the font mapper returns to default behavior
;                  |$OUT_RASTER_PRECIS    - Instructs the font mapper to choose a raster font when the system contains multiple fonts with the same name
;                  |$OUT_STRING_PRECIS    - This value is not used by the font mapper, but it is returned when raster fonts are enumerated
;                  |$OUT_STROKE_PRECIS    - Windows NT/2000/XP: This value is not used by the font mapper, but it is returned when TrueType,
;                  +other outline-based fonts, and vector fonts are enumerated
;                  |$OUT_TT_ONLY_PRECIS   - Instructs the font mapper to choose from only TrueType fonts. If there are no TrueType fonts installed in the system,
;                  +the font mapper returns to default behavior
;                  |$OUT_TT_PRECIS        - Instructs the font mapper to choose a TrueType font when the system contains multiple fonts with the same name
;                  $nClipPrec             - Specifies the clipping precision, It can be one or more of the following values:
;                  |$CLIP_CHARACTER_PRECIS - Not used
;                  |$CLIP_DEFAULT_PRECIS   - Specifies default clipping behavior
;                  |$CLIP_EMBEDDED         - You must specify this flag to use an embedded read-only font
;                  |$CLIP_LH_ANGLES        - When this value is used, the rotation for all fonts depends on whether the orientation of the coordinate system is left-handed or right-handed.
;                  |If not used, device fonts always rotate counterclockwise, but the rotation of other fonts is dependent on the orientation of the coordinate system.
;                  |$CLIP_MASK             - Not used
;                  |$CLIP_STROKE_PRECIS    - Not used by the font mapper, but is returned when raster, vector, or TrueType fonts are enumerated
;                  |Windows NT/2000/XP: For compatibility, this value is always returned when enumerating fonts
;                  |$CLIP_TT_ALWAYS        - Not used
;                  $fdwQuality         - Specifies the output quality, It can be one of the following values:
;                  |$ANTIALIASED_QUALITY    - Windows NT 4.0 and later: Font is antialiased, or smoothed, if the font supports it and the size of the font is not too small or too large.
;                  |Windows 95 with Plus!, Windows 98/Me: The display must greater than 8-bit color, it must be a single plane device, it cannot be a palette display, and it cannot be in a multiple display monitor setup.
;                  |In addition, you must select a TrueType font into a screen DC prior to using it in a DIBSection, otherwise antialiasing does not happen
;                  |$DEFAULT_QUALITY        - Appearance of the font does not matter
;                  |$DRAFT_QUALITY          - Appearance of the font is less important than when the PROOF_QUALITY value is used.
;                  |For GDI raster fonts, scaling is enabled, which means that more font sizes are available, but the quality may be lower.
;                  |Bold, italic, underline, and strikeout fonts are synthesized, if necessary
;                  |$NONANTIALIASED_QUALITY - Windows 95 with Plus!, Windows 98/Me, Windows NT 4.0 and later: Font is never antialiased, that is, font smoothing is not done
;                  |$PROOF_QUALITY          - Character quality of the font is more important than exact matching of the logical-font attributes.
;                  |For GDI raster fonts, scaling is disabled and the font closest in size is chosen.
;                  |Although the chosen font size may not be mapped exactly when PROOF_QUALITY is used, the quality of the font is high and there is no distortion of appearance.
;                  |Bold, italic, underline, and strikeout fonts are synthesized, if necessary
;                  $nPitch             - Specifies the pitch and family of the font. The two low-order bits specify the pitch of the font and can be one of the following values:
;                  +$DEFAULT_PITCH, $FIXED_PITCH, $VARIABLE_PITCH
;                  |The four high-order bits specify the font family and can be one of the following values:
;                  |$FF_DECORATIVE  - Novelty fonts. Old English is an example
;                  |$FF_DONTCARE    - Use default font
;                  |$FF_MODERN      - Fonts with constant stroke width, with or without serifs. Pica, Elite, and Courier New are examples
;                  |$FF_ROMAN       - Fonts with variable stroke width and with serifs. MS Serif is an example
;                  |$FF_SCRIPT      - Fonts designed to look like handwriting. Script and Cursive are examples
;                  |$FF_SWISS       - Fonts with variable stroke width and without serifs. MS Sans Serif is an example
;                  $szFace             - typeface name
; Return values .: Success      - The handle to a logical font
;                  Failure      - 0
; Author ........: Gary Frost
; Modified.......: Prog@ndy
; Remarks .......: When you no longer need the font, call the _GDI_DeleteObject function to delete it
;                  Needs FontConstants.au3 for pre-defined constants.
; Related .......:
; Link ..........; @@MsdnLink@@ CreateFont
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateFont($nHeight, $nWidth, $nEscape = 0, $nOrientn = 0, $fnWeight = $FW_NORMAL, $bItalic = False, $bUnderline = False, $bStrikeout = False, $nCharset = $DEFAULT_CHARSET, $nOutputPrec = $OUT_DEFAULT_PRECIS, $nClipPrec = $CLIP_DEFAULT_PRECIS, $nQuality = $DEFAULT_QUALITY, $nPitch = 0, $szFace = 'Arial')

	Local $aFont

	$aFont = DllCall($__GDI_gdi32dll, 'ptr', 'CreateFont', 'int', $nHeight, 'int', $nWidth, 'int', $nEscape, 'int', $nOrientn, _
			'int', $fnWeight, 'long', $bItalic, 'long', $bUnderline, 'long', $bStrikeout, 'long', $nCharset, 'long', $nOutputPrec, _
			'long', $nClipPrec, 'long', $nQuality, 'long', $nPitch, 'str', $szFace)
	If @error Then Return SetError(@error, 0, 0)
	Return $aFont[0]
EndFunc   ;==>_GDI_CreateFont

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateFontIndirect
; Description ...: Creates a logical font that has specific characteristics
; Syntax.........: _GDI_CreateFontIndirect($tLogFont)
; Parameters ....: $tLogFont    - $tagLOGFONT structure that defines the characteristics of the logical font
; Return values .: Success      - Handle to a logical font
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: This function creates a logical font with the characteristics specified in the $tagLOGFONT structure. When this
;                  font is selected by using the SelectObject function, GDI's font mapper attempts to match the logical font with
;                  an existing physical font. If it fails to find an exact match it provides an alternative whose characteristics
;                  match as many of the requested characteristics as possible.
; Related .......: $tagLOGFONT
; Link ..........; @@MsdnLink@@ CreateFontIndirect
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateFontIndirect(ByRef $tLogFont)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateFontIndirect", "ptr", DllStructGetPtr($tLogFont))
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateFontIndirect

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateFontIndirectEx
; Description ...: specifies a logical font that has the characteristics in the specified structure. The font can subsequently
;                    be selected as the current font for any device context.
; Syntax.........: _GDI_CreateFontIndirect(ByRef $tEnumLFEx)
; Parameters ....: $tEnumLFEx   - $tagENUMLOGFONTEXDV structure that defines the characteristics of a multiple master font.
;                                  Note, this function ignores the elfDesignVector member in ENUMLOGFONTEXDV.
; Return values .: Success      - handle to the new ENUMLOGFONTEXDV structure.
;                  Failure      - 0, No extended error information is available.
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: The CreateFontIndirectEx function creates a logical font with the characteristics specified in the
;                   ENUMLOGFONTEXDV structure. When this font is selected by using the SelectObject function, GDI's font mapper
;                   attempts to match the logical font with an existing physical font. If it fails to find an exact match, it
;                   provides an alternative whose characteristics match as many of the requested characteristics as possible.
;                  When you no longer need the font, call the DeleteObject function to delete it.
;                  The font mapper for CreateFont, CreateFontIndirect, and CreateFontIndirectEx recognizes both the English
;                   and the localized typeface name, regardless of locale.
; Related .......: $tagENUMLOGFONTEXDV
; Link ..........; @@MsdnLink@@ CreateFontIndirectEx
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateFontIndirectEx(ByRef $tEnumLFEx)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateFontIndirectEx", "ptr", DllStructGetPtr($tEnumLFEx))
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateFontIndirectEx


; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_EnumFontFamiliesEx
; Description ...: The EnumFontFamiliesEx function enumerates all uniquely-named fonts in the system that match the font characteristics specified by the LOGFONT structure. EnumFontFamiliesEx enumerates fonts based on typeface name, character set, or both.
; Syntax.........: _GDI_CreateFontIndirect($tLogFont)
; Parameters ....: $hdc                 -- Handle to the device context.
;                  $lpLogfont           -- Pointer To a LOGFONTW (UNICODE!) structure that contains information about the fonts To enumerate. The function examines the following members.
;                       lfCharset        - If set to DEFAULT_CHARSET, the function enumerates all uniquely-named fonts in all character sets. (If there are two fonts with the same name, only one is enumerated.) If set to a valid character set value, the function enumerates only fonts in the specified character set.
;                       lfFaceName       - If set To an empty string, the function enumerates one font In each available typeface name. If set To a valid typeface name, the function enumerates all fonts With the specified name.
;                       lfPitchAndFamily - Must be set To zero For all language versions of the operating system.
;                  $lpEnumFontFamExProc -- Pointer To the application defined callback function. For more information, see the EnumFontFamExProc function.
;                  $lParam              -- Specifies an application defined value. The function passes this value To the callback function along With font information.
;                  $dwFlags             -- This parameter is Not used And must be zero.
; Return values .: Success      - Handle to a logical font
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: $tagLOGFONT
; Link ..........; @@MsdnLink@@ EnumFontFamiliesEx
; Example .......;
; ===============================================================================================================================
Func _GDI_EnumFontFamiliesEx($hDC, ByRef $tLogFont,$lpEnumFontFamExProc,$lParam,$dwFlags)
	Local $aResult
	Local $lpLogfont = DllStructGetPtr($tLogFont)
	If IsPtr($tLogFont) Then $lpLogfont = $tLogFont

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "EnumFontFamiliesExW", _
			'ptr', $hDC, _ ;                        // handle to DC
			'ptr', $lpLogfont, _ ;             // font information
			'ptr', $lpEnumFontFamExProc, _ ;// callback function
			'LPARAM', $lParam, _ ;                  // additional data
			'DWORD', $dwFlags);                    // not used; must be 0

	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_EnumFontFamiliesEx



; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetTextExtentPoint32
; Description ...: Computes the width and height of the specified string of text
; Syntax.........: _GDI_GetTextExtentPoint32($hDC, $sText)
; Parameters ....: $hDC         - Identifies the device contex
;                  $sText       - String of text
; Return values .: Success      - $tagSIZE structure in which the dimensions of the string are to be returned
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......: $tagSIZE
; Link ..........; @@MsdnLink@@ GetTextExtentPoint32
; Example .......;
; ===============================================================================================================================
Func _GDI_GetTextExtentPoint32($hDC, $sText)
	Local $tSize, $iSize, $aResult

	$tSize = DllStructCreate($tagSIZE)
	$iSize = StringLen($sText)
	$aResult = DllCall($__GDI_gdi32dll, "int", "GetTextExtentPoint32W", "ptr", $hDC, "wstr", $sText, "int", $iSize, "ptr", DllStructGetPtr($tSize))
	SetError($aResult[0] = 0)
	Return $tSize
EndFunc   ;==>_GDI_GetTextExtentPoint32

Func _GDI_RemoveFontResourceEx($lpFontname, $fl, $pdv = 0)

	If Not IsNumber($pdv) Or $pdv <> 0 Then $pdv = 0
	Local $aResult = DllCall($__GDI_gdi32dll, 'int', 'RemoveFontResourceExW', 'wstr', $lpFontname, 'dword', $fl, 'ptr', $pdv)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]

EndFunc   ;==>_GDI_RemoveFontResourceEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetTextColor
; Description ...: Sets the current text color to the specified color value
; Syntax.........: _GDI_SetTextColor($hDC, $iColor)
; Parameters ....: $hDC         - Handle to the device context
;                  $iColor      - Specifies the new text color
; Return values .: Success      - The previous text color
;                  Failure      - 0xFFFF
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ SetTextColor
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_SetTextColor($hDC, $iColor)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "SetTextColor", "ptr", $hDC, "int", $iColor)
	If @error Then Return SetError(@error, 0, 0xFFFF)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetTextColor

; #FUNCTION# ====================================================================================================
; Name...........: _GDI_TextOut
; Description ...: Writes a character string at the specified location, using the currently selected font, background color, and text color
; Syntax.........: _GDI_TextOut($hDC, $iXStart, $iYStart, $sString)
; Parameters ....: $hDC - Identifies the device contex
; $iXStart - x-coordinate of starting position
; $iYStart - y-coordinate of starting position
; $sString - character string
; Return values .: Success - return value is nonzero
; Author.........: GRS
; ====================================================================================================
Func _GDI_TextOut($hDC, $iXStart, $iYStart, $sString = "", $GDIDll = $__GDI_gdi32dll)
	Local $aResult
	$aResult = DllCall($GDIDll, "long", "TextOutW", "ptr", $hDC, "long", $iXStart, "long", $iYStart, "wstr", $sString, "long", StringLen($sString))
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_TextOut

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_DrawTextEx
; Description ...: Draws formatted text in the specified rectangle
; Syntax.........: _GDI_DrawText($hDC, $sText, ByRef $tRect, $iFlags)
; Parameters ....: $hDC         - Identifies the device context
;                  $sText       - The string to be drawn
;                  $tRect       - $tagRECT structure that contains the rectangle for the text
;                  $iFlags      - Specifies the method of formatting the text:
;                  |$DT_BOTTOM          - Justifies the text to the bottom of the rectangle
;                  |$DT_CALCRECT        - Determines the width and height of the rectangle
;                  |$DT_CENTER          - Centers text horizontally in the rectangle
;                  |$DT_EDITCONTROL     - Duplicates the text-displaying characteristics of a multiline edit control
;                  |$DT_END_ELLIPSIS    - Replaces part of the given string with ellipses if necessary
;                  |$DT_EXPANDTABS      - Expands tab characters
;                  |$DT_EXTERNALLEADING - Includes the font external leading in line height
;                  |$DT_HIDEPREFIX      - Windows 2000/XP: Ignores the ampersand (&) prefix character in the text.
;                  |$DT_INTERNAL        - Uses the system font to calculate text metrics.
;                  |$DT_LEFT            - Aligns text to the left
;                  |$DT_MODIFYSTRING    - Modifies the given string to match the displayed text
;                  |$DT_NOCLIP          - Draws without clipping
;                  |$DT_NOFULLWIDTHCHARBREAK - Windows 98/Me, Windows 2000/XP: Prevents a line break at a DBCS (double-wide character string)
;                  |$DT_NOPREFIX        - Turns off processing of prefix characters
;                  |$DT_PATH_ELLIPSIS   - For displayed text, replaces chars in the middle of the string with ellipses, so that it fits the rect
;                  |$DT_PREFIXONLY      - Windows 2000/XP: Draws only an underline at the position of the character following the ampersand (&).
;                  |$DT_RIGHT           - Aligns text to the right
;                  |$DT_RTLREADING      - Layout in right to left reading order for bi-directional text
;                  |$DT_SINGLELINE      - Displays text on a single line only
;                  |$DT_TABSTOP         - Sets tab stops. Bits 15-8 of $iFlags specify the number of characters for each tab
;                  |$DT_TOP             - Top-justifies text (single line only)
;                  |$DT_VCENTER         - Centers text vertically (single line only)
;                  |$DT_WORDBREAK       - Breaks words
;                  |$DT_WORD_ELLIPSIS   - Truncates any word that does not fit in the rectangle and adds ellipses.
;                  $tParams     - $tagDRAWTEXTPARAMS Structure that contains additional information.
;                  $iTextLen    - [optional] the lenght of the text to draw
; Return values .: Success      - The height of the text
;                       The printed Characters are stored in the $tagDRAWTEXTPARAMS structin uiLengthDrawn.
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA) ( _GDI_DrawText )
; Modified.......: Prog@ndy
; Remarks .......: The DrawTextEx function supports only fonts whose escapement and orientation are both zero.
;                  The text alignment mode for the device context must include the TA_LEFT, TA_TOP, and TA_NOUPDATECP flags.
; Related .......: $tagRECT
; Link ..........; @@MsdnLink@@ DrawTextEx
; Example .......;
; ===============================================================================================================================
Func _GDI_DrawTextEx($hDC, $sText, ByRef $tRect, $iFlags, ByRef $tParams, $TextLen = -1)
	Local $aResult
	If Not ($TextLen > 0) Then $TextLen = -1

	$aResult = DllCall($__GDI_user32dll, "int", "DrawTextExW", "ptr", $hDC, "wstr", $sText, "int", $TextLen, "ptr", DllStructGetPtr($tRect), "int", $iFlags, "ptr", DllStructGetPtr($tParams))
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_DrawTextEx

#EndRegion				  Fonts and Text
;*************************************************************
