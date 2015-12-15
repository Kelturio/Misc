; #FUNCTION# ====================================================================================================================
; Name...........: _PathSplitRegEx
; Description ...: Splits a path into the drive, directory, file name and file extension parts. An empty string is set if a part is missing.
; Syntax.........: _PathSplitRegEx($sPath)
; Parameters ....: $sPath - The path to be split (Can contain a UNC server or drive letter)
; Return values .: Success - Returns an array with 5 elements where 0 = original path, 1 = drive, 2 = directory, 3 = filename, 4 = extension
; Author ........: Gibbo
; Modified.......:
; Remarks .......: This function does not take a command line string. It works on paths, not paths with arguments.
;                This differs from _PathSplit in that the drive letter or servershare retains the "" not the path
;                RegEx Built using examples from "Regular Expressions Cookbook (O’Reilly Media, 2009)"
; Related .......: _PathSplit, _PathFull, _PathMake
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _PathSplitRegEx($sPath)
	If $sPath = "" Then Return SetError(1, 0, "")
	Local Const $rPathSplit = '^(?i)([a-z]:|\\\\[a-z0-9_.$]+\\[a-z0-9_.]+\$?)?(\\(?:[^\\/:*?"<>|\r\n]+\\)*)?([^\\/:*?"<>|\r\n.]*)((?:\.[^.\\/:*?"<>|\r\n]+)?)$'
	Local $aResult = StringRegExp($sPath, $rPathSplit, 2)

	Switch @error
		Case 0
			Return $aResult
		Case 1
			Return SetError(2, 0, "")
		Case 2
			;This should never happen!
	EndSwitch
EndFunc   ;==>_PathSplitRegEx