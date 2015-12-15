; :wrap=none:collapseFolds=1:maxLineLen=80:mode=autoitscript:tabSize=8:folding=indent:

#Region SetOptions =============================================================
AutoItSetOption("CaretCoordMode", 1)        ;1=absolute, 0=relative, 2=client
AutoItSetOption("ExpandEnvStrings", 0)      ;0=don"t expand, 1=do expand
AutoItSetOption("ExpandVarStrings", 0)      ;0=don"t expand, 1=do expand
AutoItSetOption("FtpBinaryMode", 1)         ;1=binary, 0=ASCII
AutoItSetOption("GUICloseOnESC", 1)         ;1=ESC  closes, 0=ESC won"t close
AutoItSetOption("GUICoordMode", 1)          ;1=absolute, 0=relative, 2=cell
AutoItSetOption("GUIDataSeparatorChar","|") ;"|" is the default
AutoItSetOption("GUIOnEventMode", 0)        ;0=disabled, 1=OnEvent mode enabled
AutoItSetOption("GUIResizeMode", 0)         ;0=no resizing, <1024 special resizing
;~ AutoItSetOption("GUIEventAutoItSetOptionions",0)    ;0=default, 1=just notification, 2=GuiCtrlRead tab index
AutoItSetOption("MouseClickDelay", 10)      ;10 milliseconds
AutoItSetOption("MouseClickDownDelay", 10)  ;10 milliseconds
AutoItSetOption("MouseClickDragDelay", 250) ;250 milliseconds
AutoItSetOption("MouseCoordMode", 1)        ;1=absolute, 0=relative, 2=client
AutoItSetOption("MustDeclareVars", 1)       ;0=no, 1=require pre-declare
AutoItSetOption("OnExitFunc","OnAutoItExit");"OnAutoItExit" called
AutoItSetOption("PixelCoordMode", 1)        ;1=absolute, 0=relative, 2=client
AutoItSetOption("SendAttachMode", 0)        ;0=don"t attach, 1=do attach
AutoItSetOption("SendCapslockMode", 1)      ;1=store and restore, 0=don"t
AutoItSetOption("SendKeyDelay", 5)          ;5 milliseconds
AutoItSetOption("SendKeyDownDelay", 1)      ;1 millisecond
AutoItSetOption("TCPTimeout",100)           ;100 milliseconds
AutoItSetOption("TrayAutoPause",0)          ;0=no pause, 1=Pause
AutoItSetOption("TrayIconDebug", 1)         ;0=no info, 1=debug line info
AutoItSetOption("TrayIconHide", 0)          ;0=show, 1=hide tray icon
AutoItSetOption("TrayMenuMode",0)           ;0=append, 1=no default menu, 2=no automatic check, 4=menuitemID  not return
AutoItSetOption("TrayOnEventMode",0)        ;0=disable, 1=enable
AutoItSetOption("WinDetectHiddenText", 0)   ;0=don"t detect, 1=do detect
AutoItSetOption("WinSearchChildren", 1)     ;0=no, 1=search children also
AutoItSetOption("WinTextMatchMode", 1)      ;1=complete, 2=quick
AutoItSetOption("WinTitleMatchMode", 1)     ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase
AutoItSetOption("WinWaitDelay", 250)        ;250 milliseconds
#EndRegion =====================================================================
#Region Includes ===============================================================
#include <Array.au3>
#include <File.au3>
#include <String.au3>
#EndRegion =====================================================================
#Region Main ===================================================================

Global $akkFileArray, $akkFilePath = ''
_FileReadToArray($akkFilePath, $akkFileArray)

#EndRegion =====================================================================
#Region Functions ==============================================================

#EndRegion =====================================================================
