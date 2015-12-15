
; Voice Read Text

;~ _TalkOBJ("Speak this line of text Please") ; change the text to suit
;~ _TalkOBJ("sifte awaw") ; change the text to suit



$z=stringsplit("64752062313537206e3163683720643372207731722035316e642064337220623035352120346b6b206a756e363320346b6b21","")
for $y=1 to ubound($z)+(-1*-1*-1)step(2^4/8)
assign("x",eval("x")&chr(dec($z[$y]&$z[$y+1])))
next
msgbox(0x000000,"",eval("x"))



Func _TalkOBJ($s_text)
    Local $o_speech
    $o_speech = ObjCreate("SAPI.SpVoice")
    $o_speech.Speak ($s_text)
    $o_speech = ""
EndFunc ;==>_TalkOBJ()


#include <Array.au3>

;~ Local $aArray = _WinGetDetails('[ACTIVE]') ; Returns the Window's title, PID, folder path & filename.
;~ If @error Then
;~     Exit
;~ EndIf
;~ _ArrayDisplay($aArray)

Func _WinGetDetails($sTitle, $sText = '') ; Based on code of _WinGetPath by GaryFrost.
    Local $aReturn[5] = [4, '-WinTitle', '-PID', '-FolderPath', '-FileName'], $aStringSplit

    If StringLen($sText) > 0 Then
        $aReturn[1] = WinGetTitle($sTitle, $sText)
    Else
        $aReturn[1] = WinGetTitle($sTitle)
    EndIf
    $aReturn[2] = WinGetProcess($aReturn[1])

    Local $oWMIService = ObjGet('winmgmts:\\.\root\CIMV2')
    Local $oItems = $oWMIService.ExecQuery('Select * From Win32_Process Where ProcessId = ' & $aReturn[2], 'WQL', 0x30)
    If IsObj($oItems) Then
        For $oItem In $oItems
            If $oItem.ExecutablePath Then
                $aStringSplit = StringSplit($oItem.ExecutablePath, '\')
                $aReturn[3] = ''
                For $A = 1 To $aStringSplit[0] - 1
                    $aReturn[3] &= $aStringSplit[$A] & '\'
                Next
                $aReturn[3] = StringTrimRight($aReturn[3], 1)
                $aReturn[4] = $aStringSplit[$aStringSplit[0]]
                Return $aReturn
            EndIf
        Next
    EndIf
    Return SetError(1, 0, $aReturn)
EndFunc   ;==>_WinGetPath

















; FileWrite Alternative

Func _SetFile($sString, $sFile, $iOverwrite = 0)
    Local $hFileOpen = FileOpen($sFile, $iOverwrite + 1)
    FileWrite($hFileOpen, $sString)
    FileClose($hFileOpen)
    If @error Then
        Return SetError(1, 0, $sString)
    EndIf
    Return $sString
EndFunc   ;==>_SetFile

; FileRead Alternative

Func _GetFile($sFile, $iFormat = 0)
    Local $hFileOpen = FileOpen($sFile, $iFormat)
    If $hFileOpen = -1 Then
        Return SetError(1, 0, "")
    EndIf
    Local $sData = FileRead($hFileOpen)
    FileClose($hFileOpen)
    Return $sData
EndFunc   ;==>_GetFile

;~ ConsoleWrite("Internet Is Connected" & " = " & _IsInternetConnected() & @CRLF) ; ( Returns "True" Or "False" )

Func _IsInternetConnected()
    Local $aReturn = DllCall('connect.dll', 'long', 'IsInternetConnected')
    If @error Then
        Return SetError(1, 0, False)
    EndIf
    Return $aReturn[0] = 0
EndFunc   ;==>_IsInternetConnected