;Printf like
#define DEBUG(comment, ...) ConsoleWRite("!(" & __FILE__ & ") Debug on line: " & __LINE__  & @CRLF  & \
							"> " & StringFormat(comment,__VA_ARGS__) & @CRLF)
;object macros
#define foo
#define bar
;constant like macroes
#define PI 3.14159
DEBUG("PI is: %f",PI)


;example of condition
#if AU3VERSION >= 3361
DEBUG("Your version is up to date! (%d)",AU3VERSION)
#else
DEBUG("Update your autoit, it is only %d",AU3VERSION)
#endif
#if defined BETA
DEBUG("using beta")
#endif

#undef bar
#undef DEBUG
;Autoit debug like
#define DEBUG(comment) ConsoleWRite("!(" & __FILE__ & ") Debug on line: " & __LINE__  & @CRLF  & "> " & comment & @CRLF)

;Conditional inclusion
#if bar || defined(foo)
DEBUG("Including GuiConstants.au3")
#include <GuiConstants.au3>
#else
DEBUG("Including WindowsConstants.au3")
#include <WindowsConstants.au3>
#endif

;Argument concating
#define GLUE(a,b) a##b
GLUE(Console,Write)("Glued ConsoleWrite!" & @CRLF)

;Some nifty tricks
#define vardbg(var) ConsoleWrite("!Var debug: " & #var & @CRLF & ">" & \
		@Tab & "Type: "& VarGetType(var) & ", value: " & var & ", bool: " & NOT NOT var & ", hex: 0x" & Hex(var) & @CRLF)

$mystring = "Hey!"
vardbg($mystring)

;function-like macros
#define RADTODEG(x) ((x) * 57.29578)
ConsoleWrite(RADTODEG(0.3) & @CRLF)
