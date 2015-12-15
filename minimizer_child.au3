#include <File.au3>
#include <Array.au3>
#include <String.au3>

;Sinn von $aCheck und $aCheck2 wird in Del_Newline klar.
Global $aCheck[51]=[ "a","b","c","d","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_"] ;guckt ob hinter } einer dieser buchstaben kommt. wenn ja soll ein simikolon zwischen } und buchstabe gesetzt werden
Global $aCheck2[5]=["if","else","try","catch","while"] ;auch wenn nach einem } ein buchstabe aus $aCheck gefunden wird, soll kein simikolon gesetzt werden, wenn dieser buchstabe zu einem dieser wörter gehört
Global $FunktionenReplace=Read_replace("Stringersatz.txt")
Global $ErlaubtVorFunktionen[9]=[" ","(","'",'"',".",",","{",";","|"]
Global $ErlaubtNachFunktionen[8]=["(",":","=","'",'"',".",","," "]
Global $ErlaubtVorParams[21]=[" ","(",",",".","=","!",">","<","[","{","'",'"',"-","+","*","/",";","|",":","&","?"]
Global $ErlaubtNachParams[23]=[" ",".",",",")","=","!",">","<",";","]","[","(","'",'"',"-","+","*","/","|",":","}","&","?"]

;Dateiliste Laden, abarbeiten und löschen.
Global $FileList=LoadFileList($CmdLine[3] & "\" & $CmdLine[1])
;Global $FileList=LoadFileList("Pluto_cache\liste1.txt")
DoWork($FileList)
FileDelete($CmdLine[3] & "\" & $CmdLine[1])

;Haupt-Programmschleife
Func DoWork($Files)
   For $a=0 to UBound($Files)-1 step 1
	  If FileGetSize($Files[$a][0] & $Files[$a][2]) > 0 Then
			RunWait('"' & @ProgramFilesDir & "\SmallSharpTools\Packer for .NET\bin\Packer.exe" & '"' & " -o " & '"' & $Files[$a][1] & $Files[$a][3] & '" -m jsmin "' & $Files[$a][0] & $Files[$a][2] & '"')
			Neutralisiere_Funktionen($Files[$a][1] & $Files[$a][3])
		 If $CmdLine[2] = 1 Then
			Del_newline($Files[$a][1] & $Files[$a][3])
		 EndIf
	  Else
		FileCopy($Files[$a][0] & $Files[$a][2], $Files[$a][1] & $Files[$a][3])
	 EndIf 
   Next
EndFunc

;Neutralisiert die Parameter jeder Funktion und die Namen der Funktionen und Klassen die in der Stringersatz.txt stehen
Func Neutralisiere_Funktionen($sFilePath)
	;$inlineparams=ObjCreate("System.Collections.Stack") ;----------------------------
	$paramstotal=0
   local $aArray
   _FileReadToArray($sFilePath, $aArray)
    Global $a_length = $aArray[0]
	_ArrayDelete($aArray, 0)
	ConsoleWrite("Datei: " & $sFilePath & @CRLF & @CRLF)
	$i=0
   While $i < ($a_length)	  
	  ;3 Ifs ineinander um eine Funktionsdeklaration zu erkennen
	  $n=1
	  If StringInStr($aArray[$i], ":function(", 1, $n)>0 or StringInStr($aArray[$i], "=function(", 1, $n)>0 Then
		 
		 If StringInStr($aArray[$i], ":function(", 1, $n)>0 Then
			$iPos=StringInStr($aArray[$i], ":function(", 1, $n)+1
		 Else
			$iPos=StringInStr($aArray[$i], "=function(", 1, $n)+1
		 EndIf
		 ;Funktions-Kopfende, Funktions-Definitionsende Finden, Damit Parameter finden und damit Die Parameter Neutralisieren
		 $CloseTag = FindClose($aArray, $i, $iPos+7)
		 $parameter = Find_Params($aArray, $i, $CloseTag[0], $iPos+8, $CloseTag[1])
		 $FEnde=Finde_Funktionsende($aArray, $i,$iPos+8)
		 
		 ConsoleWrite("Von (" & $i+1 & "," & $iPos & ") Bis (" & $FEnde[0]+1 & "," & $FEnde[1] & ") -> Parameter: " & _ArrayToString($parameter,", ") & @CRLF)
		 ;local $cacheinlineparams[2]=[$FEnde[0],UBound($parameter)] ;----------------------------
		 ;$inlineparams.push($Cacheinlineparams) ;----------------------------
		 
		 $aArray = Neutralize_params($aArray, $i, $iPos, $FEnde[0], $FEnde[1], $parameter, $paramstotal)
		 $paramstotal=$paramstotal + UBound($parameter)
;$n=$n+1
	 EndIf
	 
;~ 	 if  $paramstotal > 0 Then ;----------------------------
;~ 		$endcheck=$inlineparams.peek ;----------------------------
;~ 		if $i=$endcheck[0] Then ;----------------------------
;~ 			$paramstotal=$paramstotal-$endcheck[1] ;----------------------------
;~ 			$inlineparams.Pop ;----------------------------
;~ 		EndIf ;----------------------------
;~ 	EndIf ;----------------------------

	  ;Die For-Schleife zum Neutralisieren der Funktionsnamen
	  for $j = 0 to UBound($FunktionenReplace)-1 step 1
		 $aArray[$i]=StrReplace($aArray[$i],$FunktionenReplace[$j][0],$FunktionenReplace[$j][1],$ErlaubtVorFunktionen,$ErlaubtNachFunktionen)
	 Next
	  $i=$i+1
   WEnd
   _FileWriteFromArray($sFilePath, $aArray)
EndFunc


;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



Func Del_newline($FilePath)
   local $aArray
   _FileReadToArray($FilePath, $aArray)
   $a_length = $aArray[0]-8 ;a_length ist hier 975-8´(8 ist hier die anzahl der auskommentierten zeilen am anfang der .js file, die durch den packer eingefügt wurden
   _ArrayDelete($aArray, 0) ;Den ersten String im Array Löschen (er beinhaltet die anzahl der Zeilen der Datei)
   
   ; veränderungen am javaskript vornehmen, bevor er in eine zeile gepackt wird.
   for $i = 0 to ($a_length-1) step 1
	  
	  ;eine Lücke hinter jedes else packen, das am direkten zeilenende steht.
	  If StringRight($aArray[$i], 4) = "else" Then
		 If Stringleft($aArray[$i+1],1) <> "{" Then
			$aArray[$i]=$aArray[$i] & " "
		 EndIf
	  EndIf
	  
	  ;Fehlende Simikoli am ende von Strings einsetzen.
	  If StringRight($aArray[$i], 1) =  "'" or StringRight($aArray[$i], 1) = '"' Then
		 If StringInStr($aArray[$i+1],"}") = 0 Then
			$aArray[$i]=$aArray[$i] & ";"
		 EndIf
	  EndIf
	  
	  ;Die Kommentarzeilen die der Packer an den anfang packt entfernen
	  $StringBegin = StringLeft($aArray[$i], 2)
	  if $StringBegin = "/*" or $StringBegin = " *" or $StringBegin = "*/" or $StringBegin = "//" Then
		 _ArrayDelete($aArray, $i)
		 $a_length=$a_length-1
		 $i = $i - 1
	  EndIF
   next
   
   ;Den gesamten Text nach Ifs durchsuchen, die direkt am zeilenende stehen, auf die in der nächsten zeile keine { steht, um eine lücke dahinter zu setzen, um fehler zu vermeiden
   For $j=0 to ($a_length-2) step 1
	  If StringRight($aArray[$j],1)=")" Then
		 For $i = 0 to (StringLen($aArray[$j])-1) step 1
			If CharAt($aArray[$j],$i) = "i" and CharAt($aArray[$j], ($i+1)) = "f" and CharAt($aArray[$j], ($i+2)) = "(" Then
			
			   ;Überprüfung ob das If am zeilenende Steht und ob die nächste zeile mit { anfängt
			   If (FindClose($aArray, $j,($i+2))+1) = StringLen($aArray[$j]) and CharAt($aArray[($j+1)],0) <> "{" Then
				  $aArray[$j]=$aArray[$j] & " "
			   EndIf
			EndIf
		 next
	  EndIf
   next
   
   ;Alle zeilen in eine Zeile hintereinander packen
   $sLang = _ArrayToString($aArray,"")
   
   ;;alle )ifs mit );ifs ersetzen, um fehler zu vermeiden
   $sLang = StringReplace($sLang,"}if","};if")
   While StringInStr($sLang,")if")>0
	  $ifPos=StringInStr($sLang,")if")
	  $start=FindOpen($sLang,$ifPos)
	  If SubString($sLang, $start-1, $start) = "if" Then
		 $sLang = StringReplace($sLang,")if",") if",1)
	  Else
		 $sLang = StringReplace($sLang,")if",");if",1)
	  EndIf
   Wend
   ;Bei jeder } überprüfen ob ein zeichen aus $aCheck folgt, und wenn ja ein simikolon zwischen } und das zeichen packen, ausser dieses zeichen ist bildet mit den folgenden ein wort aus dem Array $aCheck2
   For $i = 0 to (StringLen($sLang)-1) step 1
	  If CharAt($sLang,$i) = "}" Then
		 _ArraySearch($aCheck, CharAt($sLang,($i+1)))
		 $error1=@error
		 $error2=0
		 for $j=0 to UBound($aCheck2)-1 step 1
			if $aCheck2[$j] = SubString($sLang, $i+2, $i+Stringlen($aCheck2[$j])+1) Then
			   $error2=1
			endIf
		 Next
		 if $error1 <> 6 and $error2 = 0 Then
			$sLang = _StringInsert($sLang, ";", ($i+1))
		EndIf
	  EndIf
   next
   
   ;Zieldatei öffnen und den Copyright String und die Code-zeile eintragen, und die Datei anschließend speichern und schliessen.
   $fhandle = FileOpen($FilePath,2)
   FileWrite($fHandle, "// Copyright by Isopedia GmbH / Germany - Dortmund / 2011" & @CRLF)
   FileWrite($fHandle, $sLang)
   FileFlush($fHandle)
   FileClose($fHandle)
EndFunc

;CharAt gibt den Char an der stelle $iPos vom String $sString zurück
Func CharAt($sString, $iPos)
   return StringLeft(StringRight($sString, (StringLen($sString)-$iPos)), 1)
EndFunc

;FindClose gibt die Position der schliessenden klammer einer methode oder bedingung wieder, egal wie viele zeichen und klammern in dieser methode/bedingung sind
Func FindClose($sString, $iLine, $iPos)
	  $iLength=StringLen($sString[$iLine])
      ;die nächste öffnende oder schliessende klammer finden
	  While CharAt($sString[$iLine], $iPos) <> "(" and CharAt($sString, $iPos) <> ")"
		 $iPos=$iPos+1
		 if $iPos = $iLength Then
			$iLine = $iLine+1
			$iPos = 0
			$iLength = StringLen($sString[$iLine])
		 EndIf
	  WEnd
	  
	  ;solange weitersuchen bis die schliessende klammer gefunden wurde, die die einleitende öffnende klammer schliesst.
	  $iCount=1
	  While $iCount > 0
		 $iPos=$iPos+1
		 if $iPos = $iLength Then
			$iLine = $iLine+1
			$iPos = 0
			$iLength = StringLen($sString[$iLine])
		 EndIf
		 if CharAt($sString[$iLine],$iPos) = "(" Then
			$iCount=$iCount+1
		 EndIf
		 if CharAt($sString[$iLine],$iPos) = ")" Then
			$iCount=$iCount-1
		 EndIf
	  WEnd
      local $return[2] = [$iLine,$iPos]
	  return $return
EndFunc

;Wie FindClose, aber umgekehrt, es findet die öffnende Klammer
Func FindOpen($sString, $iPos)
   $iLength=StringLen($sString)
   ;die nächste öffnende oder schliessende klammer finden
   While CharAt($sString, $iPos) <> "(" and CharAt($sString, $iPos) <> ")" and $iPos>=0
	 $iPos=$iPos-1
   WEnd
   ;solange weitersuchen bis die schliessende klammer gefunden wurde, die die einleitende öffnende klammer schliesst.
   $iCount=1
   While $iCount > 0 and $iPos>=0
	  $iPos=$iPos-1
	  if CharAt($sString,$iPos) = "(" Then
		 $iCount=$iCount-1
	  EndIf
	  if CharAt($sString,$iPos) = ")" Then
		 $iCount=$iCount+1
	  EndIf
   WEnd
   return $iPos
EndFunc
   
;Gibt den teil-string zwischen &iStart und $iEnd aus dem String $sString zurück
Func SubString($sString, $iStart, $iEnd)
   $sString=StringRight($sString,Stringlen($sString)+1-$iStart)
   $sString=StringLeft($sString, ($iEnd+1-$iStart))
   return $sString
EndFunc


;Findet die Schliessende geschweifte klammer zu der geschweiften öffnenden Klammer an $iPos in der Zeile $iLine
Func Finde_Funktionsende($sString, $iLine, $iPos)
	  $iLength=StringLen($sString[$iLine])
      ;die nächste öffnende oder schliessende klammer finden
	  While CharAt($sString[$iLine], $iPos) <> "{" and CharAt($sString, $iPos) <> "}"
		 $iPos=$iPos+1
		 if $iPos = $iLength Then
			$iLine = $iLine+1
			$iPos = 0
			$iLength = StringLen($sString[$iLine])
		 EndIf
	  WEnd
	  ConsoleWrite("     Tatsächlicher Anfang bei (" & $iLine & "," & $iPos & ")" & @CRLF)
	  ;solange weitersuchen bis die schliessende klammer gefunden wurde, die die einleitende öffnende klammer schliesst.
	  $iCount=1
	  While $iCount > 0
		 $iPos=$iPos+1
		 if $iPos >= $iLength Then
			$iLine = $iLine+1
			$iPos = 0
			$iLength = StringLen($sString[$iLine])
		 EndIf
		 if CharAt($sString[$iLine],$iPos) = "{" Then
			$iCount=$iCount+1
		 EndIf
		 if CharAt($sString[$iLine],$iPos) = "}" Then
			$iCount=$iCount-1
		 EndIf
	  WEnd
	  ConsoleWrite("     Ende Gefunden bei (" & $iLine & "," & $iPos & ")" & @CRLF)
	  Local $FunktionsEnde[2]=[$iLine, $iPos]
	  return $FunktionsEnde
   EndFunc

;Find_Params werden anfangs und Endposition der Funkstionsdefinition gegeben, und es gibt ein Array mit den in diesem Bereich definierten Funktionen zurück
Func Find_Params($aFile, $iLine, $iEndLine, $iPos, $iEndPos)
   $params = ObjCreate("System.Collections.Queue")
   $String = ""
   $CheckLen = StringLen($aFile[$iLine])
   While $iLine<$iEndLine or $iPos<$iEndPos
	  $Char=CharAt($aFile[$iLine], $iPos)
	  if $Char = "," Then
		 $params.Enqueue($String)
		 $String = ""
	  ElseIf $Char <> " " Then
		 $String = $String & $Char
	  EndIf
	  $iPos = $iPos+1
	  If $iPos = $CheckLen Then
		 $iLine = $iLine+1
		 $iPos = 0
		 $CheckLen = StringLen($aFile[$iLine])
	  EndIf
   WEnd
   
   If $String <> "" Then
	  $params.Enqueue($String)
   EndIf
   return $params.ToArray
EndFunc

;Neutralize_Params wird anfags und endzeile der Funktion, und ein Array mit den zu ersetzenden Parametern gegeben. Die funktion gibt das gesamte Array, aber mit der angepasster Funktion zurück
Func Neutralize_params($array, $startLine, $startPos, $endLine, $EndPos, $paramNames, $paramstotal)
   for $i = $startLine to $endLine step 1
	  for $j = 0 to UBound($paramNames)-1 step 1
		 If $i=$endLine Then
			$linelength=StringLen($array[$i])
			$array[$i] = StrReplace($array[$i],$paramNames[$j],"_" & StrAtNr($j + $paramstotal) & "_",$ErlaubtVorParams,$ErlaubtNachParams,0,1,1,0,$EndPos)
			$linelength=$linelength-StringLen($array[$i])
			$EndPos=$EndPos-$linelength
		 ElseIf $i=$startLine Then
			$array[$i] = StrReplace($array[$i],$paramNames[$j],"_" & StrAtNr($j + $paramstotal) & "_",$ErlaubtVorParams,$ErlaubtNachParams,0,1,1,$startPos,0)
		 Else
			$array[$i] = StrReplace($array[$i],$paramNames[$j],"_" & StrAtNr($j + $paramstotal) & "_",$ErlaubtVorParams,$ErlaubtNachParams,0,1,1,0,0)
		 EndIf
	  Next
   Next
   return $array
EndFunc

;Liest die Datei aus, welche die zu ersetzenden Funktions und Klassennamen enthält, und gibt ein 2D array zurück, welches die Funktionsnamnen und ihre ersatznamen enthält
Func Read_replace($sFile)
   Local $farray[_FileCountLines($sFile)][2]
   Local $array
   _FileReadToArray($sFile,$array)
   _ArrayDelete($array, 0)
   $i=0
   $skipit=0
   while $i<UBound($farray)
	  If CharAt($array[$i],0) = ";" Then
		 _ArrayDelete($farray, $i)
	  Else
		 If StringinStr($array[$i],"//")>0 Then
			$farray[$i][0]=SubString($array[$i],1,StringinStr($array[$i],"//")-1)
		 Else
			$farray[$i][0]=$array[$i]
		 EndIf
		 If StrAtNr($i+$skipit)="if" or StrAtNr($i+$skipit)="var" or StrAtNr($i+$skipit)="for" or StrAtNr($i+$skipit)="in" or StrAtNr($i+$skipit)="try" or StrAtNr($i+$skipit)="do" Then
			$skipit=$skipit+1
		 EndIf
		 $farray[$i][1]=StrAtNr($i+$skipit)
	  EndIf
	  $i=$i+1
   Wend
   return $farray
EndFunc

;Wie Read_Replace, allerdings werden die Ersatz-Funktionsnamen nicht dynamisch erstellt, sondern statischd aus der Stringersatz datei gelesen.
Func Read_replace_Static($sFile)
   Local $farray[_FileCountLines($sFile)][2]
   Local $array
   _FileReadToArray($sFile,$array)
   _ArrayDelete($array, 0)
   $i=0
   while $i<UBound($farray)
	  If CharAt($array[$i],0) = ";" Then
		 _ArrayDelete($farray, $i)
	  Else
		 Local $cache=StringSplit($array[$i],",")
		 _ArrayDelete($cache, 0)
		 $farray[$i][0]=$cache[0]
		 
		 If StringinStr($cache[1],"//")>0 Then
			$farray[$i][1]=SubString($cache[1],1,StringinStr($cache[1],"//")-1)
		 Else
			$farray[$i][1]=$cache[1]
		 EndIf
	  EndIf
	  $i=$i+1
   Wend
   return $farray
EndFunc


;Durchsucht den String $Input nach dem String $SearchFor. Falls $SearchFor gefunden wird, und davor was aus dem Array $ErlaubtVor steht, und dahinter ewas aus ErlaubtNach steht, dann wird der String mit $Replace ersetzt
;Wenn AnfangErlaubt auf 1 ist, und der zu suchende String ganz am anfagn steht, wird das Array $ErlaubtVor ignoriert (da ja nichts davor ist). Analog dazu mit EndeErlaubt.
;Der Modus kann die Wirkung von $ErlaubtVor und $ErlaiubtNach umdrehen. Wenn $Modus=1 ist, sind es keine Erlaubt-Listen, sondern Verboten-Listen, und es wird ersetzt wenn davor/dahinter nichts aus der Liste steht.
Func StrReplace($Input, $SearchFor, $Replace, $ErlaubtVor, $ErlaubtNach, $Modus=0, $AnfangErlaubt=1, $EndeErlaubt=0, $StartPos=0, $EndPos=0)
   $i = StringInStr($Input, $SearchFor, 1)-1
   If $StartPos>$i and $StartPos>0 Then
	  $i=$StartPos
   EndIf
   if $i>=0 Then
	  If $EndPos=0 Then
		 $EndPos=StringLen($Input)
	  EndIf
	  While $i < $EndPos
		 $j = 0
		 While Asc(CharAt($Input, $i+$j)) = Asc(CharAt($SearchFor, $j)) and $j < StringLen($SearchFor)
			If $j = StringLen($SearchFor)-1 Then
				  $ersetzen1=$Modus
				  $ersetzen2=$Modus
			   
			   If $i=0 Then
				  If $AnfangErlaubt=1 Then
					 $ersetzen1=1
				  Else
					 $ersetzen1=0
				  EndIf
			   Else
				  For $k = 0 to UBound($ErlaubtVor)-1 step 1
					 If $i+1>=StringLen($ErlaubtVor[$k]) Then
						If SubString($Input, $i+1-StringLen($ErlaubtVor[$k]), $i) == $ErlaubtVor[$k] Then
						   If $Modus=0 Then
							  $ersetzen1=1
						   Else
							  $ersetzen1=0
						   EndIf
						EndIf
					 EndIf
				  Next
			   EndIf
			   
			   
			   If ($i+$j+1)=StringLen($Input) Then
				  If $EndeErlaubt=1 Then
					 $ersetzen2=1
				  Else
					 $ersetzen2=0
				  EndIf  
			   Else
				  For $k = 0 to UBound($ErlaubtNach)-1 step 1
					If StringLen($Input)-($i+$j+1)>=StringLen($ErlaubtNach[$k]) Then
					   If SubString($Input, $i+$j+2, $i+$j+1+StringLen($ErlaubtNach[$k])) == $ErlaubtNach[$k] Then
						  If $Modus=0 Then
							 $ersetzen2=1
						  Else
							 $ersetzen2=0
						  EndIf
					   EndIf
					EndIf
				  Next
			   EndIf
			   
			   If $ersetzen1 = 1 and $ersetzen2=1 Then
				  $Input = StringLeft($Input, $i) & $Replace & StringRight($Input, StringLen($Input)-($i+$j+1))
				  $EndPos=$EndPos + (StringLen($Replace) - StringLen($SearchFor))
			   EndIf
				  
			EndIf
		   $j = $j +1
		 WEnd
		 $i = $i + 1
	  WEnd
   EndIf
   Return $Input
EndFunc

;Gibt einen String zurück, der für jede Zahl einzigartig ist, alphabetisch aufsteigend.
Func StrAtNr($dec)
   $bin=""
   While $dec>=26
	  $dec=$dec-26
	  $bin=Chr(97+mod($dec, 26)) & $bin
	  $dec=Floor($dec/26)
   Wend
   return Chr(97+mod($dec, 26)) & $bin
EndFunc

;Läd die Liste mit den Dateien, die es abzuarbeiten gilt.
Func LoadFileList($name)
   Local $Files[_FileCountLines($name)][4]
   Local $array
   _FileReadToArray($name,$array)
   _ArrayDelete($array, 0)
   $b=0
   while $b<UBound($Files)
	  $cache=StringSplit($array[$b],";")
	  $Files[$b][0]=$cache[1]
	  $Files[$b][1]=$cache[2]
	  $Files[$b][2]=$cache[3]
	  $Files[$b][3]=$cache[4]
	  $b=$b+1
   Wend
   Return $Files
EndFunc