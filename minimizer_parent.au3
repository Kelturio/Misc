#include <File.au3>
#include <Array.au3>
#include <String.au3>


$begin=TimerInit()
Global $settings

_FileReadToArray($CmdLine[2], $settings)
_ArrayDelete($settings, 0)
$Threads=$settings[0]

Global $sSource = $settings[1] ;Quell-ordner
Global $sDest = $settings[2] ;ziel-Ordner

$cache=StringSplit($settings[3],";")
_ArrayDelete($cache, 0)

Global $aSkip=$cache ;Ordner, die beim enrypten ausgelassen werden sollen

$cache=StringSplit($settings[4],";")
_ArrayDelete($cache, 0)

Global $aCopySkip=$cache ;Ordner die komplett ignoriert werden
Global $Sizes[$Threads]
Global $Files[$Threads]
Global $PIDs[$Threads]

For $t=0 to $Threads-1 step 1
   $Sizes[$t]=0
   $Files[$t]=ObjCreate("System.Collections.Stack")
Next

If $sSource="FormBuilder" Then
   Global $replaceStack = Read_Replace("FormBuilder/Framework/FormBuilder/FormBuilder.js")
EndIf

Copy_Directory($sSource) ;den Formbuilder-ordner kopieren
DelFiles_Recursive($sDest) ;Alle .js dateien aus dem angegebenen ordner und allen unterordnern löschen
EncryptFiles_Recursive($sSource) ;Alle .js dateien im angegebenen Ordner Encrypten

DirCreate($sSource & "_cache")

For $t=0 to $Threads-1 step 1
   _FileWriteFromArray($sSource & "_cache" & "\" & "liste" & ($t+1) & ".txt", $Files[$t].ToArray)
   $Pids[$t]=Run("minimizer_child.exe liste" & ($t+1) & ".txt " & $CmdLine[1] & " " & $sSource & "_cache")
Next
$ready=0
While $ready=0
   $ready=1
   for $s = 0 to $Threads-1 step 1
	  If ProcessExists($PIDs[$s]) Then
		 $ready=0
	  EndIf
   Next
   Sleep(1000)
WEnd
DirRemove($sSource & "_cache")
If $sSource="FormBuilder" Then
   Replace("FormBuilder_minimized/Framework/FormBuilder/FormBuilder.js", $replaceStack)
   For $z=0 to UBound($replaceStack)-1 step 1
	  $cachen2=$replaceStack[$z]
	  If FileExists($cachen2[3] & "/" & $cachen2[1])=0 Then
		 CopyFile($cachen2[2] & "/" & $cachen2[0],$cachen2[3] & "/" & $cachen2[1])
	  EndIf
   Next
EndIf

;MsgBox(0,"minimizer","Fertig." & @CRLF & "Benötigte Zeit: " & Round(TimerDiff($begin)/1000) & " Sekunden")

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
Func DelFiles_Recursive($sSourceFolder)
     Local $sFile
     If StringRight($sSourceFolder, 1) <> "\" Then $sSourceFolder &= "\"
		
     ; Alle -js dateien im aktuellen ordner löschen
	 FileDelete($sSourceFolder & "*.js")
     Local $hSearch = FileFindFirstFile($sSourceFolder & "*.*")
     ; If no files found then return
     If $hSearch = -1 Then Return ; This is where we break the recursive loop <<<<<<<<<<<<<<<<<<<<<<<<<<
		 
         ; Now run through the contents of the folder
         While 1
            ; Get next match
            $sFile = FileFindNextFile($hSearch)
            ; If no more files then close search handle and return
            If @error Then ExitLoop  ; This is where we break the recursive loop <<<<<<<<<<<<<<<<<<<<<<<<<<
			
			$extended = @extended
			_ArraySearch($aSkip, $sFile)
			$error = @error
			
			; Check if a folder
            If $extended and $error = 6 Then
			   DelFiles_Recursive($sSourceFolder & $sFile)
             EndIf
         WEnd
         FileClose($hSearch)
EndFunc
	  
Func Copy_Directory($sSourceFolder)
 
     Local $sFile
     If StringRight($sSourceFolder, 1) <> "\" Then $sSourceFolder &= "\"
 
     ; Start the search
     Local $hSearch = FileFindFirstFile($sSourceFolder & "*.*")
     ; If no files found then return
     If $hSearch = -1 Then Return ; This is where we break the recursive loop <<<<<<<<<<<<<<<<<<<<<<<<<<
		 local $sDestPath = StringRight($sSourceFolder, (StringLen($sSourceFolder)-StringLen($sSource)))
		 $sDestPath = $sDest & $sDestPath
         ; Now run through the contents of the folder
         While 1
             $sFile = FileFindNextFile($hSearch)
             If @error Then ExitLoop  ; This is where we break the recursive loop <<<<<<<<<<<<<<<<<<<<<<<<<<
 
 			$extended = @extended
			_ArraySearch($aCopySkip, $sFile)
			$error = @error
			
             ; Check if a folder
             If $extended and $error = 6 Then
                 ; If so then call the function recursivelyß
				 DirCreate($sDestPath & $sFile)
                 Copy_Directory($sSourceFolder & $sFile)
             Elseif not $extended Then
			   FileCopy($sSourceFolder & $sFile, $sDestPath  & $sFile)
             EndIf
         WEnd
         FileClose($hSearch)
EndFunc

;Diese Funktion stellt die Listen für die einzelnen Child-Prozesse zusammen
Func EncryptFiles_Recursive($sSourceFolder)
 
     Local $sFile
     If StringRight($sSourceFolder, 1) <> "\" Then $sSourceFolder &= "\"
 
     ; Start the search
     Local $hSearch = FileFindFirstFile($sSourceFolder & "*.*")
     ; If no files found then return
     If $hSearch = -1 Then Return ; This is where we break the recursive loop <<<<<<<<<<<<<<<<<<<<<<<<<<
		 local $sDestPath = StringRight($sSourceFolder, (StringLen($sSourceFolder)-StringLen($sSource)))
		 $sDestPath = $sDest & $sDestPath
         ; Now run through the contents of the folder
         While 1
             $sFile = FileFindNextFile($hSearch)
             If @error Then ExitLoop  ; This is where we break the recursive loop <<<<<<<<<<<<<<<<<<<<<<<<<<
 
 			$extended = @extended
			_ArraySearch($aSkip, $sFile)
			$error = @error 
			
			_ArraySearch($aCopySkip, $sFile)
			$error2 = @error
 
             ; Check if a folder
             If $extended and  $error = 6 and $error2 = 6 Then
                 ; If so then call the function recursively
                 EncryptFiles_Recursive($sSourceFolder & $sFile)
             Elseif not $extended Then
                 ; If a file than Check if its a js file nad handle it
				 
				 ;es wurde eine Datei gefunden. überprüfen obs eine js datei ist
				  If StringCompare(StringRight($sFile,3), ".js") = 0 Then
					 ;Die Liste mit der kleinsten dateimenge rausfinden
					 $index=_ArrayMinIndex($Sizes,1)
					 $Sizes[$index]=$Sizes[$index] + FileGetSize($sSourceFolder & $sFile)
					 
					 ;Falls replacestack definiert ist (das Projekt also der FormBuilder ist) den ersatznamen gegebenenfalls mit dem Randomnamen ersetzten, ansonsten den original namen asl ersatznamen benutzen
					 $replace=$sFile
					 If IsDeclared("replaceStack")<>0 Then
						For $w=0 to UBound($replaceStack)-1 step 1
						   $cachen=$replaceStack[$w]
						   If $sFile = $cachen[0] Then
							  $replace = $cachen[1]
						   EndIf
						Next
					 EndIf
					 $Files[$index].Push($sSourceFolder & ";" & $sDestPath & ";" & $sFile& ";" & $replace)
				  EndIf					 
             EndIf
         WEnd
         FileClose($hSearch)
EndFunc

;Liest die FormBuilder.js aus und baut einen Stack
;Jedes Stack-Element ist ein Array mit 4 Feldern. Das erste enthält den Original-Namen, das zweite den Random-Namen, das dritte den original-Pfad und das vierte den Pfad der Datei im minimized Ordner
Func Read_Replace($FB_Path)
   Local $FormBuilder
   Local $r_Strings = ObjCreate("System.Collections.Stack")
   _FileReadToArray($FB_Path, $FormBuilder)
   _ArrayDelete($FormBuilder,0)
   For $i=0 to UBound($FormBuilder)-1 step 1
	  If StringInStr($FormBuilder[$i],'loader.AddJS(pageMain.formBuilderPath + "/FormBuilder/')>0 Then
		 $cache=_ArrayToString(_StringBetween($FormBuilder[$i],'"','"'),"")
		 $Pfad =_ArrayToString(StringSplit($cache,"/"),"/",2,UBound(StringSplit($cache,"/"))-2)
		 $OriginalPfad=_ArrayToString(StringSplit($FB_Path,"/"),"/",1,1) & "/" & _ArrayToString(StringSplit($Pfad,"/"),"/",2)
		 $minimizedPfad =_ArrayToString(StringSplit($FB_Path,"/"),"/",1,1) & "_minimized/" & _ArrayToString(StringSplit($Pfad,"/"),"/",2)
		 $File =_ArrayToString(StringSplit($cache,"/"),"/",UBound(StringSplit($cache,"/"))-1,UBound(StringSplit($cache,"/"))-1)
		 
		 $skip=0
		 $error=0
		 $test=StringSplit($OriginalPfad,"/")
		 _ArrayDelete($OriginalPfad,0)
		 for $t=0 to UBound($test)-1 step 1
			_ArraySearch($aSkip, $test[$t])
			$error = @error
			if $error<>6 Then
				$skip=1
			EndIf
		 Next
			
		 If $skip=0 Then
			Local $ready[4]=[$File,RandomString(10) & ".js",$OriginalPfad,$minimizedPfad]
			$r_Strings.push($ready)
		 EndIf
		 
	  EndIf
   Next
   return $r_Strings.ToArray
EndFunc

;öffnet die FormBuilder.js und ersetzt die Original-Dateinamen falls nötig mit den Random generierten Dateinamen
Func Replace($FB_Path, $replaceArray)
   Local $FormBuilder
   _FileReadToArray($FB_Path, $FormBuilder)
   _ArrayDelete($FormBuilder,0)
   For $j=0 to UBound($FormBuilder)-1 step 1
	  For $i=0 to UBound($replaceArray)-1 step 1
		 $cachen2=$replaceArray[$i]
		 $FormBuilder[$j] = StringReplace($FormBuilder[$j], $cachen2[2] & "/" & $cachen2[0], $cachen2[2] & "/" & $cachen2[1])
	  Next
   Next
   _FileWriteFromArray("FormBuilder_minimized/Framework/FormBuilder/FormBuilder.js", $FormBuilder)
EndFunc

;Erzeugt einen zufalls-String der länge $length
Func RandomString($length)
   If IsDeclared("randoms")=0 Then
	  Global $randoms = ObjCreate("System.Collections.Stack")
   EndIf
   $RString=""
   For $i=0 to $length-1 step 1
	  $random1=Random(0,2,1)
	  Select
	  Case $random1=0
		 $RString = $RString & Chr(Random(65, 90, 1)) ;A-Z
	  Case $random1=1
		 $RString = $RString & Chr(Random(97, 122, 1)) ;a-z
	  Case $random1=2
		 $RString = $RString & Chr(Random(48, 57, 1)) ;0-9
	  EndSelect
   Next
   If $randoms.Contains($RString) Then
	  $RString=RandomString($length)
   EndIf
   $randoms.push($RString)
   Return $RString
EndFunc

;Kopiert die Datei $Source nach $Destination. Falls Der Ziel(unter-)Ordner noch nicht exestiert, wird er erstellt.
Func CopyFile($Source,$Destination)
   $Pfad =StringSplit($Destination,"/")
   _ArrayDelete($Pfad,0)
   $check=$Pfad[0]
   For $i=1 to UBound($Pfad)-2 step 1
	  If FileExists($check) = 0 Then
		 DirCreate($check)
	  EndIf
	  $check=$check & "/" & $Pfad[$i]
   Next
   $quelle=FileOpen($Source,256)
   $ziel=FileOpen($Destination,10)
   $error=FileWrite($ziel,FileRead($quelle))
   FileFlush($ziel)
   FileClose($quelle)
   FileClose($ziel)
EndFunc