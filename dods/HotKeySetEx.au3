
#include <MouseTrapEvent.au3>

; This UDF extends AutoIT HotKeySet by adding the much requested Mouse Button Clicks

; HotKeySet (autoIT) only does KEYBOARD
; HotKeySetEx Does both KEYBOARD and MOUSE!

; eg new MOUSE 'hotkeys' eg. {RCLICK} 
; *See MouseTrapEvent UDF for what mouse button events you can set. Mouse side X buttons supported!
; usage same as HotKeySet 
; 	HotKeySetEx("{RCLICK}", "myfun") ; mouse hot key
; 	HotKeySetEx("{F1}", "myfun") ; normal hot key (same as HotKeySet)
;
; new function call replaces @HotKeyPressed
; 	getLastHotKey() =  eg {RCLICK} or {F1}
; new function to get hotkeytype
;	getLastHotKeyType() = "MOUSE" or "KEYBOARD"  
;
; *Note you should call getLastHotKey() in your hotkey function - see example script 
;
;~ func myfun() ; user defined function for hot key
;~    dim $hotkey 
;~    $hotkey = getLastHotKey() 
;~    $hotkeyType = getLastHotKeyType() 
;~    ConsoleWrite("hotkey  " &  $hotkey & " " & $hotkeyType  & @CRLF)
;~ endfunc
;
; advanced settings third parameter $block is only for mouse events See MouseTrapEvent
; 1 default blocks mouse click behaviour and redirect to $fun (hotkey behaviour)
; 0 intercept click in $fun then allow normal click behaviour
; -1 user function $fun determine block or non block by returning block 1 or not block 0 
; 


global $gLastHotKeyPressed = ""; Last Hot key pressed
global $gLastHotKeyType = "" ; Last Hot key pressed type


Func HotKeySetEx($hotkey, $fun, $block = 1) ; default 1 block 0 intercept allow normal behavour and only for mouse events
   ; if the the hot key name contains the word CLICK then its a mouse button.
   if  Stringinstr(StringUpper($hotkey), "CLICK") >  0  then ; Mouse hot key 
	  Dim $mouseHotKey ; local
	  $mouseHotKey = $hotkey
	  $mouseHotKey = stringreplace(  $mouseHotKey, "{","") ; remove { } for mousetrap interface
	  $mouseHotKey = stringreplace(  $mouseHotKey, "}","")
	  if $fun = "" Then
		  _MouseTrapEvent($mouseHotKey) ; deregister
	   else
		  _MouseTrapEvent($mouseHotKey,  $fun, $block) ; 1 = block action and redirect to $fun
	  endif
	else  
	   HotkeySet($hotkey, $fun) ; normal AutoIt
   endif
EndFunc


func getLastHotKey() ; call this in your function.  Equivalent to @HotKeyPressed see example script
   setLastHotKey()
   return  $gLastHotKeyPressed ;
endfunc   

func getLastHotKeyType() ; call this in your function.  Optional if you want type KEYBOARD or MOUSE
   setLastHotKey()
   return  $gLastHotKeyType ;
endfunc

func setLastHotKey() ; 
   Dim $sLastMouseEventPressed
   $sLastMouseEventPressed = __MouseTrapEvent_getLastMouseEventPressed()
   if $sLastMouseEventPressed <> "" Then 
	  $gLastHotKeyPressed = "{" & $sLastMouseEventPressed  & "}" 
	  $gLastHotKeyType = "Mouse"	  
   Else 
	  $gLastHotKeyPressed = @HotKeyPressed
	  $gLastHotKeyType = "Keyboard"
   endif
   return  $gLastHotKeyPressed ;
endfunc 



