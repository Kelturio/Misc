#include 'xHashCollection.au3'


x( 'foo' , 'bar' ) ; foo = bar
x( 'bar.foo' , 'baz' ) ; bar[foo] = baz
MsgBox( 0 , x( 'foo' ) , x( 'bar.foo' ) ); outputs 'bar' and 'baz'


x( "localization.en.lang_en","English")
x( "localization.es.lang_en","Ingles")
For $language_code In x( 'localization' )
    MsgBox( 0 , 'Language' , x( 'localization.'&$language_code&'.lang_en' ) )
Next


x( 'foo' , x( 'bar' , 'baz' ) ) ;foo and bar both contain baz
;~ If ( x( 'query' , $query ) == '' ) MsgBox( 0 , 'Error' , 'Query cannot be blank!' )


x( 'foo' , x( 'bar' , 'baz' ) )
x( 'yada' , 'yada' )
x_display() ;display everything
x_display( 'localization' ) ;display just foo


x( "localization.en.lang_name","English")
x( "localization.en.i_speak","I speak English")
x( "localization.fr.lang_name","Français")
x( "localization.fr.i_speak","Je parle français")
x( "localization.es.lang_name","Español")
x( "localization.es.i_speak","Hablo español")

; start with English
Global $currentLanguage = "en"
MsgBox( 0 , getLocalized( 'lang_name' ) , getLocalized( 'i_speak' ) )

; change the language to French
$currentLanguage = "fr"
MsgBox( 0 , getLocalized( 'lang_name' ) , getLocalized( 'i_speak' ) )

; change the language to Spanish
$currentLanguage = "es"
MsgBox( 0 , getLocalized( 'lang_name' ) , getLocalized( 'i_speak' ) )

; let's look at the structure of the stored data
x_display()

Func getLocalized( $label )
    Return x( 'localization.'&$currentLanguage&'.'&$label )
EndFunc


Local $myArray[2][2] = [[1,2],[3,4]]
x( 'some.key' , $myArray )
x_display()

x_unset( 'bar' )

x( 'foo' , 'bar' )
x( 'yada' , 'yada' )
x( 'bar.foo' , 'bla' )
x_display()
x_unset( 'bar' )
x_display()


x( 'myObj.hello' , 'world' )
Local $myObj = x( 'myObj' )
Local $myArray[2][2] = [[1,2],[3,4]]
Local $myArray2[2][2] = [[$myArray,$myObj],[$myArray,$myObj]]
x( 'some.key' , $myArray2 )
x_display()