#include-once
; #INDEX# =======================================================================================================================
; Title .........: CreateFilesEmbedded™
; Module ........: Variables
; Author ........: João Carlos (jscript) - (C) DVI-Informática 2011.9-2012.9, dvi-suporte@hotmail.com
; Support .......:
; AutoIt Version.: 3.3.0.0++
; Language ......: English
; Description ...: Template for create files embedded in your escript.
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
#region ; Variables used by MainForm
Global $sVersion = FileGetVersion(@ScriptName)
Global $sTitle = "Create Files Embedded - v" & $sVersion
Global $hMainForm
Global $iRad_Func, _
		$iChk_UDF, _
		$Rad_Bin, _
		$iChk_LZNT, _
		$iCmb_LZNT, _
		$iBtn_Open, _
		$iBtn_Embed, _
		$iBtn_Test, _
		$iBtn_Default, _
		$iLbl_Prog, _
		$iPrg_Convert, _
		$iBtn_Exit, _
		$iLbl_LineCnv

; General
Global $sOSLang_INI, _
		$asOSLang, _
		$asPathSplit

Global $iUpxIng = 0
Global $hFileRead, $sSelectFile, $sFileName, $sFileExt, $hFileOpen, $hSaveAu3File, $sFunctionName
Global $iFuncOutType = 2, $iUDFDefault = 1, $iIsLZNT = 1, $iLZNTValue = 2
