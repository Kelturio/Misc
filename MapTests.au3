#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_Outfile=MapTests.exe
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; -------------------------------------------------------------------------------------------
; Map Tests
;
; Requires AutoIt beta (v3.3.13.18 tested)
; -------------------------------------------------------------------------------------------
; NOTES:
; -----
; - Embedding other complex datatypes:
;   Anything inserted in Arrays and Maps are COPIES of the objects,
;   EXCEPT for DLLStruct's, which are reference types (at least in current AutoIt versions)
;   So, modifying embedded Arrays and Maps will NOT alter the originals
;
; - Calling functions:
;   Must be done using Map["func"]() or (Map.func)()
;   Functions in Arrays work with Arr[i]()
;
; - Arrays within Maps/Arrays:
;   Write access:
;    No manner of subscript access works, and parentheses around an expression causes a copy
;    to be made, which discards the value at the end of the statement
;    A function taking an Array ByRef can be used to workaround the problem, however
;
;   Read access:
;    dot-member access works:
;     Map.arr[0]
;    However for both Maps and arrays, using subscript operators requires parentheses:
;     (Map["arr"])(0)
;     (Arr[0])[0]
;
; - Maps inside maps:
;   Read/Write access:
;     Map["map"]["val"]
;     Map.map.val
;
; - Maps within Arrays:
;   Write access:
;     Arr[3].data
;   Read access:
;     Arr[3].data
;     (Arr[3])["data"]
;
; - DLLStructs' produce references to the original structure (in current AutoIt versions)
;   Read/Write access depends on Array or Map container:
;     Arr[i].stVal
;     Map["struct"].stVal
;     Map.struct.stVal
;
; -------------------------------------------------------------------------------------------

Func MyFunc()
    ConsoleWrite("Called MyFunc"&@LF)
EndFunc

Func ShowString(Const ByRef $mMap)
    If MapExists($mMap, "myString") Then ConsoleWrite("Map string = " & $mMap.myString & @LF)
EndFunc

Func ModifyArrayValue(ByRef $aArr, Const $i, Const ByRef $vData)
    If IsArray($aArr) Then $aArr[$i] = $vData
EndFunc

Func TestMaps()
    Local $aArr[4], $mMap[], $mMap2[]
    ;Dim $mMap2[]    ; Also works for declaring/redeclaring variable as Map

    ;; -= Function call Tests -=

    ; Indirect function call using array
    $aArr[0] = MyFunc
    $aArr[0]()

    ; Indirect function call using Map & array-style access
    $mMap["func"] = MyFunc
    $mMap["func"]()

    ; Indirect function call using Map & member/property access
    $mMap2.func = MyFunc
    ; Awkward syntax which works (Au3Check fails to handle this, however)
    ($mMap2.func)()
    ;$mMap2.func()  ; Preferred syntax (which doesn't work)

    ;; -= Value assignment Tests =-

    ; array-style assign & access:
    $mMap["val"] = 1
    ConsoleWrite("Map1 value = " & $mMap["val"] & @LF)

    ; member/property version
    $mMap2.val = 4
    ConsoleWrite("Map2 value = " & $mMap2.val & @LF)

    ; More values
    $mMap["myString"] = "aMap string"
    $mMap2.myString = "aMap2 string"

    ; Passing maps as parameters
    ShowString($mMap)
    ShowString($mMap2)

    ;; -= Embedded Array tests =-

    Local $aEmbedArr[2] = [1, 2]

    ; Makes *COPY* of array inside Map
    $mMap.arr = $aEmbedArr

    ; Modifying embedded array:

    ; Member/property access doesn't work:
    ;$mMap.arr[0] = 20

    ; Parentheses around a value forces a copy to be made [per Jon], not a reference:
;~     ($mMap.arr)[0] = 20    ; copy is made, and discarded

    ; array-style access doesn't work either:
    ;$mMap["arr"][0] = 20

    ; Indirect workaround (pass array as reference):
    ModifyArrayValue($mMap.arr, 0, 20)


    ConsoleWrite("Map:Embedded-Array elements:"&@LF)
    ; array-style access
    For $i = 0 To UBound($mMap["arr"]) - 1
        ; Note Awkward syntax for getting internal array element:
        ; ($mMap["arr"])($i)
        ConsoleWrite("#" & $i & " = " & ($mMap["arr"])[$i] & @LF)
    Next

    ; Member/property access:
    ConsoleWrite("[alternate member/property access]:"&@LF)
    For $i = 0 To UBound($mMap.arr) - 1
        ConsoleWrite("#" & $i & " = " & $mMap.arr[$i] & @LF)
    Next

    ; .. 'EmbeddedArray' value remains the same as its initial assignment:
    ConsoleWrite("..aEmbedArr[0] = " & $aEmbedArr[0] & @LF)

    ;; - Embedded array in array (no Map) -

    ; Makes *COPY* of EmbedArray inside Array
    $aArr[1] = $aEmbedArr

    ; Doesn't work:
    ;$aArr[1]0] = 40

    ; Parentheses around a value forces a copy to be made [per Jon], not a reference:
;~     ($aArr[1])[0] = 40 ; copy is made, and discarded

    ; Indirect workaround (pass array as reference):
    ModifyArrayValue($aArr[1], 0, 40)

    ConsoleWrite("Array:Embedded-Array elements:"&@LF)
    ; array-style access
    For $i = 0 To UBound($aArr[1]) - 1
        ; Note Awkward syntax for getting internal array element:
        ; ($aArr[1])[$i]
        ConsoleWrite("#" & $i & " = " & ($aArr[1])[$i] & @LF)
    Next


    ; .. 'EmbeddedArray' value remains the same as its initial assignment:
    ConsoleWrite("..aEmbedArr[0] = " & $aEmbedArr[0] & @LF)

    ;; -= Structures =-

    Local $tStruct = DllStructCreate("int MyInt;")
    ; Structure normal access:
    DllStructSetData($tStruct, "MyInt", 10)

    ; Structure property-access:
    $tStruct.myInt = 20

    ; Assign structure to Map (actually creates a reference rather than a copy)
    $mMap.struct = $tStruct

    ; Modify structure data (both ways work)
    $mMap.struct.myInt = 40
    $mMap["struct"].myInt = 60

    ConsoleWrite("mMap.struct.myInt = " & $mMap.struct.myInt & @LF)

    ; Struct Inside array (creates reference to original struct)

    $aArr[3] = $tStruct
    $aArr[3].myInt = 80
    ConsoleWrite("aArr[3].myInt = " & $aArr[3].myInt & @LF)

    ; Original Structure is modified by all operations above (even embedded in Maps or Arrays)
    ConsoleWrite("tStruct.myInt = " & $tStruct.myInt & @LF)
    ConsoleWrite("DLLStructGetData($tStruct, 'myInt') = " & DllStructGetData($tStruct, "myInt") &@LF)


    ;; -= Maps within Maps =-

    Local $mEmbedMap[]
    $mEmbedMap.innerVal = 4

    ; This causes a *COPY* of $mEmbedMap to be added to $mMap:
    $mMap.embeddedMap = $mEmbedMap

    ; Modifying the embedded map doesn't affect the external one
    $mMap.embeddedMap.innerVal = 10
    ConsoleWrite("Map.embeddedMap.innerVal = " & $mMap.embeddedMap.innerVal & @LF)
    ; Alternate ways of writing the above line:
    ; (Note how 2 subscripts can be used here, as opposed to embedded arrays):
    ConsoleWrite("Map[embeddedMap][innerVal] = " & $mMap["embeddedMap"]["innerVal"] & @LF)
    ConsoleWrite("Map[embeddedMap].innerVal = " & $mMap["embeddedMap"].innerVal & @LF)


    ; .. 'EmbedMap' value remains the same as its initial assignment:
    ConsoleWrite("..EmbedMap.innerVal = " & $mEmbedMap.innerVal & @LF)

    ;; -= Maps within Arrays =-

    ; Creates a *COPY* of Map inside array
    $aArr[3] = $mEmbedMap

    $aArr[3].innerVal = 20
    ; Parentheses around a value forces a copy to be made [per Jon], not a reference:
;~     ($aArr[3])["innerVal"] = 40 ; copy is made, and discarded

    ConsoleWrite("Arr[embeddedMap].innerVal = " & $aArr[3].innerVal &@LF)
    ; Note Awkward syntax for getting internal array element:
    ; ($aArr[3])["innerVal"]
    ConsoleWrite("(Arr[embeddedMap])[innerVal] = " & ($aArr[3])["innerVal"] &@LF)

    ; .. 'EmbedMap' value remains the same as its initial assignment:
    ConsoleWrite("..EmbedMap.innerVal = " & $mEmbedMap.innerVal & @LF)

EndFunc

TestMaps()