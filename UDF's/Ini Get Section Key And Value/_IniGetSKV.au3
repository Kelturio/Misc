For $i = 1 To 6
    IniWrite(@ScriptDir & '\MyIniTest.ini', "section 1", "Key" & $i, "val" & $i)
Next
For $i = 1 To 3
    IniWrite(@ScriptDir & '\MyIniTest.ini', "section 2", "Key" & $i, "val" & $i)
Next
Global $IniInfo = _IniGetSKV(@ScriptDir & '\MyIniTest.ini')
_ArrayIniDisplay($IniInfo, 'IniInfo')
Func _IniGetSKV($hIniLocation)
    ;Get All Sections
    Local $aSections = IniReadSectionNames($hIniLocation)
    If @error Then Return SetError(1, 0, 0)
    ;Get All The Keys and Values for Each section
    Local $aKeyValues[$aSections[0] + 1][1][3], $nCount;Added $nCount
    For $iCount = 1 To $aSections[0]
        $aKV = IniReadSection($hIniLocation, $aSections[$iCount])
        If @error Then ; If empty section then only get name
            $aKeyValues[$iCount][0][0] = 0
            $aKeyValues[$iCount][1][0] = $aSections[$iCount]
            ContinueLoop
        EndIf
        If $nCount < $aKV[0][0] Then;Added this condition statement
            $nCount = $aKV[0][0]
            ReDim $aKeyValues[$aSections[0] + 1][$aKV[0][0] + 1][3]
        EndIf
        $aKeyValues[$iCount][0][0] = $aKV[0][0];Added this
        For $xCount = 1 To $aKV[0][0]
            $aKeyValues[$iCount][$xCount][0] = $aSections[$iCount]
            $aKeyValues[$iCount][$xCount][1] = $aKV[$xCount][0]
            $aKeyValues[$iCount][$xCount][2] = $aKV[$xCount][1]
        Next
    Next
    $aKeyValues[0][0][0] = $aSections[0]
    Return $aKeyValues ;Return a 3 Dimensional Array
EndFunc   ;==>_IniGetSKV


Func _ArrayIniDisplay($aArray, $sTitle = '')
    If Not IsArray($aArray) Then SetError(1, 0, 0)
    Local $sIni = '[0][0][0] = ' & $aArray[0][0][0] & ' Sections' & @CR
    For $xCC = 1 To $aArray[0][0][0]
        $sIni &= @CR & '[' & $xCC & '][0][0] = ' & $aArray[$xCC][0][0] & ' Keys/Values' & @CR & _
            '[' & $xCC & '][1][0] = ' & $aArray[$xCC][1][0] & @CR ; Get section name from first line
        For $aCC = 1 To $aArray[$xCC][0][0]
            $sIni &= '[' & $xCC & '][' & $aCC & '][1] = ' & $aArray[$xCC][$aCC][1] & @CR & _
                '[' & $xCC & '][' & $aCC & '][2] = ' & $aArray[$xCC][$aCC][2] & @CR
        Next
    Next
    MsgBox(0, $sTitle, StringTrimRight($sIni, 1))
EndFunc