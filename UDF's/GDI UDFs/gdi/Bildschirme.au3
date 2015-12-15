
#include<GDI\GDI.au3>
#include<WinAPI.au3>

; Grafikkarten auflisten
Local $atDisplayDevices[1]
Local $Index = 0

Local $StateFlags[7] = ["DISPLAY_DEVICE_ACTIVE", "DISPLAY_DEVICE_MULTI_DRIVER", "DISPLAY_DEVICE_PRIMARY_DEVICE", "DISPLAY_DEVICE_MIRRORING_DRIVER", _
			"DISPLAY_DEVICE_VGA_COMPATIBLE", "DISPLAY_DEVICE_REMOVABLE", "DISPLAY_DEVICE_MODESPRUNED"]
While 1
    ReDim $atDisplayDevices[$Index+1]
    $atDisplayDevices[$Index] = DllStructCreate($tagDISPLAY_DEVICEW)
    DllStructSetData($atDisplayDevices[$Index], "cb", DllStructGetSize($atDisplayDevices[$Index]))
    If _GDI_EnumDisplayDevices("", $Index, DllStructGetPtr($atDisplayDevices[$Index]), 0) Then
        ConsoleWrite("----------------------------------------" & @CRLF & _
                "Grafikkarte #" & $Index & @CRLF & _
				"DeviceName: 	" & DllStructGetData($atDisplayDevices[$Index],"DeviceName") & @CRLF & _
				"StateFlags: 	" & DllStructGetData($atDisplayDevices[$Index],"StateFlags") & @CRLF & _
				"DeviceString: 	" & DllStructGetData($atDisplayDevices[$Index],"DeviceString") & @CRLF )
		For $i = 0 To 6
			ConsoleWrite(@TAB & $StateFlags[$i] & ": 	" & ( BitAND(DllStructGetData($atDisplayDevices[$Index],"StateFlags"), Eval($StateFlags[$i])) = Eval($StateFlags[$i]) ) & @CRLF)
		Next
        $Index += 1
    Else
		$atDisplayDevices[$Index] = 0
		ReDim $atDisplayDevices[$Index]
		$Index -= 1
        ExitLoop
    EndIf
WEnd
ConsoleWrite(@CRLF & @CRLF)

; Bildshirme an Grafikkarte "\\.\DISPLAY1"
Local $atDisplayDevices[1]
Local $Index = 0
Local $StateFlags[7] = ["DISPLAY_DEVICE_ACTIVE", "DISPLAY_DEVICE_MULTI_DRIVER", "DISPLAY_DEVICE_PRIMARY_DEVICE", "DISPLAY_DEVICE_MIRRORING_DRIVER", _
			"DISPLAY_DEVICE_VGA_COMPATIBLE", "DISPLAY_DEVICE_REMOVABLE", "DISPLAY_DEVICE_MODESPRUNED"]
While 1
    ReDim $atDisplayDevices[$Index+1]
    $atDisplayDevices[$Index] = DllStructCreate($tagDISPLAY_DEVICEW)
    DllStructSetData($atDisplayDevices[$Index], "cb", DllStructGetSize($atDisplayDevices[$Index]))
    If _GDI_EnumDisplayDevices("\\.\DISPLAY1", $Index, DllStructGetPtr($atDisplayDevices[$Index]), 0) Then
        ConsoleWrite("----------------------------------------" & @CRLF & _
                "Bildshirm #" & $Index & " an \\.\DISPLAY1" & @CRLF & _
				"DeviceName: 	" & DllStructGetData($atDisplayDevices[$Index],"DeviceName") & @CRLF & _
				"StateFlags: 	" & DllStructGetData($atDisplayDevices[$Index],"StateFlags") & @CRLF & _
				"DeviceString: 	" & DllStructGetData($atDisplayDevices[$Index],"DeviceString") & @CRLF )
		For $i = 0 To 6
			ConsoleWrite(@TAB & $StateFlags[$i] & ": 	" & ( BitAND(DllStructGetData($atDisplayDevices[$Index],"StateFlags"), Eval($StateFlags[$i])) = Eval($StateFlags[$i]) ) & @CRLF)
		Next
        $Index += 1
    Else
		$atDisplayDevices[$Index] = 0
		ReDim $atDisplayDevices[$Index]
		$Index -= 1
        ExitLoop
    EndIf
WEnd
ConsoleWrite(@CRLF & @CRLF)

; Alle Einstellungen der 1.Grafikkarte (\\.\DISPLAY1)
$sDisplayDevice= "\\.\DISPLAY1"

; aus irgend einem Grund funktioniert es nicht, wenn man den Bildshirm direkt anspricht.
;~ $sDisplayDevice= DllStructGetData($atDisplayDevices[0],"DeviceName")

; Aktuelle Einstellung
Local $CurrentDevMode = DllStructCreate($tagDEVMODE&"byte[1000]")

DllStructSetData($CurrentDevMode , "dmSize", DllStructGetSize($CurrentDevMode ))
DllStructSetData($CurrentDevMode , "dmDriverExtra", 1000)
    If _GDI_EnumDisplaySettingsEx($sDisplayDevice, $ENUM_CURRENT_SETTINGS, DllStructGetPtr($CurrentDevMode), 0) Then
        ConsoleWrite("----------------------------------------" & @CRLF & _
                "Aktuelle Einstellung" & @CRLF & _
                "dmBitsPerPel:  " & DllStructGetData($CurrentDevMode, "dmBitsPerPel") & @CRLF & _
                "dmPelsWidth:   " & DllStructGetData($CurrentDevMode, "dmPelsWidth") & @CRLF & _
                "dmPelsHeight:  " & DllStructGetData($CurrentDevMode, "dmPelsHeight") & @CRLF & _
                "dmDisplayFlags:    " & DllStructGetData($CurrentDevMode, "dmDisplayFlags") & @CRLF & _
                "dmDisplayFrequency:    " & DllStructGetData($CurrentDevMode, "dmDisplayFrequency") & @CRLF)
	EndIf

ConsoleWrite(@CRLF & @CRLF)

Local $atDevModes[1]

; alle möglichen Einstellungen
Local $Index = 0
While 1
    ReDim $atDevModes[$Index+1]
    $atDevModes[$Index] = DllStructCreate($tagDEVMODE)
    DllStructSetData($atDevModes[$Index], "dmSize", DllStructGetSize($atDevModes[$Index]))
    If _GDI_EnumDisplaySettings($sDisplayDevice, $Index, DllStructGetPtr($atDevModes[$Index])) Then
        ConsoleWrite("----------------------------------------" & @CRLF & _
                "Einstellungsmöglichkeit #" & $Index & @CRLF & _
                "dmBitsPerPel:  " & DllStructGetData($atDevModes[$Index], "dmBitsPerPel") & @CRLF & _
                "dmPelsWidth:   " & DllStructGetData($atDevModes[$Index], "dmPelsWidth") & @CRLF & _
                "dmPelsHeight:  " & DllStructGetData($atDevModes[$Index], "dmPelsHeight") & @CRLF & _
                "dmDisplayFlags:    " & DllStructGetData($atDevModes[$Index], "dmDisplayFlags") & @CRLF & _
                "dmDisplayFrequency:    " & DllStructGetData($atDevModes[$Index], "dmDisplayFrequency") & @CRLF)
        $Index += 1
    Else
		$atDevModes[$Index] = 0
		If $Index > 0 Then ReDim $atDevModes[$Index]
		$Index-=1
        ExitLoop
    EndIf
WEnd

; eine Einstellung setzen
$gewuenschterIndex = 188 ; Hier den Index aus dem Array (188 ist bei mir 1024x768, 32bpp, 60Hz
_GDI_ChangeDisplaySettingsEx($sDisplayDevice, DllStructGetPtr($atDevModes[$gewuenschterIndex]), 0, $CDS_FULLSCREEN, 0)
For $i = 10 To 1 Step -1
ToolTip("Geänderte Einstellungen, noch " &$i & " Sekunden bis zum Reset")
Sleep(1000)
Next
_GDI_ChangeDisplaySettingsEx($sDisplayDevice, DllStructGetPtr($CurrentDevMode), 0, $CDS_FULLSCREEN, 0)
