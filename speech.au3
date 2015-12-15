
#include <Array.au3>
#include <String.au3>
#include <File.au3>
#include <FF.au3>
#include <Excel.au3>
Dim $a
_FileReadToArray('akk.txt', $a)


For $i = 1 To UBound($a) - 1
	_TalkOBJ('WURST')
;~ 	_TalkOBJ($a[$i])
Next
Func _TalkOBJ($s_text)
	Local $o_speech
	$o_speech = ObjCreate("SAPI.SpVoice")
	$o_speech.Speak($s_text)
	$o_speech = ""
EndFunc   ;==>_TalkOBJ