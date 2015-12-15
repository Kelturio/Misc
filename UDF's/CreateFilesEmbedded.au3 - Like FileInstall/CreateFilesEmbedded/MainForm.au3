#include-once
; #INDEX# =======================================================================================================================
; Title .........: CreateFilesEmbedded™
; Module ........: MainForm
; Author ........: João Carlos (jscript) - (C) DVI-Informática 2011.9-2012.9, dvi-suporte@hotmail.com
; Support .......:
; AutoIt Version.: 3.3.0.0++
; Language ......: English
; Description ...: Template for create files embedded in your escript.
; ===============================================================================================================================

Func _MainForm()
	$hMainForm = GUICreate($sTitle, 490, 306, -1, -1)

	GUICtrlCreateGroup($asOSLang[1][1], 17, 15, 353, 177, BitOR($GUI_SS_DEFAULT_GROUP, $BS_LEFT))
	$iRad_Func = GUICtrlCreateRadio($asOSLang[2][1], 29, 39, 329, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$iChk_UDF = GUICtrlCreateCheckbox($asOSLang[3][1], 45, 63, 313, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$Rad_Bin = GUICtrlCreateRadio($asOSLang[4][1], 29, 87, 329, 17)
	$iChk_LZNT = GUICtrlCreateCheckbox($asOSLang[5][1], 29, 131, 305, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateLabel($asOSLang[6][1], 45, 157, 108, 17)
	$iCmb_LZNT = GUICtrlCreateCombo("", 156, 155, 41, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "1|2", "1")
	GUICtrlCreateButton("", 24, 117, 340, 2, -1, $WS_EX_STATICEDGE)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$iBtn_Open = GUICtrlCreateButton($asOSLang[7][1], 385, 20, 91, 25)

	$iBtn_Embed = GUICtrlCreateButton($asOSLang[8][1], 385, 50, 91, 25)
	GUICtrlSetState(-1, $GUI_DISABLE)

	$iBtn_Test = GUICtrlCreateButton($asOSLang[9][1], 385, 80, 91, 25)
	GUICtrlSetState(-1, $GUI_DISABLE)

	$iBtn_Default = GUICtrlCreateButton($asOSLang[10][1], 385, 166, 91, 25)
	GUICtrlSetState(-1, $GUI_DISABLE)

	GUICtrlCreateButton("", 7, 211, 475, 2, -1, $WS_EX_STATICEDGE)
	GUICtrlSetState(-1, $GUI_DISABLE)

	$iLbl_Prog = GUICtrlCreateLabel($asOSLang[11][1], 19, 224, 122, 17)
	$iPrg_Convert = GUICtrlCreateProgress(16, 248, 353, 17)
	$iBtn_Exit = GUICtrlCreateButton($asOSLang[12][1], 385, 244, 91, 25)
	GUICtrlCreateLabel($asOSLang[13][1], 19, 277, 96, 17)
	$iLbl_LineCnv = GUICtrlCreateLabel("", 118, 277, 182, 17)

	GUISetState(@SW_SHOW)
EndFunc   ;==>_MainForm
