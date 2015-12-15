;
; TT6 movement engine and collection of useful functions
; Rev 1.3
; 27.1.2009
;
#include <Process.au3>
#include <WindowsConstants.au3>
#include "nomadmemory.au3"
#include-once

;settings
Opt("WinTitleMatchMode", 3)
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)

; mems compatible to update.ini by __wadim
Const $memx = 			IniRead("update.ini","SECTION D","POSX","Not found") 		; position x
Const $memy = 			IniRead("update.ini","SECTION D","POSY","Not found") 		; position y
Const $memmap = 		IniRead("update.ini","SECTION D","CHECK_MAP","Not found") 	; post=0, load =2, area=1
Const $memnpcidselect = IniRead("update.ini","SECTION D","NPC_ID_SELECT","Not found") ; id of selected object
Const $memnpcidnear =	IniRead("update.ini","SECTION D","NPC_ID_NEAR","Not found") ; id of nearest object
Const $memcourse = 		IniRead("update.ini","SECTION 9-A","CAMCOURSE","Not found") ; angle of compass/view direction
Const $memdeath = 		IniRead("update.ini","SECTION 9-A","DEATH","Not found") 	; alive = 0 or death = 1 
Const $memmovechar = 	IniRead("update.ini","SECTION 9-A","MOVECHAR","Not found") 	; keyboard input events
Const $memtleft = $memmovechar + 0x10 ; turn left
Const $memtright = $memmovechar + 0x14 ; turn right

; globals for movement engine
Global $gotox = 0.0, $gotoy = 0.0 , $dist = 0.0, $olddist = 0.0, $angle = 0.0, $increment = 0, $callcnt = 0
Global $client = IniRead("tt6.ini","id","windowName","Guild Wars")
$PID = WinGetProcess($client)
Global $hprocess = _MemoryOpen($PID)
Global $hwnd = WinGetHandle($client)
Global $running = False, $isDead = False, $stopCheck = False, $blockCheck = False, $gotBlocked = False
Global $accelmul = 1.0
Const $pi = 4 * ATan(1)

; keys for keyboard input simulation adapt in the tt6.ini
Const $DIactkey = IniRead("tt6.ini","keys","DIactkey","SPACE")
Const $FLactkey = IniRead("tt6.ini","keys","FLactkey","ä")
Const $ANtgtkey = IniRead("tt6.ini","keys","ANtgtkey","v")
Const $FNtgtkey = IniRead("tt6.ini","keys","FNtgtkey","c")
Const $INtgtkey = IniRead("tt6.ini","keys","INtgtkey","ö")
Const $GHpnlkey = IniRead("tt6.ini","keys","GHpnlkey","g")
Const $ARmovkey = IniRead("tt6.ini","keys","ARmovkey","r")
Const $RDmovkey = IniRead("tt6.ini","keys","RDmovkey","x")
Const $TLmovkey = IniRead("tt6.ini","keys","TLmovkey","a")
Const $TRmovkey = IniRead("tt6.ini","keys","TRmovkey","d")
Const $OCchtkey = IniRead("tt6.ini","keys","OCchtkey","RETURN")

; positions for mouse clicks adapt in the tt6.ini
Const $DTclickX = Int(IniRead("tt6.ini","click positions","DTclickX",0))
Const $DTclickY = Int(IniRead("tt6.ini","click positions","DTclickY",0))
Const $LTclickX = Int(IniRead("tt6.ini","click positions","LTclickX",0))
Const $LTclickY = Int(IniRead("tt6.ini","click positions","LTclickY",0))
Const $GHclickX = Int(IniRead("tt6.ini","click positions","GHclickX",0))
Const $GHclickY = Int(IniRead("tt6.ini","click positions","GHclickY",0))
Const $STclickX = Int(IniRead("tt6.ini","click positions","STclickX",0))
Const $STclickY = Int(IniRead("tt6.ini","click positions","STclickY",0))
Const $SBclickX = Int(IniRead("tt6.ini","click positions","SBclickX",0))
Const $SBclickY = Int(IniRead("tt6.ini","click positions","SBclickY",0))
Const $HMclickX = Int(IniRead("tt6.ini","click positions","HMclickX",0))
Const $HMclickY = Int(IniRead("tt6.ini","click positions","HMclickY",0))

;generate inventory access matrix adapt positions in the tt6.ini
Const $invMaxR = 8 ;max number of rows 0..8
Const $invMaxC = 4 ;max number of columns 0..4
Global $invPos[$invMaxC+1] [$invMaxR+1][2];matrix of positions [0]=x, [1]=y
$invPos[0][0][0] = Int(IniRead("tt6.ini","inventory offsets","invPosX00",0))
$invPos[0][0][1] = Int(IniRead("tt6.ini","inventory offsets","invPosY00",0))
$invPos[0][1][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR1",0))
$invPos[0][2][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR2",0))
$invPos[0][3][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR3",0))
$invPos[0][4][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR4",0))
$invPos[0][5][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR5",0))
$invPos[0][6][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR6",0))
$invPos[0][7][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR7",0))
$invPos[0][8][1] = Int(IniRead("tt6.ini","inventory offsets","invPosYR8",0))
$invPosXdelta = Int(IniRead("tt6.ini","inventory offsets","invPosXdelta",0))

For $ri=1 To 8
	$invPos[0][$ri][0] = $invPos[0][0][0] ;x offset of 0 element constant in every row
Next

For $ri=0 To 8
	For $ci=1 To 4
		$invPos[$ci][$ri][0] = $invPos[0][$ri][0] + $invPosXdelta *$ci ; x offset increases by number of column
		$invPos[$ci][$ri][1] = $invPos[0][$ri][1] ; y offset equal to 0 position in every row
	Next
Next

; stop movement
Func StopMoveTo()
	if Not $gotBlocked Then
		KeySend($ARmovkey)
	EndIf
	$increment = 0
	$callcnt = 0
	$running = False
	$stopCheck = False
	$blockCheck = False
EndFunc

; end movement but keep running e.g. to exit
Func KeepMoveTo()
	$increment = 0
	$callcnt = 0
	$running = False
	$stopCheck = False
	$blockCheck = False
EndFunc

; prepare movement
Func PrepMoveTo()
	$increment = 0
	$callcnt = 0
	$stopCheck = False	
	$blockCheck = False
	$gotBlocked = False
EndFunc

; disables check if we stopped runnning unintended (eg by cast or knock down)
; note: must be used to protect casts as we try to start running again immediately in auto mode
Func DisableStopCheck()
	if $stopCheck Then
		$stopCheck = False
	EndIf
EndFunc

; enables check again
Func EnableStopCheck()
	if ($blockCheck = False) And ($stopCheck = False) Then
		$stopCheck = True
	EndIf
EndFunc

; calc table for rotation angle calculation
Global $course_table[100]
$course_table[0] = 0.0000
$course_table[1] = 0.0150
$course_table[2] = 0.0372
$course_table[3] = 0.0438
$course_table[4] = 0.0702
$course_table[5] = 0.1031
$course_table[6] = 0.1377
$course_table[7] = 0.1466
$course_table[8] = 0.1751
$course_table[9] = 0.1824
$course_table[10] = 0.2076
$course_table[11] = 0.2462
$course_table[12] = 0.2551
$course_table[13] = 0.2750
$course_table[14] = 0.3154
$course_table[15] = 0.3337
$course_table[16] = 0.3528
$course_table[17] = 0.3612
$course_table[18] = 0.3800
$course_table[19] = 0.4078
$course_table[20] = 0.4273
$course_table[21] = 0.4458
$course_table[22] = 0.4670
$course_table[23] = 0.4845
$course_table[24] = 0.5120
$course_table[25] = 0.5361
$course_table[26] = 0.5656
$course_table[27] = 0.5936
$course_table[28] = 0.6285
$course_table[29] = 0.6445
$course_table[30] = 0.6643
$course_table[31] = 0.6848
$course_table[32] = 0.6991
$course_table[33] = 0.7136
$course_table[34] = 0.7214
$course_table[35] = 0.7452
$course_table[36] = 0.7746
$course_table[37] = 0.8052
$course_table[38] = 0.8283
$course_table[39] = 0.8410
$course_table[40] = 0.8666
$course_table[41] = 0.8826
$course_table[42] = 0.9062
$course_table[43] = 0.9195
$course_table[44] = 0.9363
$course_table[45] = 0.9531
$course_table[46] = 0.9759
$course_table[47] = 1.0020
$course_table[48] = 1.0203
$course_table[49] = 1.0448
$course_table[50] = 1.0636
$course_table[51] = 1.0882
$course_table[52] = 1.0957
$course_table[53] = 1.1124
$course_table[54] = 1.1474
$course_table[55] = 1.1669
$course_table[56] = 1.1833
$course_table[57] = 1.2264
$course_table[58] = 1.2469
$course_table[59] = 1.2670
$course_table[60] = 1.2876
$course_table[61] = 1.2957
$course_table[62] = 1.3056
$course_table[63] = 1.3331
$course_table[64] = 1.3529
$course_table[65] = 1.3769
$course_table[66] = 1.3975
$course_table[67] = 1.4162
$course_table[68] = 1.4366
$course_table[69] = 1.4684
$course_table[70] = 1.4844
$course_table[71] = 1.5089
$course_table[72] = 1.5223
$course_table[73] = 1.5420
$course_table[74] = 1.5721
$course_table[75] = 1.5994
$course_table[76] = 1.6089
$course_table[77] = 1.6203
$course_table[78] = 1.6485
$course_table[79] = 1.6632
$course_table[80] = 1.6791
$course_table[81] = 1.6807
$course_table[82] = 1.7258
$course_table[83] = 1.7630
$course_table[84] = 1.7801
$course_table[85] = 1.8172
$course_table[86] = 1.8256
$course_table[87] = 1.8400
$course_table[88] = 1.8654
$course_table[89] = 1.8804
$course_table[90] = 1.9119
$course_table[91] = 1.9391
$course_table[92] = 1.9605
$course_table[93] = 1.9822
$course_table[94] = 2.0091
$course_table[95] = 2.0203
$course_table[96] = 2.0433
$course_table[97] = 2.0654
$course_table[98] = 2.0749
$course_table[99] = 2*$pi

; calculate rotation angle
Func GetCourse($val)
	$i=0
	$valL = Abs($val)
	While $course_table[$i] < $valL
		$i +=1
		if $i = 100 Then ;error
			ConsoleWrite(StringFormat("GetCourse: bad call: %.4f",$valL))
			Exit
		EndIf
	WEnd
	return Int($i * 10 * $accelmul)
EndFunc

; initialise new destination
Func InitDest($dx, $dy, $dcheck = False)
	;no movement if we are dead or got blocked
	If $isDead Or $gotBlocked Then
		Return
	EndIf
	
	; set global destination
	$gotox = $dx
	$gotoy = $dy
	
	; calc distance
	$posx = _memoryread($memx,$hprocess,'float')
	$posy = _memoryread($memy,$hprocess,'float')
	$dist = Sqrt(($posx-$gotox)^2 + ($posy-$dy)^2)
	$olddist = $dist
	
	;set call counter for cyclic loop
	$callcnt = 1

	; set stop level for angles in relation to distance
	if $dist > 2000 Then
		$stoplvl = 1.8
	Elseif $dist > 1200 Then
		$stoplvl = 1.5
	Elseif $dist > 700 Then
		$stoplvl = 1.2
	Elseif $dist > 400 Then
		$stoplvl = 0.8
	Elseif $dist > 200 Then
		$stoplvl = 0.6
	Else 
		$stoplvl = 0.2
	EndIf
	
	; calc angle
	$angle = ACos(($gotox - $posx)/$dist)
	if $gotoy < $posy Then
		$angle = -$angle
	EndIf
	
	; rotate view to destination			
	Do
		; transition via q2<->q3 by pseudo course angle
		$curcou = _memoryread($memcourse,$hprocess,'float')
		if (($angle > $pi/2) And ($curcou < $angle - $pi)) Then
			$curcou = 2*$pi + $curcou
		EndIf
		if (($angle < -$pi/2) And ($curcou > $pi+$angle)) Then
			$curcou = -2*$pi + $curcou
		EndIf

		; big delta -> stop running
		if Abs($angle - $curcou) > $stoplvl Then
			if $running = True Then
				KeySend($ARmovkey)
				$running = False
			EndIf
		EndIf
			
		$accel = GetCourse(Abs($angle - $curcou))

		; rotate
		if $angle < $curcou Then
			KeySend($TRmovkey, "down")
			Sleep($accel)
			KeySend($TRmovkey, "up")
		Else
			KeySend($TLmovkey, "down")
			Sleep($accel)
			KeySend($TLmovkey, "up")
		EndIf
		Sleep(100)
		
		; check for death
		if  $dcheck And _memoryread($memdeath,$hprocess) = 1 Then
			$isDead = True
			Return
		EndIf		
	Until (Abs($angle - $curcou) <0.1)
EndFunc

; cyclic function for movement to destination (must be called every 10ms)
Func MoveToCore($dcheck = False)
	;no movement if we are dead or got blocked
	If $isDead Or $gotBlocked Then
		Return True
	EndIf
		
	; get data
	$posx = _memoryread($memx,$hprocess,'float')
	$posy = _memoryread($memy,$hprocess,'float')
	$curcou = _memoryread($memcourse,$hprocess,'float')

	; calc distance
	$dist = Sqrt(($posx-$gotox)^2 + ($posy-$gotoy)^2)
	
	; try to catch problem in case we missed target
	if $olddist < $dist -100.0 Then
		InitDest($gotox, $gotoy, $dcheck)
	EndIf

	; store distance every 500ms, initial value is set in InitDest(), check for special situations
	If Mod($callcnt, 50) = 0 Then
		; set death flag and exit
		if  $dcheck And _memoryread($memdeath,$hprocess) = 1 Then
			$isDead = True
			Return True
		EndIf
		; restart running in case we got stopped
		if $stopCheck And (Abs($olddist - $dist) < 20.0) Then
			$running = False
		EndIf
		; set blocked flag and exit
		if $blockCheck And (Abs($olddist - $dist) < 20.0) Then
			$gotBlocked = True
			Return True
		EndIf
		$olddist = $dist
	EndIf
	;increment call counter
	$callcnt +=1
	
	; check running
	if $running = False Then
		$running = True
		KeySend($ARmovkey)
	EndIf

	; calc angle
	$angle = ACos(($gotox - $posx)/$dist)
	if $gotoy < $posy Then
		$angle = -$angle
	EndIf
	
	; correct angle on the fly
	If (Abs($angle - $curcou) >0.05) And ($increment = 0) Then
		
		; transition via q2<->q3 by pseudo course angle
		$curcou = _memoryread($memcourse,$hprocess,'float')
		if (($angle > $pi/2) And ($curcou < $angle - $pi)) Then
			$curcou = 2*$pi + $curcou
		EndIf
		if (($angle < -$pi/2) And ($curcou > $pi+$angle)) Then
			$curcou = -2*$pi + $curcou
		EndIf

		$increment = GetCourse(Abs($angle - $curcou))
		
		; rotate
		if $angle < $curcou Then
			KeySend($TRmovkey, "down")
			$increment -=10
		Else
			KeySend($TLmovkey, "down")
			$increment -=10
		EndIf
	ElseIf ($increment > 0) Then
		$increment -=10
		if $increment <= 0 Then
			KeySend($TRmovkey, "up")
			KeySend($TLmovkey, "up")
		EndIf
	EndIf
	
	; reached position
	If $dist < 130.0 Then
		$increment = 0
		KeySend($TRmovkey, "up")
		KeySend($TLmovkey, "up")
		return True
	EndIf
	Return False
EndFunc

; movement function 
;  mode = 0 : do one iteration and return, used in very special situations only
;  mode = 1 : init destination and move there
;  mode = 2 : autorun mode, if a stop is detected it will be tried to run again automatically
;  mode = 3 : block mode, if a block is detected we set flag and exit
;  random adds some variation to movement positions
;  dcheck enables deathcheck 
Func MoveTo($mode, $x, $y, $random = False, $dcheck = False)
	$xl = $x
	$yl = $y
	if $random Then
		$xl = $x + Int(Random(-100,100))
		$yl = $y + Int(Random(-100,100))
	EndIf
	if $mode = 0 Then
		$stopCheck = False
		$blockCheck = False
		Return MoveToCore($dcheck)
	ElseIf $mode = 1 Then
		$stopCheck = False
		$blockCheck = False
		InitDest($xl, $yl, $dcheck)
		While Not MoveToCore($dcheck)
			Sleep(10)
		WEnd
	ElseIf $mode = 2 Then
		$stopCheck = True
		$blockCheck = False
		InitDest($xl, $yl, $dcheck)
		While Not MoveToCore($dcheck)
			Sleep(10)
		WEnd
	ElseIf $mode = 3 Then
		$stopCheck = False
		$blockCheck = True
		InitDest($xl, $yl, $dcheck)
		While Not MoveToCore($dcheck)
			Sleep(10)
		WEnd
	Else  ;error
		ConsoleWrite(StringFormat("MoveTo: bad mode: %d",$mode))
		Exit
	EndIf
EndFunc

; check if position is in area
Func CheckArea($xval, $yval)
	$ret = False
	$pX = _memoryread($memx,$hprocess,'float')
	$pY = _memoryread($memy,$hprocess,'float')
	
	if ($pX < $xval + 250) And ($pX > $xval - 250) And ($pY < $yval + 250) And ($pY > $yval - 250) Then
		$ret = True
	EndIf
	Return $ret	
EndFunc

; random sleep function with -+5% variation
Func RndSleep($val)
	$sle = Random($val * 0.95, $val *1.05, 1)
	Sleep($sle)
EndFunc

; collect all loot limited by max check value
Func CollectLoot($max)
	KeySend($INtgtkey)
	RndSleep(150)
	$cnt =0
	While (_memoryread($memnpcidselect,$hprocess) > 0) And ($cnt < $max)
		KeySend($DIactkey)
		RndSleep(250)
		KeySend($INtgtkey)
		RndSleep(250)
		$cnt +=1
	WEnd
EndFunc

; resign
Func Resign($wdelay = 150)
	keysend("-")
	Sleep($wdelay)
	keysend("r")
	Sleep($wdelay)
	keysend("e")
	Sleep($wdelay)
	keysend("s")
	Sleep($wdelay)
	keysend("i")
	Sleep($wdelay)
	keysend("g")
	Sleep($wdelay)
	keysend("n")
	Sleep($wdelay)
	keysend("RETURN")
	RndSleep(5000)
	ControlClick($gw, "", "", "left", 1, 310, 223)
	RS(4000,5000)
	While (_memoryread($memmap,$hprocess)) <> 0
		RS(3000,4100)
	WEnd
	RS(1000,2000)
EndFunc

; transfer to GH, may be used from/to GH
Func TransferGH()
	KeySend($GHpnlkey)
	RndSleep(500)
	ControlClick($client, "", "", "left", 1, $GHclickX, $GHclickY)
	Sleep(200)
	While Not ((_memoryread($memmap,$hprocess)) = 2)
		Sleep(100)
	WEnd
	While (_memoryread($memmap,$hprocess)) <> 0
		Sleep(100)
	WEnd
	RndSleep(4000)
	KeySend($GHpnlkey)
	RndSleep(500)
EndFunc

; ident all items from start row to end row (0..8) using ident kit at row/col (0..4)
Func IdentItems($StartRow, $EndRow, $IdentCol, $IdentRow)
	if $EndRow > $invMaxR Then
		$end = $invMaxR
	Else
		$end = $EndRow		
	EndIf
	For $row = $StartRow To $end
		For $col = 0 To $invMaxC
			ControlClick($client, "", "", "left", 2, $invPos[$IdentCol][$IdentRow][0], $invPos[$IdentCol][$IdentRow][1])
			RndSleep(450)
			MouseSend("left", "click", $invPos[$col][$row][0], $invPos[$col][$row][1])
			RndSleep(450)				
		Next
	Next
EndFunc

; create long int (32 bit) from 2 short int (16 bit) 
Func MakeLong($LoWord, $HiWord)
	Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc

; send mouse events to non active window
; button = left, right, none
; event = down, up, click, dclick, move
Func MouseSend($btn, $evt, $xpos, $ypos)
	$user32 = DllOpen("user32.dll")
	if $user32 = -1 Then
		ConsoleWrite("MouseSend: cannot open user32.dll")
		Exit
	EndIf
	
	;define missing constans
	$MK_LBUTTON       =  0x0001
	$WM_LBUTTONDOWN   =  0x0201
	$MK_RBUTTON       =  0x0002   
	$WM_RBUTTONDOWN   =  0x0204
	$WM_RBUTTONUP     =  0x0205
	
	;map button to event
	If $btn = "left" Then
		$button = $MK_LBUTTON
		$btdown = $WM_LBUTTONDOWN
		$btup = $WM_LBUTTONUP
	ElseIf $btn = "right" Then
		$button = $MK_RBUTTON
		$btdown = $WM_RBUTTONDOWN
		$btup = $WM_RBUTTONUP
	ElseIf $btn = "none" Then
		If Not ($evt = "move") Then
			ConsoleWrite(StringFormat("MouseSend: bad call:  %s , %s",$btn, $evt))
			Exit
		EndIf			
	Else  ;error
		ConsoleWrite(StringFormat("MouseSend: bad button: %s",$btn))
		Exit
	EndIf
	
	;send messages
	$pos = MakeLong($xpos, $ypos)
	Select
	Case $evt = "move"
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_MOUSEMOVE, "int", 0, "long", $pos)
	Case $evt = "down"
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btdown, "int", $button, "long", $pos)
	Case $evt = "up"
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btup, "int", 0, "long", $pos)
	Case $evt = "click"
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_MOUSEMOVE, "int", 0, "long", $pos)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btdown, "int", $button, "long", $pos)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btup, "int", 0, "long", $pos)
	Case $evt = "dclick"
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_MOUSEMOVE, "int", 0, "long", $pos)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btdown, "int", $button, "long", $pos)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btup, "int", 0, "long", $pos)
		Sleep(50)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_MOUSEMOVE, "int", 0, "long", $pos)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btdown, "int", $button, "long", $pos)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $btup, "int", 0, "long", $pos)		
	EndSelect
	DllClose($user32)
EndFunc

; send single keyboard event to non active window
; event = pressed, down, up
; kdown = key down delay
; note: supports only lower case keys + NUMx, Fx, some special keys and @
Func KeySend($inkey, $evt ="pressed", $kdown = 50)
	$user32 = DllOpen("user32.dll")
	if $user32 = -1 Then
		ConsoleWrite("KeySend: cannot open user32.dll")
		Exit
	EndIf
		
    ; handling for special keys
	Switch StringUpper($inkey)
	Case "@"
		$skey = 0x40
		$lparam = 0x00100001
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYDOWN, "int", 0x71, "int", $lparam)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_CHAR, "int", $skey, "int", $lparam)
		Sleep(20)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYUP, "int", 0x71, "int", BitOR($lparam, 0xC0000000))		
	Case "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"
		$skey = 0x6f + Int(StringMid($inkey, 2)) 
		ContinueCase
	Case "NUM0", "NUM1", "NUM2", "NUM3", "NUM4", "NUM5", "NUM6", "NUM7", "NUM8" , "NUM9"
		if StringUpper(StringLeft($inkey, 3)) = "NUM" Then
			$skey = 0x60 + Int(StringMid($inkey, 4)) 
		EndIf
		ContinueCase
	Case "RETURN", "SPACE", "TAB", "BACK", "END", "HOME", "SNAPSHOT", "INSERT", "DELETE"
		Switch StringUpper($inkey)
		Case "RETURN"
			$skey = 0x0D
		Case "SPACE"
			$skey = 0x20
		Case "TAB"
			$skey = 0x09
		Case "BACK"
			$skey = 0x08
		Case "END"
			$skey = 0x23
		Case "HOME"
			$skey = 0x24
		Case "SNAPSHOT"
			$skey = 0x2c
		Case "INSERT"
			$skey = 0x2d
		Case "DELETE"
			$skey = 0x2e
		EndSwitch
		$ret = DllCall($user32, "int", "MapVirtualKey", "int", $skey, "int", 0)
		$lparam = BitShift($ret[0], -16)
		$lparam = BitOr($lparam, 1)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYDOWN, "int", $skey, "int", $lparam)
		Sleep($kdown)
		DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYUP, "int", $skey, "int",   BitOR($lparam, 0xC0000000))
	Case Else ; default lower case key handling
		$key = DllCall($user32, "int", "VkKeyScan", "int", Asc(StringLower($inkey)))
		$skey = $key[0]		
		$ret = DllCall($user32, "int", "MapVirtualKey", "int", $skey, "int", 0)
		$lparam = BitShift($ret[0], -16)
		$lparam = BitOr($lparam, 1)
		Select
		Case $evt = "pressed"
			DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYDOWN, "int", $skey, "int", $lparam)
			Sleep($kdown)
			DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYUP, "int", $skey, "int",   BitOR($lparam, 0xC0000000))
		Case $evt = "down"
			DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYDOWN, "int", $skey, "int", $lparam)
		Case $evt = "up"
			DllCall($user32, "int", "PostMessage", "hwnd", $hwnd, "int", $WM_KEYUP, "int", $skey, "int",   BitOR($lparam, 0xC0000000))
		EndSelect		
	EndSwitch

	DllClose($user32)
EndFunc