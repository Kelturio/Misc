; #INDEX# =======================================================================================================================
; Title .........: CreateFilesEmbedded
; Module ........: Main
; Author ........: João Carlos (jscript) - (C) DVI-Informática 2011.9-2012.9, dvi-suporte@hotmail.com
; Support .......:
; AutoIt Version.: 3.3.0.0++
; Language ......: Portuguese
; Description ...: Template for create files embedded in your escript.
; Free Software .: Redistribute and change under these terms:
;               This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;       as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;
;               This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
;       of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
;
;               You should have received a copy of the GNU General Public License along with this program.
;               If not, see <http://www.gnu.org/licenses/>.
; ===============================================================================================================================
#region AutoIt3Wrapper directives section
;** This is a list of compiler directives used by AutoIt3Wrapper.exe.
;** comment the lines you don't need or else it will override the default settings
; ================================================================================================================================================
;** AUTOIT3 settings
;#AutoIt3Wrapper_UseX64=												;(Y/N) Use X64 versions for AutoIt3_x64 or AUT2EXE_x64. Default=N
;#AutoIt3Wrapper_Version=												;(B/P) Use Beta or Production for AutoIt3 and AUT2EXE. Default is P
;#AutoIt3Wrapper_Run_Debug_Mode=y										;(Y/N) Run Script with console debugging. Default=N
;#AutoIt3Wrapper_Run_SciTE_Minimized=									;(Y/N) Minimize SciTE while script is running. Default=n
;#AutoIt3Wrapper_Run_SciTE_OutputPane_Minimized=						;(Y/N) Toggle SciTE output pane at run time so its not shown. Default=n
;#AutoIt3Wrapper_Autoit3Dir=											;Optionally override the base AutoIt3 install directory.
;#AutoIt3Wrapper_Aut2exe=												;Optionally override the Aut2exe.exe to use for this script
;#AutoIt3Wrapper_AutoIt3=												;Optionally override the Autoit3.exe to use for this script
; ================================================================================================================================================
;** AUT2EXE settings
#AutoIt3Wrapper_Icon=.\Resources\Icon\32x32.ico							;Filename of the Ico file to use
#AutoIt3Wrapper_OutFile=CreateFilesEmbedded.exe							;Target exe/a3x filename.
;#AutoIt3Wrapper_OutFile_Type=											;a3x=small AutoIt3 file;  exe=Standalone executable (Default)
;#AutoIt3Wrapper_OutFile_X64=											;Target exe filename for X64 compile.
#AutoIt3Wrapper_Compression=0											;Compression parameter 0-4  0=Low 2=normal 4=High. Default=2
#AutoIt3Wrapper_UseUpx=n												;(Y/N) Compress output program.  Default=Y
;#AutoIt3Wrapper_UPX_Parameters=										;Override the default setting for UPX.
;#AutoIt3Wrapper_Change2CUI=											;(Y/N) Change output program to CUI in stead of GUI. Default=N
;#AutoIt3Wrapper_Compile_both=											;(Y/N) Compile both X86 and X64 in one run. Default=N
; ================================================================================================================================================
;** Target program Resource info
#AutoIt3Wrapper_Res_Comment=This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY ;Comment field
#AutoIt3Wrapper_Res_Description=Create files embedded in your escript.	;Description field
#AutoIt3Wrapper_Res_LegalCopyright=(C) DVI-Informática 2011.9-2012.9	;Copyright field
#AutoIt3Wrapper_Res_Fileversion=2.27.0912.2600							;File Version
#AutoIt3Wrapper_Res_Language=1046										;Resource Language code . default 2057=English (United Kingdom)
;#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=							;(Y/N/P) AutoIncrement FileVersion After Aut2EXE is finished. default=N
;                                                 				P=Prompt, Will ask at Compilation time if you want to increase the versionnumber
#AutoIt3Wrapper_Res_ProductVersion=2.27.0912.2600						;Product Version. Default is the AutoIt3 version used.
;#AutoIt3Wrapper_res_requestedExecutionLevel=							;None, asInvoker, highestAvailable or requireAdministrator   (default=None)
;#AutoIt3Wrapper_res_Compatibility=										;Vista,Windows7        Both allowed separated by a comma     (default=None)
;#AutoIt3Wrapper_Res_SaveSource= 										;(Y/N) Save a copy of the Scriptsource in the EXE resources. default=N
; If _Res_SaveSource=Y the content of Scriptsource depends on the _Run_Obfuscator and #obfuscator_parameters directives:
;
;    If _Run_Obfuscator=Y then
;       If #obfuscator_parameters=/STRIPONLY then Scriptsource is stripped script & stripped includes
;       If #obfuscator_parameters=/STRIPONLYINCLUDES then Scriptsource is original script & stripped includes
;       With any other parameters, the SaveSource directive is ignored as obfuscation is intended to protect the source
;   If _Run_Obfuscator=N or is not set then
;       Scriptsource is original script only
; Autoit3Wrapper indicates the SaveSource action taken in the SciTE console during compilation
; See SciTE4AutoIt3 Helpfile for more detail on Obfuscator parameters
;
; free form resource fields ... max 15
;     you can use the following variables:
;     %AutoItVer% which will be replaced with the version of AutoIt3
;     %date% = PC date in short date format
;     %longdate% = PC date in long date format
;     %time% = PC timeformat
#AutoIt3Wrapper_Res_Field=Compiler version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=CompanyName|Digital - Vídeo/Informática.
#AutoIt3Wrapper_Res_Field=InternalName|CreateFilesEmbedded.exe
#AutoIt3Wrapper_Res_Field=LegalTrademarks|Some items owned by Microsoft Corp., The others belong to their respective owners. - All rights reserved.
;#AutoIt3Wrapper_Res_Field=ProductName|
#AutoIt3Wrapper_Res_Field=OriginalFilename|
; DigitalProductID is StringToBinary(@ScriptName)
;#AutoIt3Wrapper_Res_Field=DigitalProductID|0x4E657453656E642E657865
#AutoIt3Wrapper_Res_Field=DateBuild|%longdate%
; Add extra ICO files to the resources which can be used with TraySetIcon(@ScriptFullPath, 5) etc
; list of filename of the Ico files to be added, First one will have number 5, then 6 ..etc
;#AutoIt3Wrapper_Res_Icon_Add=                   		; Filename[,LanguageCode] of ICO to be added.
; Add extra files to the resources
;#AutoIt3Wrapper_Res_File_Add=							; Filename[,Section [,ResName[,LanguageCode]]] to be added.
; ================================================================================================================================================
; Tidy Settings
;#AutoIt3Wrapper_Run_Tidy=                       		;(Y/N) Run Tidy before compilation. default=N
;#AutoIt3Wrapper_Tidy_Stop_OnError=						;(Y/N) Continue when only Warnings. default=Y
;#Tidy_Parameters=										;Tidy Parameters...see SciTE4AutoIt3 Helpfile for options
; ================================================================================================================================================
; Obfuscator
;#AutoIt3Wrapper_Run_Obfuscator=y                		;(Y/N) Run Obfuscator before compilation. default=N
;#obfuscator_parameters=/STRIPONLY
; ================================================================================================================================================
; AU3Check settings
;#AutoIt3Wrapper_Run_AU3Check=							;(Y/N) Run au3check before compilation. Default=Y

#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

;#AutoIt3Wrapper_AU3Check_Stop_OnWarning=				;(Y/N) N=Continue on Warnings.(Default) Y=Always stop on Warnings
;#AutoIt3Wrapper_PlugIn_Funcs=							;Define PlugIn function names separated by a Comma to avoid AU3Check errors
; ================================================================================================================================================
; cvsWrapper settings
;#AutoIt3Wrapper_Run_cvsWrapper=						;(Y/N/V) Run cvsWrapper to update the script source. default=N
;                                                		 V=only when version is increased by #AutoIt3Wrapper_Res_FileVersion_AutoIncrement.
;#AutoIt3Wrapper_cvsWrapper_Parameters=          		; /NoPrompt  : Will skip the cvsComments prompt
;                                              		   /Comments  : Text to added in the cvsComments. It can also contain the below variables.
; ================================================================================================================================================
; RUN BEFORE AND AFTER definitions
; The following directives can contain: these variables
;   %in% , %out%, %outx64%, %icon% which will be replaced by the fullpath\filename.
;   %scriptdir% same as @ScriptDir and %scriptfile% = filename without extension.
;   %fileversion% is the information from the #AutoIt3Wrapper_Res_Fileversion directive
;   %scitedir% will be replaced by the SciTE program directory
;   %autoitdir% will be replaced by the AutoIt3 program directory
;#AutoIt3Wrapper_Add_Constants=                  ;Add the needed standard constant include files. Will only run one time.
;#AutoIt3Wrapper_Run_Before=                     ;process to run before compilation - you can have multiple records that will be processed in sequence
;#AutoIt3Wrapper_Run_After=                      ;process to run After compilation - you can have multiple records that will be processed in sequence

#AutoIt3Wrapper_Run_Before=ShowOriginalLine.exe %in%
#AutoIt3Wrapper_Run_After=ShowOriginalLine.exe %in%

;#AutoIt3Wrapper_Run_After="%scitedir%\AutoIt3Wrapper\ResHacker.exe" -delete %out%, %out%, MENU,,
;#AutoIt3Wrapper_Run_After="%scitedir%\AutoIt3Wrapper\ResHacker.exe" -delete %out%, %out%, DIALOG,,
;#AutoIt3Wrapper_Run_After="%scitedir%\AutoIt3Wrapper\ResHacker.exe" -delete %out%, %out%, ICONGROUP,162,
;#AutoIt3Wrapper_Run_After="%scitedir%\AutoIt3Wrapper\ResHacker.exe" -delete %out%, %out%, ICONGROUP,164,
;#AutoIt3Wrapper_Run_After="%scitedir%\AutoIt3Wrapper\ResHacker.exe" -delete %out%, %out%, ICONGROUP,169,
; ================================================================================================================================================
#endregion AutoIt3Wrapper directives section

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <APIConstants.au3>
#include <WinAPIEx.au3>
#include <File.au3>

#include "_AutoItErrorTrap.au3"

_AutoItErrorTrap()

#ShowLine_Off
#include ".\Include\PathSplitRegExp.au3"
#include ".\Include\UpxLibrary.au3" ; UPX.exe file Embedded!
#ShowLine_On

#include "Variables.au3"
#include "Functions.au3"
#include "MainForm.au3"

_LoadOSLang(@ScriptDir & "\Language")

_MainForm()

; MainLoop.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $iBtn_Exit
			Exit
		Case $iBtn_Open
			$sSelectFile = FileOpenDialog($asOSLang[14][1], @ScriptDir, "All (*.*)|", 3, "", $hMainForm)
			If @error = 1 Then ContinueLoop
			If Not FileExists($sSelectFile) Then
				MsgBox(262208, $sTitle, $asOSLang[15][1] & ' "' & $sSelectFile & '" ' & $asOSLang[16][1])
				WinSetTitle($hMainForm, "", $sTitle)
				ContinueLoop
			EndIf
			$iUpxIng = 0
			GUICtrlSetData($iPrg_Convert, 0)
			GUICtrlSetData($iLbl_LineCnv, "")
			GUICtrlSetState($iBtn_Embed, $GUI_ENABLE)
			; 0 = original path, 1 = drive, 2 = directory, 3 = filename, 4 = extension
			$asPathSplit = _PathSplitRegEx($sSelectFile)
			$sFileName = $asPathSplit[3]
			$sFileExt = $asPathSplit[4]
			WinSetTitle($hMainForm, "", $sFileName & $sFileExt & " - " & $sTitle)
			; Search for MZ signature.
			$hFileOpen = FileOpen($sSelectFile, 0)
			$hFileRead = FileRead($hFileOpen, 2)
			If $hFileRead = "MZ" Or $hFileRead = "BM" Then $iUpxIng = 1
			FileClose($hFileOpen)
		Case $iBtn_Embed
			GUICtrlSetState($iBtn_Open, $GUI_DISABLE)
			If _EmbeddedFile() Then
				GUICtrlSetState($iBtn_Test, $GUI_ENABLE)
			Else
				GUICtrlSetState($iBtn_Test, $GUI_DISABLE)
			EndIf
			GUICtrlSetState($iBtn_Open, $GUI_ENABLE)
			GUICtrlSetState($iBtn_Embed, $GUI_DISABLE)
			WinSetTitle($hMainForm, "", $sTitle)

		Case $iBtn_Test
			If $iFuncOutType <> 2 Then
				MsgBox(4096, $sTitle, $asOSLang[17][1])
				GUICtrlSetState($iBtn_Test, $GUI_DISABLE)
				ContinueLoop
			EndIf
			WinSetTitle($hMainForm, "", $sTitle)
			GUICtrlSetState($iBtn_Test, $GUI_DISABLE)

		Case $iRad_Func
			; $iFuncOutType = 2, saída com função
			$iFuncOutType = _CtrlRead($iRad_Func, $GUI_CHECKED) + 1
			GUICtrlSetState($iChk_UDF, $GUI_ENABLE)
			GUICtrlSetState($iBtn_Default, $GUI_ENABLE)

		Case $iChk_UDF
			$iUDFDefault = _CtrlRead($iChk_UDF, $GUI_CHECKED)
			GUICtrlSetState($iBtn_Default, $GUI_ENABLE)

		Case $Rad_Bin
			; $iFuncOutType = 4, somente saída binária
			$iFuncOutType = _CtrlRead($Rad_Bin, $GUI_CHECKED) + 3
			GUICtrlSetState($iChk_UDF, $GUI_DISABLE)
			GUICtrlSetState($iBtn_Default, $GUI_ENABLE)

		Case $iChk_LZNT
			If GUICtrlRead($iChk_LZNT) = $GUI_CHECKED Then
				$iIsLZNT = 1
				GUICtrlSetState($iCmb_LZNT, $GUI_ENABLE)
			Else
				$iIsLZNT = 0
				GUICtrlSetState($iCmb_LZNT, $GUI_DISABLE)
			EndIf
			GUICtrlSetState($iBtn_Default, $GUI_ENABLE)

		Case $iCmb_LZNT
			If GUICtrlRead($iCmb_LZNT) = 1 Then
				$iLZNTValue = 2
			Else
				$iLZNTValue = 258
			EndIf

		Case $iBtn_Default
			GUICtrlSetState($iBtn_Default, $GUI_DISABLE)
			GUICtrlSetState($Rad_Bin, $GUI_UNCHECKED)
			GUICtrlSetState($iRad_Func, $GUI_CHECKED)
			GUICtrlSetState($iChk_UDF, $GUI_ENABLE)
			GUICtrlSetState($iChk_UDF, $GUI_CHECKED)
			GUICtrlSetState($iChk_LZNT, $GUI_CHECKED)
			GUICtrlSetState($iCmb_LZNT, $GUI_ENABLE)
			GUICtrlSetState($iCmb_LZNT, $GUI_ENABLE)
			GUICtrlSetData($iCmb_LZNT, 1)
	EndSwitch
WEnd
