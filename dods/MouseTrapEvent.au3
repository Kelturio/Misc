
#CS

    Title:          MouseTrapEvent UDF
    Filename:       MouseTrapEvent.au3
    Description:    Remaps mouse buttons or trap mouse events and/or do something.
    Author:         This UDF is 'merging' of two udfs. JRowe's mouse event udf and (Mr)CreatoR's MouseSetEvent UDF's
					This UDF was created to address issues with these udfs. Also this udf handles x buttons.
					Interface similar to  MouseSetEvent without window handle param.


    Version:        1.0
    Requirements:   Works on win7 (tested 32/64 bit) - 3 button mouse & 5 button X button mouse
    Uses:           WindowsConstants.au3, WinAPI.au3
	Forum Link:
    Notes:
				    0) If you register a double click the single click is blocked!
					 (bug my apols) you can register a single click event in any case but single click is blocked.
					1) This UDF also handles X buttons NAV BACK and FORWARD
					2) Not optimised. A lot of string processing should be using int constants.
					   Comment out events your not using to make faster eg. mouse move etc.
					3) When using double click events , single click event is registered to prevent hanging.
					4) When any click event is registered the mouse down event is blocked also, to prevent hanging.
					5) When using obfuscator, make sure to add event functions to ignore list (#Obfuscator_Ignore_Funcs)?

					6) Blocking $sFuncName function with commands such as "Msgbox()" can lead to unexpected behavior,
					   the return to the system should be as fast as possible!

    ChangLog:
			v1.0 [21.02.2012] beta
			v1.1 [21.07.2014] beta - added __MouseTrapEvent_getLastMouseEventPressed() for HotKeySetEx UDF,
									Made event param case insensitive
									Double click left and middle now work



			* First public release.
#CE



#include-once

#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>


Global Const $MSLLHOOKSTRUCT = $tagPOINT & ";dword mouseData;dword flags;dword time;ulong_ptr dwExtraInfo"
Global Const $MOUSETRAPEVENT_DUMMY  = "_MouseTrapEvent_Dummy"

Global $currentEvent[2]
Global $currentDownEvent[2]

Global $lastEvent = ""

Global $iLBUTTONDOWN = 0
Global $iRBUTTONDOWN = 0
Global $iMBUTTONDOWN = 0
Global $iXBUTTONDOWNNumber = 0 ; 1 or 2 xtra buttons
Global $LRClickStatus = 0
Global $RLClickStatus = 0
Global $LRDrag = 0
Global $RLDrag = 0
Global $LMDrag = 0
Global $RMDrag = 0
Global $doubleClickTime = 400


Global $gLastMouseEventPressed = "" ; Added for HotKeySetEx  UDF
;Global $gLastHotKeyPressed = ""; Last Hot key pressed Added for HotKeySetEx  UDF
;Global $gLastHotKeyType = "" ; Last Hot key pressed type Added for HotKeySetEx  UDF


; Mouse On event variables
Global $a__MSOE_Events[1][1]
Global $a__MSOE_DblClk_Data			= __MouseTrapEvent_GetDoubleClickData()
$doubleClickTime = $a__MSOE_DblClk_Data[0] + 50

Global $hKey_Proc
Global $hM_Module
Global $hM_Hook


; #FUNCTION# ====================================================================================================
; Name...........:	_MouseTrapEvent
; Description....:	Set an events handler (a hook) for Mouse device based on MouseSetEvent.udf.
; Syntax.........:	_MouseTrapEvent($iEvent, $sFuncName = "", $hTargetWnd = 0, $iBlockDefProc = -1, $vParam = "")
; Parameters.....:	$sEvent 		- The event to set, here is the list of
;					supported event stings:- Case InSensitive!
;
;					single clicks
;					LClick - left button click (Primary)
;					MClick - middle button click (Wheel click)
;					RClick - right button click (Secondary)
;					XClick1 - Xtra button 1 click (usually 'back navigaton')
;					XClick2 - Xtra button 2 click (usually 'forward navigaton')

;  					double clicks
;					LDClick - left button (Primary)
;					MDClick - middle button  (Wheel click)
;					RDClick - right button  (Secondary)
;					XDClick1 - Xtra button 1  (usually 'back navigaton')
;					XDClick2 - Xtra button 2  (usually 'forward navigaton')

; 					psuedo double clicks ('chords') -
;					XClick12 - Xtra button 1&2 pressed at the same time.
;
;					OTHER EVENTS you'll have to work out yourself eg mouse wheel scroll - see code.

;					$sFuncName 		- [Optional] Function name to call when the event is triggered.
;										If this parameter is empty string ("") or omited, the function will *unset* the $iEvent.
;
;					$iBlockDefProc 	- [Optional] Defines if the up event should be blocked (actualy block the mouse action).
;										If this parameter =
;										-1 (default), user defined event function defines whether to block or not
;										 1 (call function and block)
;										 0 (call function and continue normal mouse behaviour).
;									  Note for all click and double click events the down event is always blocked to prevent hanging.
;
;
;					$vParam 		- [Optional] Parameter to pass to the event function ($sFuncName).
;
; Return values..:	Success 		- If the event is set in the first time, or when the event is unset properly, the return is 1,
;										if it's set on existing event, the return is 2.
;					Failure 		- Returns 0 on UnSet event mode when there is no set events yet.
; Author.........:	credits G.Sandler (Mr)CreatoR
; Remarks........:
;					2) Blocking of $sFuncName function by window messages with commands
;                     such as "Msgbox()" can lead to unexpected behavior, the return to the system should be as fast as possible!
; Related........:	MouseSetEvent.udf
; Link...........:
; Example........:	Yes.
; ===============================================================================================================
Func _MouseTrapEvent($iEvent, $sFuncName = "",  $iBlockDefProc = -1, $vParam = "")
	local $i
	local $iUserEventCount = 0
	local $hTargetWnd = 0 ; not used
	$iEvent = stringreplace(StringUpper($iEvent), "CLICK", "Click") ; make case insensitive, to do Drag and Wheel and Up Down

	If $sFuncName = "" Then ;Unset Event
		If $a__MSOE_Events[0][0] < 1 Then
			Return 0
		EndIf

		Local $aTmp_Mouse_Events[1][1] = [[0]]

		For $i = 1 To $a__MSOE_Events[0][0]
		    ; keep events that don't match or internal dummy events used for double clicks.
			If $a__MSOE_Events[$i][0] <> $iEvent or $a__MSOE_Events[$i][1] = $MOUSETRAPEVENT_DUMMY Then
				$aTmp_Mouse_Events[0][0] += 1
				ReDim $aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]+1][5]

				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][0] = $a__MSOE_Events[$i][0]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][1] = $a__MSOE_Events[$i][1]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][2] = $a__MSOE_Events[$i][2]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][3] = $a__MSOE_Events[$i][3]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][4] = $a__MSOE_Events[$i][4]
				if $a__MSOE_Events[$i][1] <> $MOUSETRAPEVENT_DUMMY then
					 $iUserEventCount += 1
				endif
			EndIf
		Next

		$a__MSOE_Events = $aTmp_Mouse_Events


	    If $iUserEventCount < 1 Then
			__MouseTrapEvent_Close()
 		EndIf

		Return 1
	EndIf

	;First event
	If $a__MSOE_Events[0][0] < 1 Then
			;Register callback
			$hKey_Proc = DllCallbackRegister("_MouseTrapEvent_MouseProc", "int", "int;ptr;ptr")
			$hM_Module = DllCall("kernel32.dll", "hwnd", "GetModuleHandle", "ptr", 0)
			$hM_Hook = DllCall("user32.dll", "hwnd", "SetWindowsHookEx", "int", $WH_MOUSE_LL, "ptr", DllCallbackGetPtr($hKey_Proc), "hwnd", $hM_Module[0], "dword", 0)

	Endif


	;Search thru events, and if the event already set, we just (re)set the new function and other parameters
	For $i = 1 To $a__MSOE_Events[0][0]
		If $a__MSOE_Events[$i][0] = $iEvent Then
			If $sFuncName = $MOUSETRAPEVENT_DUMMY Then
				; event already handled by user - no need for dummy event
				return 1
			Endif
			$a__MSOE_Events[$i][0] = $iEvent
			$a__MSOE_Events[$i][1] = $sFuncName
			$a__MSOE_Events[$i][2] = $hTargetWnd
			$a__MSOE_Events[$i][3] = $iBlockDefProc
			$a__MSOE_Events[$i][4] = $vParam

			Return 2
		EndIf
	 Next



	$a__MSOE_Events[0][0] += 1
	ReDim $a__MSOE_Events[$a__MSOE_Events[0][0]+1][5]

	$a__MSOE_Events[$a__MSOE_Events[0][0]][0] = $iEvent
	$a__MSOE_Events[$a__MSOE_Events[0][0]][1] = $sFuncName
	$a__MSOE_Events[$a__MSOE_Events[0][0]][2] = $hTargetWnd
	$a__MSOE_Events[$a__MSOE_Events[0][0]][3] = $iBlockDefProc
	$a__MSOE_Events[$a__MSOE_Events[0][0]][4] = $vParam

    ; if double click event - attempt to register a dummmy event for single click if one dosen't exist- to prevent hanging
	if StringInStr($iEvent , "DClick" ) > 0 Then
		 _MouseTrapEvent( StringReplace($iEvent, "DClick","Click") ,   $MOUSETRAPEVENT_DUMMY , 0, 0 )
	endif
	; if multi button click event - attempt to register a dummmy single click event for each button - to prevent hanging
	if $iEvent = "XClick12" Then
		 _MouseTrapEvent( "XClick1" ,   $MOUSETRAPEVENT_DUMMY , 0, 0 )
		 _MouseTrapEvent( "XClick2" ,   $MOUSETRAPEVENT_DUMMY , 0, 0 )
	endif

	Return 1
 EndFunc

Func _MouseTrapEvent_Dummy()
   ; dummy function for unregistered click events of double clicks
   return 0;
EndFunc

Func _MouseTrapEvent_MouseProc($nCode, $wParam, $lParam)
    Local $info, $mouseData, $time, $timeDiff
    If $nCode < 0 Then
        $ret = DllCall("user32.dll", "long", "CallNextHookEx", "hwnd", $hM_Hook[0], _
                "int", $nCode, "ptr", $wParam, "ptr", $lParam)
        Return $ret[0]
    EndIf

    $info = DllStructCreate($MSLLHOOKSTRUCT, $lParam)
    $mouseData = DllStructGetData($info, 3)
    $time = DllStructGetData($info, 5)
    $timeDiff = $time - $currentEvent[1]
    Select
        Case $wParam = $WM_MOUSEMOVE
            ;Test for Drag in here
            If $currentEvent[0] <> "LDrag" Or $currentEvent[0] <> "LRDrag" Or $currentEvent[0] <> "LMDrag" Then
                If $iLBUTTONDOWN = 1 Then
                    $currentEvent[0] = "LDrag"
                    If $iRBUTTONDOWN = 1 Then
                        $currentEvent[0] = "LRDrag"
                        $LRDrag = 2
                    EndIf
                EndIf
            EndIf
            If $currentEvent[0] <> "RDrag" Or $currentEvent[0] <> "RMDrag" Or $currentEvent[0] <> "LRDrag" Then
                If $iRBUTTONDOWN = 1 Then
                    $currentEvent[0] = "RDrag"
                EndIf
            EndIf

            If $currentEvent[0] <> "MDrag" Then
                If $iMBUTTONDOWN = 1 Then
                    $currentEvent[0] = "MDrag"
                    $currentEvent[1] = $time
                EndIf
            EndIf

            If $iRBUTTONDOWN = 1 And $iMBUTTONDOWN = 1 And $currentEvent[0] <> "RMDrag" Then
                $RMDrag = 2
                $currentEvent[0] = "RMDrag"
                $currentEvent[1] = $time
            EndIf

            If $iLBUTTONDOWN = 1 And $iMBUTTONDOWN = 1 And $currentEvent[0] <> "LMDrag" Then
                $LMDrag = 2
                $currentEvent[0] = "LMDrag"
                $currentEvent[1] = $time
            EndIf

        Case $wParam = $WM_MOUSEWHEEL
            If _WinAPI_HiWord($mouseData) > 0 Then
                ;Wheel Up
                $currentEvent[0] = "WheelUp"
                $currentEvent[1] = $time
            Else
                ;Wheel Down
                $currentEvent[0] = "WheelDown"
                $currentEvent[1] = $time
            EndIf

        Case $wParam = $WM_LBUTTONDOWN
            ;Register Button Down, check for Right/Left
            If $currentEvent[0] = "RClick" Then
                $LRClickStatus = 1
            EndIf

            $iLBUTTONDOWN = 1
			$currentDownEvent[0] = 'LClick'



        Case $wParam = $WM_LBUTTONUP
            ;Update $iLBUTTONDOWN
            $iLBUTTONDOWN = 0
			$currentDownEvent[0] = ''

            ;Test for Right/Left Click
            If $RLClickStatus = 1 And ($timeDiff) < $doubleClickTime Then
                $currentEvent[0] = "RLClick"
                $currentEvent[1] = $time
            EndIf
            If $lastEvent   = "LClick" And ($timeDiff) < $doubleClickTime Then
                $currentEvent[0] = "LDClick"
                $currentEvent[1] = $time
            EndIf
            ;Test for Drops
            If $currentEvent[0] = "LDrag" Then
                $currentEvent[0] = "LDrop"
                $currentEvent[1] = $time
            EndIf

            If $LRDrag = 2 And $iRBUTTONDOWN = 1 Then
                $LRDrag = 1 ; Denote $LRDrag as still having one button clicked, need to register the drop on RButton up
            EndIf

            If $LRDrag = 1 And $iRBUTTONDOWN = 0 Then
                $currentEvent[0] = "LRDrop"
                $currentEvent[1] = $time
                $LRDrag = 0
            EndIf



            If $LMDrag = 2 And $iMBUTTONDOWN = 1 Then
                $LMDrag = 1 ; Denote $LMDrag as still having one button clicked, need to register the drop on MButton up
            EndIf

            If $LMDrag = 1 And $iMBUTTONDOWN = 0 Then
                $currentEvent[0] = "LMDrop"
                $currentEvent[1] = $time
                $LMDrag = 0
            EndIf

            ;Set LClick if other events haven't fired
            If $currentEvent[1] <> $time Then
                $currentEvent[0] = "LClick"
                $currentEvent[1] = $time
            EndIf

            ;Negate $LRClickStatus
            $RLClickStatus = 0



        Case $wParam = $WM_RBUTTONDOWN
            ;Register Button Down
            If $currentEvent[0] = "LClick" Then
                $RLClickStatus = 1
            EndIf
            $iRBUTTONDOWN = 1
			$currentDownEvent[0] = 'RClick'

        Case $wParam = $WM_RBUTTONUP
            ;Test for Left, Right, and Right Doubleclick here
            ;Update $iRBUTTONDOWN
            $iRBUTTONDOWN = 0
			$currentDownEvent[0] = '';

            ;Test for Right/Left Click
            If $LRClickStatus = 1 And ($timeDiff) < $doubleClickTime Then
                $currentEvent[0] = "LRClick"
                $currentEvent[1] = $time
            EndIf


            If $lastEvent  = "RClick" And ($timeDiff) < $doubleClickTime Then
                $currentEvent[0] = "RDClick"
                $currentEvent[1] = $time
            EndIf
            ;Test for Drops
            If $currentEvent[0] = "RDrag" Then
                $currentEvent[0] = "RDrop"
                $currentEvent[1] = $time
            EndIf

            If $LRDrag = 2 And $iLBUTTONDOWN = 1 Then
                $LRDrag = 1 ; Denote $LRDrag as still having one button clicked, need to register the drop on RButton up
            EndIf

            If $LRDrag = 1 And $iLBUTTONDOWN = 0 Then
                $currentEvent[0] = "LRDrop"
                $currentEvent[1] = $time
                $LRDrag = 0
            EndIf



            If $RMDrag = 2 And $iMBUTTONDOWN = 1 Then
                $RMDrag = 1 ; Denote $LMDrag as still having one button clicked, need to register the drop on MButton up
            EndIf

            If $RMDrag = 1 And $iMBUTTONDOWN = 0 Then
                $currentEvent[0] = "RMDrop"
                $currentEvent[1] = $time
                $RMDrag = 0
            EndIf

            ;Set LClick if other events haven't fired
            If $currentEvent[1] <> $time Then
                $currentEvent[0] = "RClick"
                $currentEvent[1] = $time
            EndIf

            ;Negate $LRClickStatus
            $LRClickStatus = 0


        Case $wParam = $WM_MBUTTONDOWN
            ;Register Button Down
            $iMBUTTONDOWN = 1
			$currentDownEvent[0] = 'MClick'

        Case $wParam = $WM_MBUTTONUP
            ;Test for Middle Double Click here
            ;Update $iRBUTTONDOWN
            $iMBUTTONDOWN = 0
			$currentDownEvent[0] = ''

            ;Test for Right/Left Click
            If $lastEvent   = "MClick" And ($timeDiff) < $doubleClickTime Then
                $currentEvent[0] = "MDClick"
                $currentEvent[1] = $time
            EndIf
            ;Test for Drops
            If $currentEvent[0] = "MDrag" Then
                $currentEvent[0] = "MDrop"
                $currentEvent[1] = $time
            EndIf

            If $LMDrag = 2 And $iLBUTTONDOWN = 1 Then
                $LMDrag = 1 ; Denote $LRDrag as still having one button clicked, need to register the drop on RButton up
            EndIf

            If $LMDrag = 1 And $iLBUTTONDOWN = 0 Then
                $currentEvent[0] = "LMDrop"
                $currentEvent[1] = $time
                $LMDrag = 0
            EndIf



            If $RMDrag = 2 And $iRBUTTONDOWN = 1 Then
                $RMDrag = 1 ; Denote $LMDrag as still having one button clicked, need to register the drop on MButton up
            EndIf

            If $RMDrag = 1 And $iRBUTTONDOWN = 0 Then
                $currentEvent[0] = "RMDrop"
                $currentEvent[1] = $time
                $RMDrag = 0
            EndIf

            ;Set MClick if other events haven't fired
            If $currentEvent[1] <> $time Then
                $currentEvent[0] = "MClick"
                $currentEvent[1] = $time
            EndIf
		 Case $wParam = $WM_XBUTTONDOWN
			$iXBUTTONDOWNNumber = _WinAPI_HiWord($mouseData)

			$currentDownEvent[0] = 'XClick'  & $iXBUTTONDOWNNumber

		 Case $wParam = $WM_XBUTTONUP

			local $iXbuttonNumber = _WinAPI_HiWord($mouseData)


			If ( $lastEvent = "XClick1"  or $lastEvent = "XClick2" )  And ($timeDiff) < $doubleClickTime Then
				  IF StringRight($lastEvent, 1) = $iXBUTTONDOWNNumber then
					 $currentEvent[0] = "XDClick" & $iXbuttonNumber
					 $currentEvent[1] = $time
				  Else
					 $currentEvent[0] = "XClick12" ; both X buttons pressed simultaneously
					 $currentEvent[1] = $time

				  endif
			EndIf


			;Set XClick if other events haven't fired
			If $currentEvent[1] <> $time Then
			   If $iXbuttonNumber > 0 Then
				   ;standard win 2000+ Xtra button pressed, append 1 or 2 to event name
				   $currentEvent[0] = "XClick" & $iXbuttonNumber
				   $currentEvent[1] = $time

			   EndIf
			endif


			$iXBUTTONDOWNNumber = 0 ; reset
			$currentDownEvent[0] = ''
    EndSelect

	if $currentEvent[0] <> "" Then
		  $lastEvent = $currentEvent[0]
	endif
	if __MouseTrapEvent_Remap($currentEvent[0]) = 1 then
		return 1;
	endif

    $ret = DllCall("user32.dll", "long", "CallNextHookEx", "hwnd", $hM_Hook[0], _
            "int", $nCode, "ptr", $wParam, "ptr", $lParam)

    Return $ret[0]
EndFunc   ;==>_Mouse_Proc

; local function - not user callable
Func __MouseTrapEvent_Remap($sEvent)
		;search for event to block
		For $i = 1 To $a__MSOE_Events[0][0]

			;Handle / block down events - done to prevent lock ups
			if $a__MSOE_Events[$i][0] = $currentDownEvent[0] Then

				Return 1; block handle event

			endif



			; handle click - up events.
			If $a__MSOE_Events[$i][0] = $sEvent  Then
				;Handle events

				local $iBlockDefProc_Ret = $a__MSOE_Events[$i][3]

				local $sFuncName =  $a__MSOE_Events[$i][1]

				$iRet = Call($sFuncName, $sEvent, $a__MSOE_Events[$i][4])

				If @error Then
					$iRet = Call($sFuncName, $sEvent)

					If @error Then
						$iRet = Call($sFuncName)
					EndIf
				EndIf


				If $iBlockDefProc_Ret = -1 Then
					$iBlockDefProc_Ret = $iRet
				EndIf

				$currentEvent[0] = ""
				Return $iBlockDefProc_Ret ;Block default processing (or not :))
			EndIf
		Next
	    Return 0 ; don't bypass
EndFunc   ;==>_Mouse_Proc

; call this from HotKeySetEx for mouse hotkeys.
Func __MouseTrapEvent_getLastMouseEventPressed()

   For $i = 1 To $a__MSOE_Events[0][0]
			local $sFuncName =  $a__MSOE_Events[$i][1]
			; If current event a registered hotkey then it will be the last pressed
			if $a__MSOE_Events[$i][0] = $currentEvent[0] and $sFuncName <> "" and $sFuncName <> $MOUSETRAPEVENT_DUMMY Then
			   return $currentEvent[0]; hot key found
			endif
   Next

   return ""

EndFunc   ;==>OnAutoItExit


; called this to shut down without having to deregister all events.
Func __MouseTrapEvent_Close()

    DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $hM_Hook[0])
    $hM_Hook[0] = 0
    DllCallbackFree($hKey_Proc)
    $hKey_Proc = 0

    ; clear all events
    Dim $a__MSOE_Events[1][1]

EndFunc   ;==>OnAutoItExit



Func __MouseTrapEvent_GetDoubleClickData()
	Local $aRet[3] = _
		[ _
			RegRead('HKEY_CURRENT_USER\Control Panel\Mouse', 'DoubleClickSpeed'), _
			RegRead('HKEY_CURRENT_USER\Control Panel\Mouse', 'DoubleClickWidth'), _
			RegRead('HKEY_CURRENT_USER\Control Panel\Mouse', 'DoubleClickHeight') _
		]

	Local $aGDCT = DllCall('User32.dll', 'uint', 'GetDoubleClickTime')

	If Not @error And $aGDCT[0] > 0 Then
		$aRet[0] = $aGDCT[0]
	EndIf

	Return $aRet
EndFunc