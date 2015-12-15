;*****************************************************************
;*** Script Name : Browser_Generic.au3; Shorthand: BGe_
;*** Author : Justin DeLaney
;*** Creation Date : 2012-08-30
;*** Purpose : All generic browser functions
;*** Requirements : 1) N/A
;
;*** History : 2012-08-30 : Justin DeLaney - Completed
;*****************************************************************

#region SCITE_CallTipsForFunctions
;BGe_IEGetDOMObjByXPathWithAttributes($oIEBrowser, $sXPath) Return array of objects on browser matching callers xpath (Requires: #Include "C:\QA\AutoIT\EFL\Variables.au3")
#endregion SCITE_CallTipsForFunctions
#region GLOBALVariables
Global $gsBGe_RegExpNodeSplit = "(?i)(?U)(.*(?:'.*'.*)?)(?:\/)|.{1,}?" ; Split Xpath into nodes...split by / where it is part of x-path
Global $gsBGe_RegExpOrSplit = "(?i)(?U)(.*'.*['\)])(?:\sor\s)|.{1,}?" ; Split Or statements inside []
Global $gsBGe_RegExpAndSplit = "(?i)(?U)(.*'.*['\)])(?:\sand\s)|.{1,}?" ; Split And statements inside []
Global $gsBGe_RegExpRemoveContains = "contains[.*\(](.{1,})[\)]" ; Get text inside contains()
Global $gsBGe_RegExpRepNodeNameSplit = "\[.*" ; Returns just the Node Name, and none of the conditions (NodeName)(?:[.*])
Global $gsBGe_RegExpNodeCondSplit = "(?i).*\[(.*)\]" ; Returns just the conditions (?:NodeName)([.*])
Global Enum $giBGe_AttributeCheckType = 0, _
  $giBGe_AttributeArrayName, _
  $giBGe_AttributeArrayValue, _
  $giBGe_AttributeArrayUBound
Global Enum $giBGe_CheckType_AttribVal = 0, _
  $giBGe_CheckType_AttribContVal, _
  $giBGe_CheckType_NodeVal, _
  $giBGe_CheckType_NodeContVal
; Define 2d array values for placing in data conditions for xpaths
Global Enum $giBGe_XMLArrayNode = 0, _
  $giBGe_XMLArrayIsChild, _
  $giBGe_XMLArrayIsAttribute, _
  $giBGe_XMLArrayUBound
; Define variables to create an array containing the possible Axis definitions
Global Enum $giBGe_AxisArrayAncestor = 0, _
  $giBGe_AxisArrayUBound
; $iAxisArrayAncestorOrSelf, _
; $iAxisArrayAttribute
; Create array for possible axis
Global $gasBGe_Axis[$giBGe_AxisArrayUBound]
$gasBGe_Axis[$giBGe_AxisArrayAncestor] = 'ancestor::'
#endregion GLOBALVariables
#region example usage
#include-once
#include <ie.au3>
#include <array.au3>
$oIE = _IECreate ("[url="http://www.google.com"]www.google.com[/url]")
_IELoadWait ($oIE)
; Grab the search buttons
$button_FellingLucky = "//button/span[contains(.,'I'm Feeling Lucky')]"
$button_GoogleSearch = "//button/span[contains(.,'Google Search')]"
$aFeelingLuky = BGe_IEGetDOMObjByXPathWithAttributes ($oIE, $button_FellingLucky)
If IsArray ($aFeelingLuky) Then
 ConsoleWrite("Found button count like I'm Feeling Lucky=[" & UBound($aFeelingLuky) & "]." & @CRLF)
Else
 ConsoleWrite("Unable to find button like I'm Feeling Lucky." & @CRLF)
EndIf
$aGoogleSearh = BGe_IEGetDOMObjByXPathWithAttributes ($oIE, $button_GoogleSearch)
If IsArray ($aGoogleSearh) Then
 ConsoleWrite("Found button count like Google Search=[" & UBound($aGoogleSearh) & "]." & @CRLF)
Else
 ConsoleWrite("Unable to find button like I'm Google Search." & @CRLF)
EndIf
#endregion example usage
Func BGe_IEGetDOMObjByXPathWithAttributes($oIEBrowser, $sXPath)
 Global $gbWriteStatusToConsole = False
 If $gbWriteStatusToConsole Then ConsoleWrite("Start Function=[BGe_IEGetDOMObjByXPathWithAttributes] with $sXPath=[" & $sXPath & "]." & @CRLF)
 ; When empty string is parsed, due to //, the next element is relative (not necessarily a direct child of the previous)...
 ; until // is determined, then assume node is an absolute location (direct child)
 $bAbsolutePath = True
 $bAxisPresent = False
 $iAxisStart = ""
 ; Parse out elements/attributes from $sXPath...also need to consider ancestor::
 $iCounter = 0
 ;$asXPath = StringSplit($sXPath, "/")
 $asXPath = StringRegExp($sXPath & "/", $gsBGe_RegExpNodeSplit, 3)
 Dim $aasXPath[UBound($asXPath)][$giBGe_XMLArrayUBound]
 ; Blindly setup all levels of the xpath to be a direct child of the parent, and not an attribute
 For $i = 0 To UBound($asXPath) - 1
  $aasXPath[$i][$giBGe_XMLArrayNode] = $asXPath[$i]
  $aasXPath[$i][$giBGe_XMLArrayIsChild] = True
  $aasXPath[$i][$giBGe_XMLArrayIsAttribute] = False
 Next
 ; Determine if the node should be a non-direct child of the parent, and setup if is
 For $i = 0 To UBound($aasXPath) - 1
  $iCurrent = $i - $iCounter
  $sString = $aasXPath[$iCurrent][$giBGe_XMLArrayNode]
  ; Add boolean to state that relative, not absolute
  If Not $bAbsolutePath Then
   $aasXPath[$iCurrent][$giBGe_XMLArrayIsChild] = False
   $bAbsolutePath = True ; Reset
  EndIf
  ; Check if current node is an axis
  For $j = 0 To UBound($gasBGe_Axis) - 1
   If StringLeft($aasXPath[$iCurrent][$giBGe_XMLArrayNode], StringLen($gasBGe_Axis[$j])) = $gasBGe_Axis[$j] Then
    $bAxisPresent = True
    $sAxisType = $gasBGe_Axis[$j]
    ExitLoop
   EndIf
  Next
  ; If the current string is empty, that's because // was present, setup next node to be a non-direct child
  ; Checking if IsInt to delete the first record, which is the ubound created from the string split
  If $sString = "" Or IsInt($aasXPath[$iCurrent][$giBGe_XMLArrayNode]) Or $sString = "/" Then
   _ArrayDelete($aasXPath, $iCurrent)
   $iCounter = $iCounter + 1
   $bAbsolutePath = False
  EndIf
 Next
 ; Default value, do not create Axis Array
 $bCreateAxisXPath = False
 Dim $aasAxisXpath[1][$giBGe_XMLArrayUBound]
 If $bAxisPresent Then
  ; Determin start point of axis
  For $i = 0 To UBound($aasXPath) - 1
   For $j = 0 To UBound($gasBGe_Axis) - 1
    If StringLeft($aasXPath[$i][$giBGe_XMLArrayNode], StringLen($gasBGe_Axis[$j])) = $gasBGe_Axis[$j] Then
     $iAxisStart = $i
    EndIf
   Next
  Next
  ; Build a second array for axis
  $iAxisCounter = 0
  For $i = $iAxisStart To UBound($aasXPath) - 1
   ReDim $aasAxisXpath[$iAxisCounter + 1][$giBGe_XMLArrayUBound]
   $aasAxisXpath[$iAxisCounter][$giBGe_XMLArrayNode] = $aasXPath[$i][$giBGe_XMLArrayNode]
   $aasAxisXpath[$iAxisCounter][$giBGe_XMLArrayIsChild] = $aasXPath[$i][$giBGe_XMLArrayIsChild]
   $aasAxisXpath[$iAxisCounter][$giBGe_XMLArrayIsAttribute] = $aasXPath[$i][$giBGe_XMLArrayIsAttribute]
   $iAxisCounter = $iAxisCounter + 1
  Next
  ; Delete axis from the original xpath array
  $iXPathCounter = 0
  For $i = $iAxisStart To UBound($aasXPath) - 1
   $iCurrent = $i - $iXPathCounter
   _ArrayDelete($aasXPath, $iCurrent)
   $iXPathCounter = $iXPathCounter - 1
  Next
 EndIf
 $oIEDom = $oIEBrowser.document
 Dim $tempArray[1]
 ; Get all objects that have XPATH of caller (not including AXIS yet)
 Local $tempReturnArray = BGe_RecursiveGetObjWithAttributes ($oIEDom, $aasXPath, $tempArray)
 If IsArray($tempReturnArray) Then
  For $i = UBound($tempReturnArray) - 1 To 0 Step -1
   $obj = $tempReturnArray[$i]
   If Not IsObj($obj) Then
    _ArrayDelete($tempReturnArray, $i)
   EndIf
  Next
 EndIf
 If IsArray($tempReturnArray) Then
  ;_ArrayDelete($tempReturnArray, 0)
  ; Return the objects that follow the XPath provided, if no Axis
  If Not $bAxisPresent Then
   If $gbWriteStatusToConsole Then ConsoleWrite("End   Function=[BGe_IEGetDOMObjByXPathWithAttributes] with Array containing object(s)=[" & UBound($tempReturnArray) - 1 & "]." & @CRLF)
   Return $tempReturnArray
  EndIf
 EndIf
 ; Get all objects, relative to the above DOM objects, that ALSO match the AXIS
 ; If $bAxisPresent Then
 ;  Dim $tempArray[1]
 ;  Local $tempReturnArrayAxis = Call("RecursiveGetObjThroughAxis", $tempReturnArray, $aasAxisXpath, $tempArray)
 ;  If IsArray($tempReturnArrayAxis) And UBound($tempReturnArrayAxis) > 1 Then
 ;   _ArrayDelete($tempReturnArrayAxis, 0)
 ;   ; Return the objects that follow the XPath provided, if no Axis
 ;   Return $tempReturnArrayAxis
 ;  EndIf
 ; EndIf
 ; If not returned above, then not found, return false
 Return False
EndFunc   ;==>BGe_IEGetDOMObjByXPathWithAttributes
#region InternalFunctions
Func BGe_SplitConditions($sCallersString)
 ; Pass in a string inside the [] of an xpath
 If $gbWriteStatusToConsole Then ConsoleWrite("Start Function=[BGe_SplitConditions] with $sCallersString=[" & $sCallersString & "]." & @CRLF)
 $sContainsString = "Contains"
 ; Split the or statements
 $asOrConditions = StringRegExp($sCallersString, $gsBGe_RegExpOrSplit, 3)
 ; For each or statement, split the and statements
 Dim $aasHolder[1]
 If IsArray($asOrConditions) Then
  For $i = 0 To UBound($asOrConditions) - 1
   $asAndConditions = StringRegExp($asOrConditions[$i], $gsBGe_RegExpAndSplit, 3)
   Dim $asAttrValuePair[1][2]
   ; Split the asAndConditions into it's node/value pairs...
   For $j = 0 To UBound($asAndConditions) - 1
    ReDim $asAttrValuePair[$j + 1][$giBGe_AttributeArrayUBound]
    ; 1) Node or Attribute name...[.|@example]
    ; 2) Node or Attribute value...['test']
    ; 3) Wrapped by containes?...[True|False]
    ; Determine if "contains" is present
    $stest = StringLeft(StringStripWS($asAndConditions[$j], 3), StringLen($sContainsString))
    $bIncludesContains = (StringLeft(StringStripWS($asAndConditions[$j], 3), StringLen($sContainsString)) = $sContainsString)
    ; If present, strip out the "contains.*()"
    If $bIncludesContains Then
     $sTempArray = StringRegExp($asAndConditions[$j], $gsBGe_RegExpRemoveContains, 1)
     $sTempAttNameValue = StringStripWS($sTempArray[0], 3)
     $sStringSplitChar = ","
    Else
     $sTempAttNameValue = StringStripWS($asAndConditions[$j], 3)
     $sStringSplitChar = "="
    EndIf
    ; Determine if an attribute is present, or '.'
    $asTempAttNameValue = StringSplit($sTempAttNameValue, $sStringSplitChar)
    If StringLeft(StringStripWS($asTempAttNameValue[1], 3), 1) = "." Then
     $sAttributeName = "."
     $bIsParentName = True
    Else
     ; Don't include the @
     $sAttributeName = StringRight(StringStripWS($asTempAttNameValue[1], 3), StringLen(StringStripWS($asTempAttNameValue[1], 3)) - 1)
     $bIsParentName = False
    EndIf
    $sAttributeValue = StringMid(StringStripWS($asTempAttNameValue[2], 3), 2, StringLen(StringStripWS($asTempAttNameValue[2], 3)) - 2)
    Switch $bIsParentName & $bIncludesContains
     Case False & False
      $CheckType = $giBGe_CheckType_AttribVal
     Case False & True
      $CheckType = $giBGe_CheckType_AttribContVal
     Case True & False
      $CheckType = $giBGe_CheckType_NodeVal
     Case True & True
      $CheckType = $giBGe_CheckType_NodeContVal
     Case Else
    EndSwitch
    $asAttrValuePair[$j][$giBGe_AttributeCheckType] = $CheckType
    $asAttrValuePair[$j][$giBGe_AttributeArrayName] = $sAttributeName
    $asAttrValuePair[$j][$giBGe_AttributeArrayValue] = StringStripWS($sAttributeValue, 3)
   Next
   ReDim $aasHolder[$i + 1]
   $aasHolder[$i] = $asAttrValuePair
  Next
 EndIf
 ;If Not IsArray ( $aasHolder[0] ) Then Return False
 If $gbWriteStatusToConsole Then ConsoleWrite("End   Function=[BGe_SplitConditions]." & @CRLF)
 Return $aasHolder
EndFunc   ;==>BGe_SplitConditions
Func BGe_RecursiveGetObjWithAttributes($oParent, $asXPath, $asHolder, $Level = 0)
 If $gbWriteStatusToConsole Then ConsoleWrite("Start Function=[BGe_RecursiveGetObjWithAttributes] with $Level=[" & $Level & "]." & @CRLF)
 $asObjects = $asHolder
 ; possible scenariso for the attributes...[]:
 ;First parse or, and then and conditions
 ;contains(.,'value')
 ;contains(@att,'value')
 ;.='value'
 ;@att='value'
 $asAttributesArray = ""
 ; check if there are any conditions outside of just Node Name, such as in the above examples
 ;MsgBox ( 4096, 'test', $asXPath[$Level][0] )
 ; debugging, was "\[.*\].*"
 If StringRegExp($asXPath[$Level][0], $gsBGe_RegExpNodeCondSplit) Then
  $sNodeName = StringStripWS(StringRegExpReplace($asXPath[$Level][0], $gsBGe_RegExpRepNodeNameSplit, ""), 3)
  $aNodeConditions = StringRegExp($asXPath[$Level][0], $gsBGe_RegExpNodeCondSplit, 3)
  $sNodeConditions = StringStripWS($aNodeConditions[0], 3)
  $aNodeConditions = ""
  $asAttributesArray = BGe_SplitConditions ($sNodeConditions) ; Get current Nodes qualifiers
 Else
  $sNodeName = $asXPath[$Level][0]
  $sAttributeName = ""
  $sAttributeValue = ""
  $asAttributesArray = ""
 EndIf
 ; new direction, create array to house, and loop through that
 Dim $aChildNodesCollection[1]
 $iChildNode = 0
 If Not IsObj($oParent) Then Return $asObjects
 ; Attempt to get relative vs direct child
 If $asXPath[$Level][$giBGe_XMLArrayIsChild] Then
  $TempAllChild = $oParent.childnodes
  For $TempChild In $TempAllChild
   If $TempChild.NodeName = $sNodeName Then
    ReDim $aChildNodesCollection[$iChildNode + 1]
    $aChildNodesCollection[$iChildNode] = $TempChild
    $iChildNode += 1
   EndIf
  Next
 Else
  $oParent = _IETagNameGetCollection($oParent, $sNodeName)
  For $oChildNode In $oParent
   If $oChildNode.NodeType == 1 Then ; only add nodes
    ReDim $aChildNodesCollection[$iChildNode + 1]
    $aChildNodesCollection[$iChildNode] = $oChildNode
    $iChildNode += 1
   EndIf
  Next
 EndIf
 ; Loop through parent collection
 If IsArray($aChildNodesCollection) Then
  For $iChild = 0 To UBound($aChildNodesCollection) - 1
   $oChild = $aChildNodesCollection[$iChild]
   $bFoundAttribute = True ; Default to found
   $bFoundNodeText = True ; Default to found
   ; Find matching conditions, when necessary
   If IsArray($asAttributesArray) Then
    ; contains(.,'value')
    ; contains(@att,'value')
    ; .='value'
    ; @att='value'
    ; add logic to check if conditions are met...if any attributes needed, skip
    ; Loop through OR Conditions
    For $i = 0 To UBound($asAttributesArray) - 1
     $asCurrentConditions = $asAttributesArray[$i]
     $bAndConditionsMet = True
     ; Loop through And Conditions, or conditions are outside of this loop, and will go if current and's are not met
     For $j = 0 To UBound($asCurrentConditions) - 1
      ; Verify the Node text, if needed
      Switch $asCurrentConditions[$j][$giBGe_AttributeCheckType]
       Case $giBGe_CheckType_AttribVal
        ;_ArrayDisplay ( $asCurrentConditions )
        If IsObj($oChild) Then
         Switch $asCurrentConditions[$j][$giBGe_AttributeArrayName]
          Case "class"
           If $oChild.className() <> $asCurrentConditions[$j][$giBGe_AttributeArrayValue] Then $bAndConditionsMet = False
          Case "style"
           If $oChild.style.csstext <> $asCurrentConditions[$j][$giBGe_AttributeArrayValue] Then $bAndConditionsMet = False
          Case "onclick"
           If $oChild.getAttributeNode($asCurrentConditions[$j][$giBGe_AttributeArrayName]).value <> $asCurrentConditions[$j][$giBGe_AttributeArrayValue] Then $bAndConditionsMet = False
          Case Else
           If $oChild.getAttribute($asCurrentConditions[$j][$giBGe_AttributeArrayName]) <> $asCurrentConditions[$j][$giBGe_AttributeArrayValue] Then $bAndConditionsMet = False
         EndSwitch
        Else
         $bAndConditionsMet = False
        EndIf
       Case $giBGe_CheckType_AttribContVal
        If IsObj($oChild) Then
         Switch $asCurrentConditions[$j][$giBGe_AttributeArrayName]
          Case "class"
           If Not StringInStr ($oChild.className(), $asCurrentConditions[$j][$giBGe_AttributeArrayValue] ) Then $bAndConditionsMet = False
          Case "style"
           If Not StringInStr ($oChild.style.csstext, $asCurrentConditions[$j][$giBGe_AttributeArrayValue] ) Then $bAndConditionsMet = False
          Case "onclick"
           If Not StringInStr ($oChild.getAttributeNode($asCurrentConditions[$j][$giBGe_AttributeArrayName]).value, $asCurrentConditions[$j][$giBGe_AttributeArrayValue] ) Then $bAndConditionsMet = False
          Case Else
           If Not StringInStr ($oChild.getAttribute($asCurrentConditions[$j][$giBGe_AttributeArrayName]), $asCurrentConditions[$j][$giBGe_AttributeArrayValue] ) Then $bAndConditionsMet = False
         EndSwitch
        Else
         $bAndConditionsMet = False
        EndIf
       Case $giBGe_CheckType_NodeVal
        If IsObj($oChild) Then
         If $oChild.innertext <> $asCurrentConditions[$j][$giBGe_AttributeArrayValue] Then $bAndConditionsMet = False
        Else
         $bAndConditionsMet = False
        EndIf
       Case $giBGe_CheckType_NodeContVal
        If IsObj($oChild) Then
         If Not StringInStr($oChild.innertext, $asCurrentConditions[$j][$giBGe_AttributeArrayValue]) Then $bAndConditionsMet = False
        Else
         $bAndConditionsMet = False
        EndIf
      EndSwitch
     Next
     If $bAndConditionsMet Then
      ; If last level, add the object
      If $Level = UBound($asXPath) - 1 Then
       If $gbWriteStatusToConsole Then ConsoleWrite("BGe_RecursiveGetObjWithAttributes(): Object found that matches all attribute conditions and Full XPATH1." & @CRLF)
       _ArrayAdd($asObjects, $oChild)
      Else
       If $gbWriteStatusToConsole Then ConsoleWrite("BGe_RecursiveGetObjWithAttributes(): ReCall BGe_RecursiveGetObjWithAttributes 1 " & @CRLF)
       $asObjects = BGe_RecursiveGetObjWithAttributes ($oChild, $asXPath, $asObjects, $Level + 1)
      EndIf
     EndIf
    Next

   Else
    ; NO attribute conditions are present, and node is already checked, proceed
    If $Level = UBound($asXPath) - 1 Then
     ; Final xpath level, so add to final array
     _ArrayAdd($asObjects, $oChild)
     If $gbWriteStatusToConsole Then ConsoleWrite("BGe_RecursiveGetObjWithAttributes(): Total objects to search =[" & UBound($asObjects) * "]." & @CRLF)
    Else
     ; Continue Recurssion
     If $gbWriteStatusToConsole Then ConsoleWrite("BGe_RecursiveGetObjWithAttributes(): ReCall BGe_RecursiveGetObjWithAttributes 4 " & @CRLF)
     $asObjects = BGe_RecursiveGetObjWithAttributes ($oChild, $asXPath, $asObjects, $Level + 1)
    EndIf
   EndIf
  Next
 EndIf
 Return $asObjects
EndFunc   ;==>BGe_RecursiveGetObjWithAttributes
Func BGe_RecursiveGetObjWithAxis($oStart, $asXPath, $sAxis, $asHolder, $Level = 0, $bXPATHAbsolute = True)
 ; Given a $oStart point, find an axis
 ; Continually move up XML parent until able to find the first applicable Xpath going back down
 ; Assumes Xpath going back down is Absolute to save recursion time
 $bXPATHAbsolute = True
EndFunc   ;==>BGe_RecursiveGetObjWithAxis
#endregion InternalFunctions