#include <ButtonConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIConstants.au3>
#include <GDIplus.au3>
SRandom(@AutoItPID)
WinMinimizeAll ()
HotKeySet("{ESC}", "exit")
Dim $x, $y, $Color, $Width
While "Drawing Pixel"
$pixel2 = PixelSearch(0,0,1000,768, 0x000000)  
   If IsArray($pixel2) = True Then
   $Width = 5
    $x =$pixel2[0]   
    $y = $pixel2[1]
    $Color = 0xFFA9EC
    drawapixel()    
   EndIf  
WEnd
Func drawapixel()
    $hnd = DllCall("user32.dll", "int", "GetDC", "hwnd", 0)
    $Pen = DllCall("gdi32.dll", "int", "CreatePen", "int", 0, "int", $Width, "int", $Color)
    DllCall("gdi32.dll", "int", "SelectObject", "int", $hnd[0], "int", $Pen[0])
    DllCall("GDI32.dll", "int", "MoveToEx", "hwnd", $hnd[0], "int", $x, "int", $y, "int", 0)
    DllCall("GDI32.dll", "int", "LineTo", "hwnd", $hnd[0], "int", $x, "int", $y)
    DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "int", $hnd[0])
EndFunc  
Func exit()
    WinMinimizeAllUndo ( )
    Exit
EndFunc
