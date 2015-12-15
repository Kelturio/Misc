#include-once
;//////////////////////////////////////////////////////////////
;//                     Makro Funktionen                     //
;//////////////////////////////////////////////////////////////

;  v1.0.4

;   *** Windef.h ***
Func MAKEWORD($a, $b)
	Return BitOR ( BitAND ( $a, 0xFF ), BitShift (BitAND ( $b, 0xFF ), -8) )
EndFunc

Func MAKELONG($a, $b)
	Return BitOR ( BitAND ( $a, 0xFFFF ), BitShift (BitAND ( $b, 0xFFFF ), -16) )
EndFunc

Func LOWORD ($DWORD)
	Return BitAND($DWORD, 0xFFFF)
EndFunc

Func HIWORD ($DWORD)
	Return BitShift($DWORD, 16)
EndFunc

Func HIBYTE ($w)
	Return BitAND ( BitShift ( $w, 8 ), 0xFF )
EndFunc

Func LOBYTE ($w)
	Return BitAND ( $w, 0xFF )
EndFunc

Func MAKEINTRESOURCE($int)
	Return BitAND($int,0x0000FFFF)
EndFunc

Func MAKEINTRESOURCESTRING ($lID)	
	Return "#" & String(Int($lID))	
EndFunc

;   ***  Bitmap Macros ***
Func MAKEROP4 ($fore, $back)
	Return BitOR ( BitAND (  BitShift ( $back, -8 ), 0xFF000000 ), $fore )
EndFunc

;   ***  Color Macros  ***
Func DIBINDEX ($n)
	Return MAKELONG($n, 0x10FF)
EndFunc

Func GetRValue ($rgb)
	Return LOBYTE ( $rgb )
EndFunc

Func GetGValue ($rgb)
	Return LOBYTE ( BitShift ( $rgb, 8 ) )
EndFunc

Func GetBValue ($rgb)
	Return LOBYTE ( BitShift ( $rgb, 16 ) )
EndFunc

Func PALETTEINDEX ($i)
	Return BitOR ( 0x01000000 , $i )
EndFunc

Func PALETTERGB ($r, $g, $b)
	Return BitOR ( 0x02000000 , RGB($r, $g, $b) )
EndFunc

Func RGB ($r, $g, $b)
	Return BitOR ( LOBYTE ($r), BitShift (LOBYTE ($g), -8), BitShift (LOBYTE ($b), -16) ) ; COLORREF / BGR
EndFunc

;   ***  WinNT.h  ***
Func ARRAYSIZE ($array)
	If IsArray ($array) Then
		Return UBound ($array)
	ElseIf IsString ($array) Then
		Return StringLen ($array)
	EndIf
	Return SetError(1)
EndFunc