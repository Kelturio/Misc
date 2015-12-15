#include <Console.au3>

Main()

Func Main()
    Local $Name
    Local $Age
    Local $Answer
    Local $Continue = True

    While $Continue
        Cout("Enter your name: ")
        Cin($Name)
        Cout("Enter your age: ")
        Cin($Age)
        Cout("Do you want your answers printed in red? y/n: ")
        Cin($Answer)
        If StringInStr($Answer,"y") Then
            Cout(@LF & "Your name is ")
            Cout($Name & @LF,$FOREGROUND_RED)
            Cout("You were born in ")
            Cout(@Year - $Age & @LF,$FOREGROUND_RED)
        Else
            Cout(@LF & "Your name is ")
            Cout($Name & @LF)
            Cout("You were born in ")
            Cout(@Year - $Age & @LF)
        EndIf
        $Answer = ""
        Cout(@LF & "Do you want to try again? y/n: ")
        Cin($Answer)
        If StringInStr($Answer,"n") Then
            $Continue = False
        EndIf
    WEnd

    system("pause")
EndFunc