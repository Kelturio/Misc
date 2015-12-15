#include-once
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.2.13.12 (beta)
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region				 Device Contexts

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CancelDC
; Description ...: Cancels any pending operation on the specified device context (DC)
; Syntax.........: _GDI_CancelDC($hdc)
; Parameters ....: $hdc  - [in] Handle to the DC.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The CancelDC function is used by multithreaded applications to cancel lengthy drawing operations.
;                    If thread A initiates a lengthy drawing operation, thread B may cancel that operation by calling this function.
;                  If an operation is canceled, the affected thread returns an error and the result of its drawing operation is
;                    undefined. The results are also undefined if no drawing operation was in progress when the function was called.
; Related .......:
; Link ..........; @@MsdnLink@@ CancelDC
; Example .......;
; ===============================================================================================================================
Func _GDI_CancelDC($hdc)
	Local $aResult = DllCall($__GDI_user32dll, "int", "CancelDC", "ptr", $hdc)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CancelDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ChangeDisplaySettings
; Description ...: Changes the settings of the default display device to the specified graphics mode.
;                    To change the settings of a specified display device, use the _GDI_ChangeDisplaySettingsEx function.
; Syntax.........: _GDI_ChangeDisplaySettings($lpDevMode, $dwflags)
; Parameters ....: $lpDevMode  - [in] Pointer to a DEVMODE structure that describes the new graphics mode.
;                                      If lpDevMode is NULL, all the values currently in the registry will be used for the
;                                      display setting. Passing NULL for the lpDevMode parameter and 0 for the dwFlags parameter
;                                      is the easiest way to return to the default mode after a dynamic mode change.
;                                    More information on MSDN
;                  $dwflags    - [in]  Indicates how the graphics mode should be changed.
;                                      This parameter can be one of the following values.
;                                      Value              Meaning
;                                         0                 The graphics mode for the current screen will be changed dynamically.
;                                      $CDS_FULLSCREEN      The mode is temporary in nature.
;                                                            Windows NT/2000/XP: If you change to and from another desktop,
;                                                              this mode will not be reset.
;                                      $CDS_GLOBAL          The settings will be saved in the global settings area so that
;                                                            they will affect all users on the machine. Otherwise, only the
;                                                            settings for the user are modified. This flag is only valid
;                                                            when specified with the CDS_UPDATEREGISTRY flag.
;                                      $CDS_NORESET         The settings will be saved in the registry, but will not take effect.
;                                                            This flag is only valid when specified with the CDS_UPDATEREGISTRY flag.
;                                      $CDS_RESET           The settings should be changed, even if the requested settings are
;                                                            the same as the current settings.
;                                      $CDS_SET_PRIMARY     This device will become the primary device.
;                                      $CDS_TEST            The system tests if the requested graphics mode could be set.
;                                      $CDS_UPDATEREGISTRY  The graphics mode for the current screen will be changed
;                                                            dynamically and the graphics mode will be updated in the registry.
;                                                            The mode information is stored in the USER profile.
;                                      Specifying CDS_TEST allows an application to determine which graphics modes are actually
;                                        valid, without causing the system to change to that graphics mode.
;                                      If CDS_UPDATEREGISTRY is specified and it is possible to change the graphics mode dynamically,
;                                        the information is stored in the registry and DISP_CHANGE_SUCCESSFUL is returned. If it is
;                                        not possible to change the graphics mode dynamically, the information is stored in the
;                                        registry and DISP_CHANGE_RESTART is returned.
;                                      Windows NT/2000/XP: If CDS_UPDATEREGISTRY is specified and the information could not be
;                                        stored in the registry, the graphics mode is not changed and DISP_CHANGE_NOTUPDATED is returned.
; Return values .: The ChangeDisplaySettings function returns one of the following values.
;                  $DISP_CHANGE_SUCCESSFUL   - The settings change was successful.
;                  $DISP_CHANGE_BADDUALVIEW	 - Windows XP: The settings change was unsuccessful because system is DualView capable.
;                  $DISP_CHANGE_BADFLAGS     - An invalid set of flags was passed in.
;                  $DISP_CHANGE_BADMODE	     - The graphics mode is not supported.
;                  $DISP_CHANGE_BADPARAM     - An invalid parameter was passed in. This can include an invalid flag or combination of flags.
;                  $DISP_CHANGE_FAILED       - The display driver failed the specified graphics mode.
;                  $DISP_CHANGE_NOTUPDATED   - Windows NT/2000/XP: Unable to write settings to the registry.
;                  $DISP_CHANGE_RESTART	     - The computer must be restarted in order for the graphics mode to work.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: To ensure that the DEVMODE structure passed to ChangeDisplaySettings is valid and contains only values supported
;                    by the display driver, use the DEVMODE returned by the EnumDisplaySettings function.
;                  When the display mode is changed dynamically, the WM_DISPLAYCHANGE message is sent to all running applications
;                    with the following message parameters.
;                    Parameters          Meaning
;                      wParam	      New bits per pixel
;                    LOWORD(lParam)   New pixel width
;                    HIWORD(lParam)   New pixel height
; Related .......:
; Link ..........; @@MsdnLink@@ ChangeDisplaySettings
; Example .......;
; ===============================================================================================================================
Func _GDI_ChangeDisplaySettings($lpDevMode, $dwflags)
	Local $aResult = DllCall($__GDI_user32dll, "long", "ChangeDisplaySettingsW", "ptr", $lpDevMode, "DWORD", $dwflags)
	If @error Then Return SetError(1, @error, $DISP_CHANGE_FAILED)
	Return $aResult[0]
EndFunc   ;==>_GDI_ChangeDisplaySettings

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ChangeDisplaySettingsEx
; Description ...: Changes the settings of the specified display device to the specified graphics mode.
; Syntax.........: _GDI_ChangeDisplaySettingsEx($lpDevMode, $dwflags)
; Parameters ....: $szDeviceName [in] Pointer to a null-terminated string that specifies the display device whose graphics mode
;                                       will change. Only display device names as returned by EnumDisplayDevices are valid.
;                                       See EnumDisplayDevices for further information on the names associated with these display devices.
;                                     The lpszDeviceName parameter can be NULL. A NULL value specifies the default
;                                       display device. The default device can be determined by calling EnumDisplayDevices and
;                                       checking for the DISPLAY_DEVICE_PRIMARY_DEVICE flag.
;                  $lpDevMode  - [in] Pointer to a DEVMODE structure that describes the new graphics mode.
;                                      If lpDevMode is NULL, all the values currently in the registry will be used for the
;                                      display setting. Passing NULL for the lpDevMode parameter and 0 for the dwFlags parameter
;                                      is the easiest way to return to the default mode after a dynamic mode change.
;                                    More information on MSDN
;                  $hwnd       - Reserved; must be NULL.
;                  $dwflags    - [in]  Indicates how the graphics mode should be changed.
;                                      This parameter can be one of the following values.
;                                      Value              Meaning
;                                         0                 The graphics mode for the current screen will be changed dynamically.
;                                      $CDS_FULLSCREEN      The mode is temporary in nature.
;                                                            Windows NT/2000/XP: If you change to and from another desktop,
;                                                              this mode will not be reset.
;                                      $CDS_GLOBAL          The settings will be saved in the global settings area so that
;                                                            they will affect all users on the machine. Otherwise, only the
;                                                            settings for the user are modified. This flag is only valid
;                                                            when specified with the CDS_UPDATEREGISTRY flag.
;                                      $CDS_NORESET         The settings will be saved in the registry, but will not take effect.
;                                                            This flag is only valid when specified with the CDS_UPDATEREGISTRY flag.
;                                      $CDS_RESET           The settings should be changed, even if the requested settings are
;                                                            the same as the current settings.
;                                      $CDS_SET_PRIMARY     This device will become the primary device.
;                                      $CDS_TEST            The system tests if the requested graphics mode could be set.
;                                      $CDS_UPDATEREGISTRY  The graphics mode for the current screen will be changed
;                                                            dynamically and the graphics mode will be updated in the registry.
;                                                            The mode information is stored in the USER profile.
;                                      Specifying CDS_TEST allows an application to determine which graphics modes are actually
;                                        valid, without causing the system to change to that graphics mode.
;                                      If CDS_UPDATEREGISTRY is specified and it is possible to change the graphics mode dynamically,
;                                        the information is stored in the registry and DISP_CHANGE_SUCCESSFUL is returned. If it is
;                                        not possible to change the graphics mode dynamically, the information is stored in the
;                                        registry and DISP_CHANGE_RESTART is returned.
;                                      Windows NT/2000/XP: If CDS_UPDATEREGISTRY is specified and the information could not be
;                                        stored in the registry, the graphics mode is not changed and DISP_CHANGE_NOTUPDATED is returned.
;                  $lParam     - [in] If dwFlags is CDS_VIDEOPARAMETERS, lParam is a pointer to a VIDEOPARAMETERS structure.
;                                       Otherwise lParam must be NULL.
; Return values .: The ChangeDisplaySettingsEx function returns one of the following values.
;                  $DISP_CHANGE_SUCCESSFUL   - The settings change was successful.
;                  $DISP_CHANGE_BADDUALVIEW	 - Windows XP: The settings change was unsuccessful because system is DualView capable.
;                  $DISP_CHANGE_BADFLAGS     - An invalid set of flags was passed in.
;                  $DISP_CHANGE_BADMODE	     - The graphics mode is not supported.
;                  $DISP_CHANGE_BADPARAM     - An invalid parameter was passed in. This can include an invalid flag or combination of flags.
;                  $DISP_CHANGE_FAILED       - The display driver failed the specified graphics mode.
;                  $DISP_CHANGE_NOTUPDATED   - Windows NT/2000/XP: Unable to write settings to the registry.
;                  $DISP_CHANGE_RESTART	     - The computer must be restarted in order for the graphics mode to work.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: To ensure that the DEVMODE structure passed to ChangeDisplaySettingsEx is valid and contains only values supported
;                    by the display driver, use the DEVMODE returned by the EnumDisplaySettings function.
;                  When adding a display monitor to a multiple-monitor system programmatically, set DEVMODE.dmFields to
;                    DM_POSITION and specify a position (in DEVMODE.dmPosition) for the monitor you are adding that is adjacent
;                    to at least one pixel of the display area of an existing monitor. To detach the monitor, set DEVMODE.dmFields
;                    to DM_POSITION but set DEVMODE.dmPelsWidth and DEVMODE.dmPelsHeight to zero. For more information,
;                    see Multiple Display Monitors.
;                  When the display mode is changed dynamically, the WM_DISPLAYCHANGE message is sent to all running applications
;                    with the following message parameters.
;                    Parameters          Meaning
;                      wParam	      New bits per pixel
;                    LOWORD(lParam)   New pixel width
;                    HIWORD(lParam)   New pixel height
;                  To change the settings for more than one display at the same time, first call ChangeDisplaySettingsEx for
;                    each device individually to update the registry without applying the changes.
;                    Then call ChangeDisplaySettingsEx once more, with a NULL device, to apply the changes.
;                    For example, to change the settings for two displays, do the following:
;                      ChangeDisplaySettingsEx (lpszDeviceName1, lpDevMode1, NULL, (CDS_UPDATEREGISTRY | CDS_NORESET), NULL);
;                      ChangeDisplaySettingsEx (lpszDeviceName2, lpDevMode2, NULL, (CDS_UPDATEREGISTRY | CDS_NORESET), NULL);
;                      ChangeDisplaySettingsEx (NULL, NULL, NULL, 0, NULL);
; Related .......:
; Link ..........; @@MsdnLink@@ ChangeDisplaySettingsEx
; Example .......;
; ===============================================================================================================================
Func _GDI_ChangeDisplaySettingsEx($szDeviceName, $lpDevMode, $hwnd, $dwflags, $lParam)
	Local $tpDevice = "wstr"
	If $szDeviceName = "" Then $tpDevice = "ptr"
	Local $aResult = DllCall($__GDI_user32dll, "long", "ChangeDisplaySettingsExW", $tpDevice, $szDeviceName, "ptr", $lpDevMode, "hwnd", $hwnd, "DWORD", $dwflags, "lparam", $lParam)
	If @error Then Return SetError(1, @error, $DISP_CHANGE_FAILED)
	Return $aResult[0]
EndFunc   ;==>_GDI_ChangeDisplaySettingsEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateCompatibleDC
; Description ...: Creates a memory device context compatible with the specified device
; Syntax.........: _GDI_CreateCompatibleDC($hDC)
; Parameters ....: $hDC         - Handle to an existing DC. If this handle is 0, the function creates a memory DC compatible with
;                  +the application's current screen.
; Return values .: Success      - Handle to a memory DC
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: When you no longer need the memory DC, call the _GDI_DeleteDC function
; Related .......: _GDI_DeleteDC
; Link ..........; @@MsdnLink@@ CreateCompatibleDC
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateCompatibleDC($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateCompatibleDC", "ptr", $hdc)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateCompatibleDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateDC
; Description ...: Creates a device context (DC) for a device using the specified name.
; Syntax.........: _GDI_CreateDC($sDriver, $sDevice, $lpInitData=0)
; Parameters ....: $sDriver     - Specifies driver name, "winspool" for printing, "display" for screen
;                  $sDevice     - Specifies device name
;                  $lpInitData  - [optional] Pointer to a DEVMODE structure
; Return values .: Success      - handle to a DC for the specified device
;                  Failure      - 0
; Author ........: GRS, Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ CreateDC
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateDC($sDriver, $sDevice, $lpInitData = 0)
	Local $aResult, $tpDriver = "wstr", $tpDevice = "wstr"
	If $sDriver = "" Then $tpDriver = "ptr"
	If $sDevice = "" Then $tpDevice = "ptr"
	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateDCW", $tpDriver, $sDriver, $tpDevice, $sDevice, "ptr", 0, "ptr", $lpInitData)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_CreateIC
; Description ...: Creates a device context (IC) for a device using the specified name.
; Syntax.........: _GDI_CreateIC($sDriver, $sDevice, $lpInitData=0)
; Parameters ....: $sDriver     - Specifies driver name
;                  $sDevice     - String that specifies the name of the specific output device being used, as shown by the
;                                  Print Manager (for example, Epson FX-80). It is not the printer model name.
;                                  The lpszDevice parameter must be used.
;                  $lpInitData  - [optional] Pointer to a DEVMODE structure
; Return values .: Success      - handle to a IC for the specified device
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ CreateIC
; Example .......;
; ===============================================================================================================================
Func _GDI_CreateIC($sDriver, $sDevice, $lpInitData = 0)
	Local $aResult, $tpDriver = "wstr"
	If $sDriver = "" Then $tpDriver = "ptr"
	$aResult = DllCall($__GDI_gdi32dll, "ptr", "CreateICW", $tpDriver, $sDriver, "wstr", $sDevice, "ptr", 0, "ptr", $lpInitData)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_CreateIC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_DeleteDC
; Description ...: Deletes the specified device context
; Syntax.........: _GDI_DeleteDC($hDC)
; Parameters ....: $hDC         - Identifies the device context to be deleted
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: An application must not delete a DC whose handle was obtained by calling the _GDI_GetDC function.  Instead, it
;                  must call the _GDI_ReleaseDC function to free the DC.
; Related .......: _GDI_GetDC, _GDI_ReleaseDC
; Link ..........; @@MsdnLink@@ DeleteDC
; Example .......;
; ===============================================================================================================================
Func _GDI_DeleteDC($hdc)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "DeleteDC", "ptr", $hdc)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_DeleteDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_DeleteObject
; Description ...: Deletes a logical pen, brush, font, bitmap, region, or palette
; Syntax.........: _GDI_DeleteObject($hObject)
; Parameters ....: $hObject     - Identifies a logical pen, brush, font, bitmap, region, or palette
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: Do not delete a drawing object while it is still  selected  into  a  device  context.  When  a  pattern  brush
;                  is deleted the bitmap associated with the brush is not deleted. The bitmap must be deleted independently.
; Related .......:
; Link ..........; @@MsdnLink@@ DeleteObject
; Example .......;
; ===============================================================================================================================
Func _GDI_DeleteObject($hObject)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "DeleteObject", "ptr", $hObject)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_GDI_DeleteObject

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_DrawEscape
; Description ...: provides drawing capabilities of the specified video display that are not directly available through
;                    the graphics device interface (GDI).
; Syntax.........: _GDI_DrawEscape($hdc, $nEscape, $cbInput, $lpInData)
; Parameters ....: $hdc         - [in] Handle to the DC for the specified video display.
;                  $nEscape     - [in] Specifies the escape function to be performed.
;                  $cbInput     - [in] Specifies the number of bytes of data pointed to by the lpszInData parameter.
;                  $lpszInData  - [in] Pointer to the input structure required for the specified escape.
; Return values .: Success      - greater than zero except for the QUERYESCSUPPORT draw escape, which checks for implementation only.
;                  Failure      - If the escape is not implemented, the return value is zero.
;                                 If an error occurred, the return value is less than zero.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: When an application calls the DrawEscape function, the data identified by cbInput and lpszInData is
;                    passed directly to the specified display driver.
; Related .......:
; Link ..........; @@MsdnLink@@ DrawEscape
; Example .......;
; ===============================================================================================================================
Func _GDI_DrawEscape($hdc, $nEscape, $cbInput, $lpInData)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "DrawEscape", "ptr", $hdc, "int", $nEscape, "int", $cbInput, "ptr", $lpInData)
	If @error Then Return SetError(1, @error, -1 * 0xFFFF)
	Return $aResult[0]
EndFunc   ;==>_GDI_DrawEscape

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_EnumDisplayDevices
; Description ...: lets you obtain information about the display devices in the current session.
; Syntax.........: _GDI_EnumDisplayDevices($lpDevice, $iDevNum, $lpDisplayDevice,$dwFlags)
; Parameters ....: $lpDevice          - [in] The device name as string. If NULL, function returns information for the display
;                                              adapter(s) on the machine, based on iDevNum.
;                                            For more information, see Remarks.
;                  $iDevNum           - [in] Index value that specifies the display device of interest.
;                                            The operating system identifies each display device in the current session with an
;                                              index value. The index values are consecutive integers, starting at 0. If the current
;                                              session has three display devices, for example, they are specified by the
;                                              index values 0, 1, and 2.
;                  $lpDisplayDevice  - [out] Pointer to a $tagDISPLAY_DEVICEW structure that receives information about the
;                                              display device specified by iDevNum.
;                                            Before calling EnumDisplayDevices, you must initialize the cb member of DISPLAY_DEVICE
;                                              to the size, in bytes, of $tagDISPLAY_DEVICEW.
;                  $dwFlags          - [in] Set this flag to EDD_GET_DEVICE_INTERFACE_NAME (0x00000001) to retrieve the device
;                                             interface name for GUID_DEVINTERFACE_MONITOR, which is registered by the operating
;                                             system on a per monitor basis. The value is placed in the DeviceID member of the
;                                             $tagDISPLAY_DEVICEW structure returned in lpDisplayDevice. The resulting
;                                             device interface name can be used with SetupAPI functions and serves as a link
;                                             between GDI monitor devices and SetupAPI monitor devices.
; Return values .: Success      - nonzero.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: To query all display devices in the current session, call this function in a loop, starting with iDevNum
;                    set to 0, and incrementing iDevNum until the function fails. To select all display devices in the desktop,
;                    use only the display devices that have the DISPLAY_DEVICE_ATTACHED_TO_DESKTOP flag in the DISPLAY_DEVICE structure.
;                  To get information on the display adapter, call EnumDisplayDevices with lpDevice set to NULL. For example,
;                    DISPLAY_DEVICE.DeviceString contains the adapter name.
;                  To obtain information on a display monitor, first call EnumDisplayDevices with lpDevice set to NULL.
;                    Then call EnumDisplayDevices with lpDevice set to DISPLAY_DEVICE.DeviceName from the first call to
;                    EnumDisplayDevices and with iDevNum set to zero. Then DISPLAY_DEVICE.DeviceString is the monitor name.
;                  To query all monitor devices associated with an adapter, call EnumDisplayDevices in a loop with lpDevice set
;                    to the adapter name, iDevNum set to start at 0, and iDevNum set to increment until the function fails.
;                    Note that DISPLAY_DEVICE.DeviceName changes with each call for monitor information, so you must save the
;                    adapter name. The function fails when there are no more monitors for the adapter.
;                  Windows 98/Me: EnumDisplayDevicesW is supported by the Microsoft Layer for Unicode. To use this, you must
;                    add certain files to your application, as outlined in Microsoft Layer for Unicode on Windows 95/98/Me Systems.
; Related .......:
; Link ..........; @@MsdnLink@@ EnumDisplayDevices
; Example .......;
; ===============================================================================================================================
Func _GDI_EnumDisplayDevices($lpDevice, $iDevNum, $lpDisplayDevice, $dwflags)
	Local $tpDevice = "wstr"
	If $lpDevice = "" Or IsPtr($lpDevice) Then $tpDevice = "ptr"
	Local $aResult = DllCall($__GDI_user32dll, "int", "EnumDisplayDevicesW", $tpDevice, $lpDevice, "DWORD", $iDevNum, "ptr", $lpDisplayDevice, "DWORD", $dwflags)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_EnumDisplayDevices

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_EnumDisplaySettings
; Description ...: Retrieves information about one of the graphics modes for a display device. To retrieve information
;                    for all the graphics modes of a display device, make a series of calls to this function.
; Syntax.........: _GDI_EnumDisplaySettings($szDeviceName, $iModeNum, $lpDevMode)
; Parameters ....: $szDeviceName  - [in] Pointer to a null-terminated string that specifies the display device about whose
;                                          graphics mode the function will obtain information.
;                                        This parameter is either NULL or a DISPLAY_DEVICE.DeviceName returned from EnumDisplayDevices.
;                                          A NULL value specifies the current display device on the computer on which the calling thread is running.
;                                        Windows 95: lpszDeviceName must be NULL.
;                  $iModeNum      - [in] Specifies the type of information to retrieve. This value can be a graphics mode index or
;                                          one of the following values.
;                                          Value                         Meaning
;                                         $ENUM_CURRENT_SETTINGS   - Retrieve the current settings for the display device.
;                                         $ENUM_REGISTRY_SETTINGS  - Retrieve the settings for the display device that are currently stored in the registry.
;                                        Graphics mode indexes start at zero. To obtain information for all of a display device's
;                                          graphics modes, make a series of calls to EnumDisplaySettings, as follows: Set iModeNum
;                                          to zero for the first call, and increment iModeNum by one for each subsequent call. Continue
;                                          calling the function until the return value is zero.
;                                        When you call EnumDisplaySettings with iModeNum set to zero, the operating system
;                                          initializes and caches information about the display device. When you call
;                                          EnumDisplaySettings with iModeNum set to a non-zero value, the function returns the
;                                          information that was cached the last time the function was called with iModeNum set to zero.
;                  $lpDevMode     - [out] Pointer to a DEVMODE structure into which the function stores information about the
;                                          specified graphics mode. Before calling EnumDisplaySettings, set the dmSize member
;                                          to sizeof (DEVMODE), and set the dmDriverExtra member to indicate the size, in bytes,
;                                          of the additional space available to receive private driver data.
;                                         The EnumDisplaySettings function sets values for the following five DEVMODE members:
;                                            * dmBitsPerPel
;                                            * dmPelsWidth
;                                            * dmPelsHeight
;                                            * dmDisplayFlags
;                                            * dmDisplayFrequency
; Return values .: Success      - nonzero.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The function fails if iModeNum is greater than the index of the display device's last graphics mode.
;                   As noted in the description of the iModeNum parameter, you can use this behavior to enumerate all of a
;                   display device's graphics modes.
; Related .......:
; Link ..........; @@MsdnLink@@ EnumDisplaySettings
; Example .......;
; ===============================================================================================================================
Func _GDI_EnumDisplaySettings($szDeviceName, $iModeNum, $lpDevMode)
	Local $tpDevice = "wstr"
	If $szDeviceName = "" Or (IsInt($szDeviceName) And $szDeviceName=0) Then $tpDevice = "ptr"
	Local $aResult = DllCall($__GDI_user32dll, "int", "EnumDisplaySettingsW", $tpDevice, $szDeviceName, "DWORD", $iModeNum, "ptr", $lpDevMode)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_EnumDisplaySettings

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_EnumDisplaySettingsEx
; Description ...: Retrieves information about one of the graphics modes for a display device. To retrieve information for
;                   all the graphics modes for a display device, make a series of calls to this function.
;                  This function differs from EnumDisplaySettings in that there is a dwFlags parameter.
; Syntax.........: _GDI_EnumDisplaySettingsEx($szDeviceName, $iModeNum, $lpDevMode)
; Parameters ....: $szDeviceName  - [in] Pointer to a null-terminated string that specifies the display device about whose
;                                          graphics mode the function will obtain information.
;                                        This parameter is either NULL or a DISPLAY_DEVICE.DeviceName returned from EnumDisplayDevices.
;                                          A NULL value specifies the current display device on the computer on which the calling thread is running.
;                                        Windows 95: lpszDeviceName must be NULL.
;                  $iModeNum      - [in] Specifies the type of information to retrieve. This value can be a graphics mode index or
;                                          one of the following values.
;                                          Value                         Meaning
;                                         $ENUM_CURRENT_SETTINGS   - Retrieve the current settings for the display device.
;                                         $ENUM_REGISTRY_SETTINGS  - Retrieve the settings for the display device that are currently stored in the registry.
;                                        Graphics mode indexes start at zero. To obtain information for all of a display device's
;                                          graphics modes, make a series of calls to EnumDisplaySettingsEx, as follows: Set iModeNum
;                                          to zero for the first call, and increment iModeNum by one for each subsequent call. Continue
;                                          calling the function until the return value is zero.
;                                        When you call EnumDisplaySettingsEx with iModeNum set to zero, the operating system
;                                          initializes and caches information about the display device. When you call
;                                          EnumDisplaySettingsEx with iModeNum set to a non-zero value, the function returns the
;                                          information that was cached the last time the function was called with iModeNum set to zero.
;                  $lpDevMode     - [out] Pointer to a DEVMODE structure into which the function stores information about the
;                                          specified graphics mode. Before calling EnumDisplaySettingsEx, set the dmSize member
;                                          to sizeof (DEVMODE), and set the dmDriverExtra member to indicate the size, in bytes,
;                                          of the additional space available to receive private driver data.
;                                         The EnumDisplaySettingsEx function sets values for the following five DEVMODE members:
;                                            * dmBitsPerPel
;                                            * dmPelsWidth
;                                            * dmPelsHeight
;                                            * dmDisplayFlags
;                                            * dmDisplayFrequency
;                                            * dmPosition
;                                            * dmDisplayOrientation
;                  $dwFlags       - [in] This parameter can be the following value.
;                                          $EDS_RAWMODE - If set, the function will return all graphics modes reported by the adapter
;                                               driver, regardless of monitor capabilities. Otherwise, it will only return modes that
;                                               are compatible with current monitors.
; Return values .: Success      - nonzero.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The function fails if iModeNum is greater than the index of the display device's last graphics mode.
;                   As noted in the description of the iModeNum parameter, you can use this behavior to enumerate all of a
;                   display device's graphics modes.
; Related .......:
; Link ..........; @@MsdnLink@@ EnumDisplaySettingsEx
; Example .......;
; ===============================================================================================================================
Func _GDI_EnumDisplaySettingsEx($szDeviceName, $iModeNum, $lpDevMode, $dwflags)
	Local $tpDevice = "wstr"
	If $szDeviceName = "" Or (IsInt($szDeviceName) And $szDeviceName=0) Or IsPtr($szDeviceName) Then $tpDevice = "ptr"
	Local $aResult = DllCall($__GDI_user32dll, "int", "EnumDisplaySettingsExW", $tpDevice, $szDeviceName, "DWORD", $iModeNum, "ptr", $lpDevMode, "dword", $dwflags)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_EnumDisplaySettingsEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_EnumObjects
; Description ...: Enumerates the pens or brushes available for the specified device context (DC). This function calls the
;                    application-defined callback function once for each available object, supplying data describing that object.
;                    EnumObjects continues calling the callback function until the callback function returns zero or until all of
;                    the objects have been enumerated.
; Syntax.........: _GDI_EnumObjects($hdc, $nObjectType, $lpObjectFunc, $lParam)
; Parameters ....: $hdc           - [in] Handle to the DC.
;                  $nObjectType   - [in] Specifies the object type. This parameter can be OBJ_BRUSH or OBJ_PEN.
;                  $lpObjectFunc  - [in] Pointer to the application-defined callback function. For more information about the
;                                          callback function, see the EnumObjectsProc function.
;                  $lParam        - [in] Pointer to the application-defined data. The data is passed to the callback function
;                                          along with the object information.
; Return values .: Success      - last value returned by the callback function. Its meaning is user-defined.
;                  Failure      - 0 (without calling the callback function if the objects cannot be enumerated)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ EnumObjects
; Example .......;
; ===============================================================================================================================
Func _GDI_EnumObjects($hdc, $nObjectType, $lpObjectFunc, $lParam)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "EnumObjects", "ptr", $hdc, "int", $nObjectType, "ptr", $lpObjectFunc, "LPARAM", $lParam)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_EnumObjects

; #CALLBACKFUNCTION# ====================================================================================================================
; Name...........: _GDI_EnumObjectsProc
; Description ...: application-defined callback function used with the EnumObjects function. It is used to process the object data.
;                    The GOBJENUMPROC type defines a pointer to this callback function.
;                     EnumObjectsProc is a placeholder for the application-defined function name.
; Syntax.........:
; Parameters ....: $lpLogObject  - [in] Pointer to a LOGPEN or LOGBRUSH structure describing the attributes of the object.
;                  $lpData       - [in] Pointer to the application-defined data passed by the EnumObjects function.
; Return values .: To continue enumeration, the callback function must return a nonzero value. This value is user-defined.
;                  To stop enumeration, the callback function must return zero.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: An application must register this function by passing its address to the EnumObjects function.
; Related .......:
; Link ..........; @@MsdnLink@@ EnumObjectsProc
; Example .......; DllCallbackRegister("_GDI_EnumObjectsProc", "INT", "ptr;LPARAM")
; ===============================================================================================================================
Func _GDI_EnumObjectsProc($lpLogObject, $lpData)
;~ 	Local $tLOGPEN = DllStructCreate($tagLOGPEN, $lpLogObject)
	; OR:
;~ 	Local $tLOGBRUSH = DllStructCreate($tagLOGBRUSH, $lpLogObject)

	; to continue enueration, e.g.
;~ 	Return 123
	; To abort enumeration:
	Return 0
EndFunc   ;==>_GDI_EnumObjectsProc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetCurrentObject
; Description ...: Retrieves a handle to an object of the specified type that has been selected into the specified device context (DC).
; Syntax.........:
; Parameters ....: $hdc          - [in] Handle to the DC.
;                  $uObjectType  - [in] Specifies the object type to be queried. This parameter can be one of the following values.
;                                         Value               Meaning
;                                       $OBJ_BITMAP      -  Returns the current selected bitmap.
;                                       $OBJ_BRUSH       -  Returns the current selected brush.
;                                       $OBJ_COLORSPACE  -  Returns the current color space.
;                                       $OBJ_FONT        -  Returns the current selected font.
;                                       $OBJ_PAL         -  Returns the current selected palette.
;                                       $OBJ_PEN         -  Returns the current selected pen.
; Return values .: Success      - handle to the specified object.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: An application can use the GetCurrentObject and GetObject functions to retrieve descriptions of the graphic
;                    objects currently selected into the specified DC.
; Related .......:
; Link ..........; @@MsdnLink@@ GetCurrentObject
; Example .......;
; ===============================================================================================================================
Func _GDI_GetCurrentObject($hdc, $uObjectType)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "GetCurrentObject", "ptr", $hdc, "UINT", $uObjectType)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetCurrentObject

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDC
; Description ...: Retrieves a handle of a display device context for the client area a window
; Syntax.........: _GDI_GetDC($hWnd)
; Parameters ....: $hWnd        - Handle of window
; Return values .: Success      - The device context for the given window's client area
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: After painting with a common device context, the _GDI_ReleaseDC function must be called to release the DC
; Related .......:
; Link ..........; @@MsdnLink@@ GetDC
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_GetDC($hwnd)
	Local $aResult = DllCall($__GDI_user32dll, "ptr", "GetDC", "hwnd", $hwnd)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDCBrushColor
; Description ...: The GetDCBrushColor function retrieves the current brush color for the specified device context (DC).
; Syntax.........: _GDI_GetDCBrushColor($hDC)
; Parameters ....: $hDC  - [in] Handle to the DC whose brush color is to be returned.
; Return values .: Success      - COLORREF value for the current DC brush color.
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: For information on setting the brush color, see SetDCBrushColor.
;                  ICM: Color management is performed if ICM is enabled.
; Related .......:
; Link ..........; @@MsdnLink@@ GetDCBrushColor
; Example .......;
; ===============================================================================================================================
Func _GDI_GetDCBrushColor($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "GetDCBrushColor", "ptr", $hdc)
	If @error Then Return SetError(1, @error, $CLR_INVALID)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDCBrushColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDCEx
; Description ...: The GetDCEx function retrieves a handle to a device context (DC) for the client area of a specified window or
;                    for the entire screen. You can use the returned handle in subsequent GDI functions to draw in the DC.
;                    The device context is an opaque data structure, whose values are used internally by GDI.
;                  This function is an extension to the GetDC function, which gives an application more control over how and
;                    whether clipping occurs in the client area.
; Syntax.........: _GDI_GetDCEx($hWnd, $hrgnClip, $flags)
; Parameters ....: $hWnd      - [in] Handle to the window whose DC is to be retrieved. If this value is NULL, GetDCEx retrieves
;                                    the DC for the entire screen.
;                               Windows 98/Me, Windows 2000/XP: To get the DC for a specific display monitor, use the
;                                 EnumDisplayMonitors and CreateDC functions.
;                  $hrgnClip  - [in] Specifies a clipping region that may be combined with the visible region of the DC.
;                                    If the value of flags is DCX_INTERSECTRGN or DCX_EXCLUDERGN, then the operating system assumes
;                                    ownership of the region and will automatically delete it when it is no longer needed. In this
;                                    case, the application should not use or delete the region after a successful call to GetDCEx.
;                  $flags     - [in] Specifies how the DC is created. This parameter can be one or more of the following values.
;                               Value            Meaning
;                               $DCX_WINDOW            - Returns a DC that corresponds to the window rectangle rather
;                                                          than the client rectangle.
;                               $DCX_CACHE             - Returns a DC from the cache, rather than the OWNDC or CLASSDC window.
;                                                          Essentially overrides CS_OWNDC and CS_CLASSDC.
;                               $DCX_PARENTCLIP        - Uses the visible region of the parent window. The parent's WS_CLIPCHILDREN
;                                                          and CS_PARENTDC style bits are ignored. The origin is set to the upper-left
;                                                          corner of the window identified by hWnd.
;                               $DCX_CLIPSIBLINGS      - Excludes the visible regions of all sibling windows above the
;                                                          window identified by hWnd.
;                               $DCX_CLIPCHILDREN      - Excludes the visible regions of all child windows below the
;                                                          window identified by hWnd.
;                               $DCX_NORESETATTRS      - Does not reset the attributes of this DC to the default attributes
;                                                          when this DC is released.
;                               $DCX_LOCKWINDOWUPDATE  - Allows drawing even if there is a LockWindowUpdate call in effect that
;                                                          would otherwise exclude this window. Used for drawing during tracking.
;                               $DCX_EXCLUDERGN        - The clipping region identified by hrgnClip is excluded from the visible
;                                                          region of the returned DC.
;                               $DCX_INTERSECTRGN      - The clipping region identified by hrgnClip is intersected with the visible
;                                                          region of the returned DC.
;                               $DCX_INTERSECTUPDATE   - Reserved; do not use.
;                               $DCX_VALIDATE  - Reserved; do not use.
; Return values .: Success      - handle to the DC for the specified window.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Unless the display DC belongs to a window class, the ReleaseDC function must be called to release the DC
;                    after painting. Also, ReleaseDC must be called from the same thread that called GetDCEx.
;                    The number of DCs is limited only by available memory.
;                  Windows 95/98/Me: There are only five common DCs available at any time, thus failure to release a DC can
;                    prevent other applications from accessing one.
;                  The function returns a handle to a DC that belongs to the window's class if CS_CLASSDC, CS_OWNDC or
;                    CS_PARENTDC was specified as a style in the WNDCLASS structure when the class was registered.
; Related .......:
; Link ..........; @@MsdnLink@@ GetDCEx
; Example .......;
; ===============================================================================================================================
Func _GDI_GetDCEx($hwnd, $hrgnClip, $flags)
	Local $aResult = DllCall($__GDI_user32dll, "ptr", "GetDCEx", "hwnd", $hwnd, "ptr", $hrgnClip, "dword", $flags)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDCEx

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDCOrgEx
; Description ...: Retrieves the final translation origin for a specified device context (DC). The final translation origin
;                    specifies an offset that the system uses to translate device coordinates into client coordinates
;                    (for coordinates in an application's window).
; Syntax.........: _GDI_GetDCOrgEx($hdc, $lpPoint)
; Parameters ....: $hdc      - [in]  Handle to the DC whose final translation origin is to be retrieved.
;                  $lpPoint  - [out] Pointer to a POINT structure that receives the final translation origin, in device coordinates.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The final translation origin is relative to the physical origin of the screen.
; Related .......:
; Link ..........; @@MsdnLink@@ GetDCOrgEx
; Example .......;
; ===============================================================================================================================
Func _GDI_GetDCOrgEx($hdc, $lpPoint)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "GetDCOrgEx", "ptr", $hdc, "ptr", $lpPoint)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDCBrushColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDCPenColor
; Description ...: Retrieves the current pen color for the specified device context (DC).
; Syntax.........: _GDI_GetDCPenColor($hdc)
; Parameters ....: hdc  - [in] Handle to the DC whose pen color is to be returned.
; Return values .: Success      - COLORREF value for the current DC pen color.
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: For information on setting the pen color, see SetDCPenColor.
;                  ICM: Color management is performed if ICM is enabled.
; Related .......:
; Link ..........; @@MsdnLink@@ GetDCPenColor
; Example .......;
; ===============================================================================================================================
Func _GDI_GetDCPenColor($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "GetDCPenColor", "ptr", $hdc)
	If @error Then Return SetError(1, @error, $CLR_INVALID)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDCBrushColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetDeviceCaps
; Description ...: Retrieves device specific information about a specified device
; Syntax.........: _GDI_GetDeviceCaps($hDC, $iIndex)
; Parameters ....: $hDC         - Identifies the device context
;                  $iIndex      - Specifies the item to return, see MSDN for possible values
; Return values .: Success      - The value of the desired item
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetDeviceCaps
; Example .......;
; ===============================================================================================================================
Func _GDI_GetDeviceCaps($hDC, $iIndex)
	Local $aResult = DllCall($__GDI_gdi32dll , "int", "GetDeviceCaps", "ptr", $hDC, "int", $iIndex)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetDeviceCaps

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetLayout
; Description ...: Returns the layout of a device context (DC).
; Syntax.........: _GDI_GetLayout($hDC)
; Parameters ....: $hdc  - [in] Handle to the device context.
; Return values .: Success      - layout flags for the current device context.
;                  Failure      - $GDI_ERROR
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The layout specifies the order in which text and graphics are revealed in a window or device context.
;                    The default is left to right. The GetLayout function tells you if the default has been changed through a
;                    call to SetLayout. For more information, see "Window Layout and Mirroring" in Window Features.
; Related .......:
; Link ..........; @@MsdnLink@@ GetLayout
; Example .......;
; ===============================================================================================================================
Func _GDI_GetLayout($hDC)
	Local $aResult = DllCall($__GDI_gdi32dll, "DWORD", "GetLayout", "ptr", $hDC)
	If @error Then Return SetError(1, @error, $GDI_ERROR)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetObject
; Description ...: Retrieves information for the specified graphics object
; Syntax.........: _GDI_GetObject($hObject, $iSize, $pObject)
; Parameters ....: $hObject     - Identifies a logical pen, brush, font, bitmap, region, or palette
;                  $iSize       - Specifies the number of bytes to be written to the buffer
;                  $pObject     - Pointer to a buffer that receives the information.  The following shows the type of information
;                  +the buffer receives for each type of graphics object you can specify:
;                  |HBITMAP  - BITMAP or DIBSECTION
;                  |HPALETTE - A count of the number of entries in the logical palette
;                  |HPEN     - EXTLOGPEN or LOGPEN
;                  |HBRUSH   - LOGBRUSH
;                  |HFONT    - LOGFONT
;                  -
;                  |If $pObject is 0 the function return value is the number of bytes required to store the information it writes
;                  +to the buffer for the specified graphics object.
; Return values .: Success      - If $pObject is a valid pointer, the return value is the number of bytes stored into the buffer.
;                  +If the function succeeds, and $pObject is 0, the return value is the number of bytes  required  to  hold  the
;                  +information the function would store into the buffer.
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetObject
; Example .......;
; ===============================================================================================================================
Func _GDI_GetObject($hObject, $iSize, $pObject)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "int", "GetObject", "int", $hObject, "int", $iSize, "ptr", $pObject)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetObject

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetObjectType
; Description ...: Retrieves the type of the specified object.
; Syntax.........: _GDI_GetObjectType($hGDIObj)
; Parameters ....: $hGDIObj - [in] Handle to the graphics object.
; Return values .: Success      - identifies the object. This value can be one of the following.
;                                  Value           Meaning
;                                 $OBJ_BITMAP      - Bitmap
;                                 $OBJ_BRUSH       - Brush
;                                 $OBJ_COLORSPACE  - Color space
;                                 $OBJ_DC          - Device context
;                                 $OBJ_ENHMETADC   - Enhanced metafile DC
;                                 $OBJ_ENHMETAFILE - Enhanced metafile
;                                 $OBJ_EXTPEN      - Extended pen
;                                 $OBJ_FONT        - Font
;                                 $OBJ_MEMDC       - Memory DC
;                                 $OBJ_METAFILE    - Metafile
;                                 $OBJ_METADC      - Metafile DC
;                                 $OBJ_PAL         - Palette
;                                 $OBJ_PEN         - Pen
;                                 $OBJ_REGION      - Region
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetObjectType
; Example .......;
; ===============================================================================================================================
Func _GDI_GetObjectType($hGDIObj)
	Local $aResult = DllCall($__GDI_gdi32dll, "DWORD", "GetObjectType", "ptr", $hGDIObj)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_GetStockObject
; Description ...: Retrieves a handle to one of the predefined stock pens, brushes, fonts, or palettes
; Syntax.........: _GDI_GetStockObject($iObject)
; Parameters ....: $iObject     - Specifies the type of stock object. This parameter can be any one of the following values:
;                  |$BLACK_BRUSH         - Black brush
;                  |$DKGRAY_BRUSH        - Dark gray brush
;                  |$GRAY_BRUSH          - Gray brush
;                  |$HOLLOW_BRUSH        - Hollow brush (equivalent to NULL_BRUSH)
;                  |$LTGRAY_BRUSH        - Light gray brush
;                  |$NULL_BRUSH          - Null brush (equivalent to HOLLOW_BRUSH)
;                  |$WHITE_BRUSH         - White brush
;                  |$BLACK_PEN           - Black pen
;                  |$NULL_PEN            - Null pen
;                  |$WHITE_PEN           - White pen
;                  |$ANSI_FIXED_FONT     - Windows fixed-pitch (monospace) system font
;                  |$ANSI_VAR_FONT       - Windows variable-pitch (proportional space) system font
;                  |$DEVICE_DEFAULT_FONT - Device-dependent font
;                  |$DEFAULT_GUI_FONT    - Default font for user interface objects
;                  |$OEM_FIXED_FONT      - OEM dependent fixed-pitch (monospace) font
;                  |$SYSTEM_FONT         - System font
;                  |$SYSTEM_FIXED_FONT   - Fixed-pitch (monospace) system font used in Windows versions earlier than 3.0
;                  |$DEFAULT_PALETTE     - Default palette. This palette consists of the static colors in the system palette.
; Return values .: Success      - The logical object requested
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ GetStockObject
; Example .......;
; ===============================================================================================================================
Func _GDI_GetStockObject($iObject)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "GetStockObject", "int", $iObject)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_GetStockObject

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ReleaseDC
; Description ...: Releases a device context
; Syntax.........: _GDI_ReleaseDC($hWnd, $hDC)
; Parameters ....: $hWnd        - Handle of window
;                  $hDC         - Identifies the device context to be released
; Return values .: Success      - 1 (True)
;                  Failure      - 0 (False)
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......: The application must call the _GDI_ReleaseDC function for each call to the _GDI_GetWindowDC function  and  for
;                  each call to the _GDI_GetDC function that retrieves a common device context.
; Related .......: _GDI_GetDC, _GDI_GetWindowDC
; Link ..........; @@MsdnLink@@ ReleaseDC
; Example .......; Yes
; ===============================================================================================================================
Func _GDI_ReleaseDC($hWnd, $hDC)
	Local $aResult

	$aResult = DllCall($__GDI_user32dll, "int", "ReleaseDC", "hwnd", $hWnd, "ptr", $hDC)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_ReleaseDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_ResetDC
; Description ...: updates the specified printer or plotter device context (DC) using the specified information.
; Syntax.........: _GDI_ResetDC($hdc, $lpInitData)
; Parameters ....: $hdc         - [in] Handle to the DC to update.
;                  $lpInitData  - [in] Pointer to a DEVMODE structure containing information about the new DC.
; Return values .: Success      - handle to the original DC.
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: An application will typically use the ResetDC function when a window receives a WM_DEVMODECHANGE message.
;                    ResetDC can also be used to change the paper orientation or paper bins while printing a document.
;                  The ResetDC function cannot be used to change the driver name, device name, or the output port. When the user
;                    changes the port connection or device name, the application must delete the original DC and create a new
;                    DC with the new information.
;                  An application can pass an information DC to the ResetDC function. In that situation, ResetDC will always
;                    return a printer DC.
;                  ICM: The color profile of the DC specified by the hdc parameter will be reset based on the information
;                    contained in the lpInitData member of the DEVMODE structure.
; Related .......:
; Link ..........; @@MsdnLink@@ ResetDC
; Example .......;
; ===============================================================================================================================
Func _GDI_ResetDC($hdc, $lpInitData)
	Local $aResult = DllCall($__GDI_gdi32dll, "ptr", "ResetDCW", "ptr", $hdc, "ptr", $lpInitData)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_RestoreDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_RestoreDC
; Description ...: Restores a device context (DC) to the specified state. The DC is restored by popping state information off
;                    a stack created by earlier calls to the SaveDC function.
; Syntax.........: _GDI_RestoreDC($hdc, $savedDC)
; Parameters ....: $hdc       - [in] Handle to the DC.
;                  $nSavedDC  - [in] Specifies the saved state to be restored. If this parameter is positive, nSavedDC represents
;                                    a specific instance of the state to be restored. If this parameter is negative,
;                                    nSavedDC represents an instance relative to the current state.
;                                    For example, -1 restores the most recently saved state.
; Return values .: Success      - nonzero
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The stack can contain the state information for several instances of the DC. If the state specified by the
;                    specified parameter is not at the top of the stack, RestoreDC deletes all state information between the
;                    top of the stack and the specified instance.
; Related .......:
; Link ..........; @@MsdnLink@@ RestoreDC
; Example .......;
; ===============================================================================================================================
Func _GDI_RestoreDC($hdc, $savedDC)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "RestoreDC", "ptr", $hdc, "dword", $savedDC)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_RestoreDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SaveDC
; Description ...: Saves the current state of the specified device context (DC) by copying data describing selected objects and
;                    graphic modes (such as the bitmap, brush, palette, font, pen, region, drawing mode, and mapping mode)
;                    to a context stack.
; Syntax.........: _GDI_SaveDC($hdc)
; Parameters ....: $hdc  - [in] Handle to the DC whose state is to be saved.
; Return values .: Success      - identifies the saved state
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The SaveDC function can be used any number of times to save any number of instances of the DC state.
;                  A saved state can be restored by using the RestoreDC function.
; Related .......:
; Link ..........; @@MsdnLink@@ SaveDC
; Example .......;
; ===============================================================================================================================
Func _GDI_SaveDC($hdc)
	Local $aResult = DllCall($__GDI_gdi32dll, "int", "SaveDC", "ptr", $hdc)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SaveDC

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SelectObject
; Description ...: Selects an object into the specified device context
; Syntax.........: _GDI_SelectObject($hDC, $hGDIObj)
; Parameters ....: $hDC         - Identifies the device context
;                  $hGDIObj     - Identifies the object to be selected
; Return values .: Success      - The handle of the object being replaced
;                  Failure      - 0
; Author ........: Paul Campbell (PaulIA)
; Modified.......: Prog@ndy
; Remarks .......:
; Related .......:
; Link ..........; @@MsdnLink@@ SelectObject
; Example .......;
; ===============================================================================================================================
Func _GDI_SelectObject($hdc, $hGDIObj)
	Local $aResult

	$aResult = DllCall($__GDI_gdi32dll, "ptr", "SelectObject", "ptr", $hdc, "ptr", $hGDIObj)
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_GDI_SelectObject

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetDCBrushColor
; Description ...: Sets the current device context (DC) brush color to the specified color value. If the device cannot represent
;                    the specified color value, the color is set to the nearest physical color.
; Syntax.........: _GDI_SetDCBrushColor($hDC, $crColor)
; Parameters ....: $hdc      - [in] Handle to the DC.
;                  $crColor  - [in] Specifies the new brush color. (as COLORREF)
; Return values .: Success      - previous DC brush color as a COLORREF value.
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: When the stock DC_BRUSH is selected in a DC, all the subsequent drawings will be done using the DC brush
;                    color until the stock brush is deselected. The default DC_BRUSH color is WHITE.
;                  The function returns the previous DC_BRUSH color, even if the stock brush DC_BRUSH is not selected in the DC:
;                    however, this will not be used in drawing operations until the stock DC_BRUSH is selected in the DC.
;                  The GetStockObject function with an argument of DC_BRUSH or DC_PEN can be used interchangeably with the
;                    SetDCPenColor and SetDCBrushColor functions.
;                  ICM: Color management is performed if ICM is enabled.
; Related .......:
; Link ..........; @@MsdnLink@@ SetDCBrushColor
; Example .......;
; ===============================================================================================================================
Func _GDI_SetDCBrushColor($hDC, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "SetDCBrushColor", "ptr", $hDC, "dword", $crColor)
	If @error Then Return SetError(1, @error, $CLR_INVALID)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetDCPenColor
; Description ...: sets the current device context (DC) pen color to the specified color value. If the device cannot represent
;                    the specified color value, the color is set to the nearest physical color.
; Syntax.........: _GDI_SetDCPenColor($hDC, $crColor)
; Parameters ....: $hdc      - [in] Handle to the DC.
;                  $crColor  - [in] Specifies the new pen color. (as COLORREF)
; Return values .: Success      - previous DC pen color as a COLORREF value
;                  Failure      - $CLR_INVALID
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The function returns the previous DC_PEN color, even if the stock pen DC_PEN is not selected in the DC;
;                    however, this will not be used in drawing operations until the stock DC_PEN is selected in the DC.
;                  The GetStockObject function with an argument of DC_BRUSH or DC_PEN can be used interchangeably with the
;                    SetDCPenColor and SetDCBrushColor functions.
;                  ICM: Color management is performed if ICM is enabled.
; Related .......:
; Link ..........; @@MsdnLink@@ SetDCPenColor
; Example .......;
; ===============================================================================================================================
Func _GDI_SetDCPenColor($hDC, $crColor)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "SetDCPenColor", "ptr", $hDC, "dword", $crColor)
	If @error Then Return SetError(1, @error, $CLR_INVALID)
	Return $aResult[0]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDI_SetLayOut
; Description ...: changes the layout of a device context (DC).
; Syntax.........: _GDI_SetLayOut($hdc, $iLayOut)
; Parameters ....: $hdc       - [in] Handle to the DC.
;                  $dwLayout  - [in] Specifies the DC layout. This parameter can be one or more of the following values.
;                               Value                                 Meaning
;                               $LAYOUT_BITMAPORIENTATIONPRESERVED  - Disables any reflection during BitBlt and StretchBlt operations.
;                               $LAYOUT_RTL                         - Sets the default horizontal layout to be right to left.
; Return values .: Success      - previous layout of the DC.
;                  Failure      - $GDI_ERROR
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The layout specifies the order in which text and graphics are revealed in a window or a device context.
;                    The default is left to right. The SetLayout function changes this to be right to left, which is the
;                    standard in Arabic and Hebrew cultures.
; Related .......:
; Link ..........; @@MsdnLink@@ SetLayOut
; Example .......;
; ===============================================================================================================================
Func _GDI_SetLayOut($hdc, $iLayOut)
	Local $aResult = DllCall($__GDI_gdi32dll, "dword", "SetLayout", "ptr", $hdc, "dword", $iLayOut)
	If @error Then Return SetError(1, @error, $GDI_ERROR)
	Return $aResult[0]
EndFunc   ;==>_GDI_SetLayOut


#EndRegion				 Device Contexts
;*************************************************************
