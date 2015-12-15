#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.7.18 (beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here


;#include <Console.au3>
#include <Misc.au3>
$MyCmd = $CMDLINE
$Au3Version = StringReplace(@AutoItVersion,".","")

If @AutoItX64 Then
	$IncludeDIR = '"' & StringTrimRight(@AutoItExe,StringLen("AutoIt_x64.exe")+1) & 'Include"'
Else
	$IncludeDIR = '"' & StringTrimRight(@AutoItExe,StringLen("AutoIt.exe")) & 'Include"'
EndIf
Global $INFILE, $INCLUDEDIR, $noInf
For $i = 1 To $CMDLINE[0]
	Switch $CMDLINE[$i]
		Case "/in"
			$noInf = $i +1
			$Infile = $CMDLINE[$noInf]
		Case "/autoit3dir"
			$includedir = $Cmdline[$i+1] & "\Include"
	EndSwitch
Next

$Beta = StringinStr($IncludeDir, "beta")

$Outfile = StringTrimRight($infile,4) & "2.au3"

$MyCMd[$noInf] = '"' & $outfile & '"'

$Commandline = ""
For $i = 1 to $mycmd[0]
	$Commandline &= $mycmd[$i] & " "
Next

$AutoItWrapper = StringTrimRight(@ScriptFullPath,4) & "2.exe"

;MsgBox(0,"Debug","AutoItWrapper: " &$AutoItWrapper & @Crlf & "Infile: " & $Infile & @CRLF & "Outfile: " & $Outfile & @CRLF & "Includedir: " & $includedir & @CRLF & @CRLF & $AutoItWrapper & " " & $Commandline)
$args = iniread(@Scriptdir & "\pre.ini","settings","cmd"," -a -P ")

IF @Compiled AND $MyCmd[0] Then
	;ConsoleWrite("Cmdline: " & $CMDLINERAW & @CRLF)
	ConsoleWrite("!(MCPP) Preprocessing: " & @CRLF)
	$dlog = FileOpen("prelog.log",2)
	;$Handle = Run('mcpp.exe "' & $INFILE & '" -I "' & $IncludeDIR  & '" "' & $Outfile & _
	;'" -a -P AU3VERSION=' & $Au3Version & " " & _Iif($Beta," -D BETA",""))
	ConsoleWrite('> mcpp.exe "' & $INFILE & '" "' & $Outfile & '"' & ' -I "' & $IncludeDIR & '" ' & $args & ' -D AU3VERSION=' & $Au3Version & " " & _Iif($Beta," -D BETA","") & " -I2" &  @CRLF)
	$Handle = Run('mcpp.exe "' & $INFILE & '" "' & $Outfile & '"' & ' -I "' & $IncludeDIR & '" ' & $args & ' -D AU3VERSION=' & $Au3Version & " " & _Iif($Beta," -D BETA","") & " -I2","","",0x8)
	Do
		FileWrite($dlog,StdoutRead($Handle))
		If @error Then ExitLoop
		Sleep(40)
    until NOT ProcessExists($Handle)
	FileClose($dlog)
	stdioclose($Handle)
	$Handle = Run($AutoItWrapper & " " & $Commandline,"","",0x8)
	While ProcessExists($Handle)
		ConsoleWrite(StdoutRead($Handle))
		If @error Then ExitLoop
		Sleep(40)
    WEnd
	ProcessWaitClose($handle)
	$iExt = @extended
	StdIoClose($Handle)
	FileDelete($OutFile)
	Exit _Iif($iExt = 0xCCCCCCCC, 0,$iExt)
Else
	ConsoleWrite("Cmdline: " & $CMDLINERAW & @CRLF)
	ConsoleWrite("Processing ")
	ConsoleWrite(@ScriptDir & "\ProcessFile.au3" & @CRLF,$FOREGROUND_RED)
	ConsoleWrite(" -> ")
	ConsoleWrite(@ScriptDir & "\Processed.au3", $FOREGROUND_BLUE)
	ConsoleWrite(@CRLF & " ---------------------------------------------------- " & @CRLF &@CRLF)
	RunWait('mcpp.exe ' & @ScriptDir & "\ProcessFile.au3" & " -I " & $IncludeDIR  & " " & @ScriptDir & "\Processed.au3" & _
	" " & $args & " -D AU3VERSION=" & StringReplace(@AutoItVersion,".","") & " " & _Iif($Beta," -D BETA",""))
EndIf

