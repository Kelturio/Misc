#include "Console.au3"
Global Const $_Console_USEWINDOW = False
_Console_STARTUP()
_Console_Write("Testkonsole." & @CRLF)

_Console_Write("Prompt: ")
MsgBox(0, '',  _Console_Read())

MsgBox(0, '', _Console_Ask("Noch eine Eingabe: "))

_Console_Pause()