#NoTrayIcon
#include <Timers.au3>
#include <Array.au3>
#cs
Speed test between -
1) _ARRAYADD
2) Scripting Dictionary Add
3) Array command (inbuilt)
#ce
Global $count = 1000
Global $rnd = Random(0, 9, 1) & Random(0, 9, 1) & Random(0, 9, 1) & Random(0, 9, 1) & Random(0, 9, 1)
ConsoleWrite('-('&@ScriptLineNumber&') :['&@error&'|'&@Extended&'] $rnd = '&$rnd&@lf) ;### Debug Console
; ==================== TEST ARRAYADD ==================== ;
ConsoleWrite(@lf & '>  ==================== TEST ARRAYADD ==================== ' & @LF)
$starttime = _Timer_Init()
Dim $testarray[1]=[$count]
For $i = 1 To $count
    $ArrayAdd=_ArrayAdd($testarray, $rnd)
Next
$TEST_ARRAYADD = _Timer_Diff($starttime)
ConsoleWrite(':'&@ScriptLineNumber&': $TEST_ARRAYADD = '&$TEST_ARRAYADD&@lf) ;### Debug Console
; ======================================================= ;
; =================== TEST DICTIONARY =================== ;
ConsoleWrite(@lf & '>  =================== TEST DICTIONARY =================== ' & @LF)
$starttime = _Timer_Init()
Global $testdict = ObjCreate("Scripting.Dictionary")
For $i = 1 To $count
    $testdict.Item($i) = $rnd
Next
$TEST_DIC = _Timer_Diff($starttime)
ConsoleWrite(':'&@ScriptLineNumber&': $TEST_DIC =  '&$TEST_DIC&@lf) ;### Debug Console
; ======================================================= ;
; =================== TEST ARRAYLIST =================== ;
;~ ConsoleWrite(@lf & '>  =================== TEST DICTIONARY =================== ' & @LF)
;~ $starttime = _Timer_Init()
;~ Global $testalist = ObjCreate("System.Collections.ArrayList")
;~ For $i = 1 To $count
;~     $testlist.add($i) = $rnd
;~ Next
;~ $TEST_LIST = _Timer_Diff($starttime)
;~ ConsoleWrite(':'&@ScriptLineNumber&': $TEST_LIST =  '&$TEST_LIST&@lf) ;### Debug Console
; ======================================================= ;
; ================== TEST ARRAY DYNAMIC ================== ;
ConsoleWrite(@lf & '>  ================== TEST ARRAY DYNAMIC ================== ' & @LF)
$starttime = _Timer_Init()
Global $testarray[1] = [0]
For $i = 1 To $count
    $testarray[0] += 1
    If UBound($testarray) <= $testarray[0] Then ReDim $testarray[UBound($testarray) * 2]
    $testarray[$testarray[0]] = $rnd
Next
ReDim $testarray[$testarray[0] + 1]
$TEST_ARRAY = _Timer_Diff($starttime)
ConsoleWrite(':'&@ScriptLineNumber&': $TEST_ARRAY  = '&$TEST_ARRAY &@lf) ;### Debug Console
; ======================================================= ;
; ================== TEST ARRAY STATIC ================== ;
ConsoleWrite(@lf & '>  ================== TEST ARRAY STATIC ================== ' & @LF)
$starttime = _Timer_Init()
Global $testarray[$count]
For $i = 0 To $count - 1
    $testarray[$i] = $rnd
Next
$TEST_ARRAY_static = _Timer_Diff($starttime)
ConsoleWrite(':'&@ScriptLineNumber&': $TEST_ARRAY_static = '&$TEST_ARRAY_static&@lf) ;### Debug Console
; ======================================================= ;
MsgBox(0, "Speed Test Results:", "With _ArrayAdd = " & $TEST_ARRAYADD & @CRLF & "With ScriptingDictionary = " & $TEST_DIC & @CRLF & "With Dynamic Array = " & $TEST_ARRAY & @CRLF & "With Static Array = " & $TEST_ARRAY_static)