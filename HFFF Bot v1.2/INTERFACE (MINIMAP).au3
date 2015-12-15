#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         MasteR GunneR

 Script Function:
	HFFF.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

If Not WinActivate("Guild Wars") Then
	WinActivate("Guild Wars")
EndIf
Sleep(6000)

While True
MouseClickDrag("left", 149, 186, 928, 1023)
Sleep(1000)
Exit
WEnd