
$bInstall = MsgBox(3+32,"Au3 preprocessor","Toggle preprocessor for AutoIt?")

DirCreate(@ScriptDir & "\Backup")
If $bInstall = 6 Then
	If ProcessExists("SciTE.exe") Then
		MsgBox(0,"Error","Please close SciTE first.")
		Exit
	ENdIf
	$Folder = FileSelectFolder("Select your AutoIt installation folder",@HomeDrive)
	If NOT @Error Then
		ConsoleWrite($Folder)
		$Scitefolder = $Folder & "\SciTE"
		$Prop = $Scitefolder & "\Properties"
		FileCopy($Prop & "\au3.keywords.properties",@ScriptDir & "\Backup")
		If @Error Then Error()
		FileCopy(@ScriptDir & "\New\au3.keywords.properties",$Prop,1)
		If @Error Then Error()
		$au3wfold = $Scitefolder & "\AutoIt3Wrapper\"
		FileCopy($Au3wfold & "AutoIt3Wrapper.exe",@ScriptDir & "\Backup\AutoIt3Wrapper.exe")
		If @Error Then Error()
		FileMove($Au3wfold & "AutoIt3Wrapper.exe",$Au3wfold & "AutoIt3Wrapper2.exe")
		If @Error Then Error()
		FileCopy(@ScriptDir & "\New\AutoIt3Wrapper.exe",$Au3wfold & "AutoIt3Wrapper.exe")
		If @Error Then Error()
		FileCopy(@ScriptDir & "\New\mcpp.exe",$Au3wfold & "mcpp.exe")
		If @Error Then Error()
		FileCopy(@ScriptDir & "\New\pre.ini",$Au3wfold & "pre.ini")
		If @Error Then Error()
	MsgBox(0,"Au3 preprocessor","Successfully installed!")
	EndIf
ElseIf $bInstall = 7 Then
	$Folder = FileSelectFolder("Select your AutoIt installation folder",@HomeDrive)
	If ProcessExists("SciTE.exe") Then
		MsgBox(0,"Error","Please close SciTE first.")
		Exit
	ENdIf
	If NOT @Error Then
		ConsoleWrite($Folder)
		$Scitefolder = $Folder & "\SciTE"
		$Prop = $Scitefolder & "\Properties"
		FileCopy(@ScriptDir & "\Backup\au3.keywords.properties",$Prop & "\au3.keywords.properties",1)
		If @Error Then Error()
		$au3wfold = $Scitefolder & "\AutoIt3Wrapper\"
		FileDelete($Au3wfold & "AutoIt3Wrapper.exe")
		If @Error Then Error()
		FileMove($Au3wfold & "AutoIt3Wrapper2.exe",$Au3wfold & "AutoIt3Wrapper.exe")
		If @Error Then Error()
		FileDelete($au3wfold &  "mcpp.exe")
		If @Error Then Error()
		FileDelete($au3wfold & "\pre.ini")
		MsgBox(0,"Au3 preprocessor","Successfully uninstalled!")
	EndIf
EndIf
Func Error()
	MsgBox(0,"","OMG ERROR")
	Exit
EndFunc