#include <APIConstants.au3>
#include <WinAPIEx.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

; Binary file embedded.
#include "Airplane.au3"

Opt('MustDeclareVars', 1)

_Example()

; Example function.
Func _Example()
	Local $hForm, $iButton, $bWav, $tWav, $pWav, $Play = False

	; Load Airplane.wav into memory
	$bWav = _Airplane()
	If @error Then
		MsgBox(4096, 'Error', 'Unable to read binary sound')
		Exit
	EndIf

	$tWav = DllStructCreate('byte[' & BinaryLen($bWav) & ']')
	DllStructSetData($tWav, 1, $bWav)
	$pWav = DllStructGetPtr($tWav)

	; Create GUI
	$hForm = GUICreate('MyGUI', 200, 200) ; will create a dialog box that when displayed is centered
	$iButton = GUICtrlCreateButton('Play', 70, 70, 60, 60)
	GUISetState() ; will display dialog box

	; Run the GUI until the dialog is closed
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $iButton
				$Play = Not $Play
				If $Play Then
					_WinAPI_PlaySound($pWav, BitOR($SND_ASYNC, $SND_LOOP, $SND_MEMORY))
					GUICtrlSetData($iButton, 'Stop')
				Else
					_WinAPI_PlaySound('')
					GUICtrlSetData($iButton, 'Play')
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>_Example
