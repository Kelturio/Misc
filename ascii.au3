Global $t1 = 66666, $breite = 1666, $fontsz = 12, $h = 666, $opt = 22





$message = ""
$message = $message & @LF & "         .8.          8 8888                  .8.          8 888888888o.      8 888888888o.    8 8888          .8.          "
$message = $message & @LF & "        .888.         8 8888                 .888.         8 8888    `^888.   8 8888    `88.   8 8888         .888.         "
$message = $message & @LF & "       :88888.        8 8888                :88888.        8 8888        `88. 8 8888     `88   8 8888        :88888.        "
$message = $message & @LF & "      . `88888.       8 8888               . `88888.       8 8888         `88 8 8888     ,88   8 8888       . `88888.       "
$message = $message & @LF & "     .8. `88888.      8 8888              .8. `88888.      8 8888          88 8 8888.   ,88'   8 8888      .8. `88888.      "
$message = $message & @LF & "    .8`8. `88888.     8 8888             .8`8. `88888.     8 8888          88 8 888888888P'    8 8888     .8`8. `88888.     "
$message = $message & @LF & "   .8' `8. `88888.    8 8888            .8' `8. `88888.    8 8888         ,88 8 8888`8b        8 8888    .8' `8. `88888.    "
$message = $message & @LF & "  .8'   `8. `88888.   8 8888           .8'   `8. `88888.   8 8888        ,88' 8 8888 `8b.      8 8888   .8'   `8. `88888.   "
$message = $message & @LF & " .888888888. `88888.  8 8888          .888888888. `88888.  8 8888    ,o88P'   8 8888   `8b.    8 8888  .888888888. `88888.  "
$message = $message & @LF & ".8'       `8. `88888. 8 888888888888 .8'       `8. `88888. 8 888888888P'      8 8888     `88.  8 8888 .8'       `8. `88888. "

While 1
SplashTextOn("Consolas", $message, $breite, $h, -1, -1, $opt, "Consolas", $fontsz)
Sleep($t1)
SplashTextOn("Courier", $message, $breite, $h, -1, -1, $opt, "Courier", $fontsz)
Sleep($t1)
SplashTextOn("Fixedsys", $message, $breite, $h, -1, -1, $opt, "Fixedsys", $fontsz)
Sleep($t1)
;~ SplashTextOn("Terminal", $message, $breite, $h, -1, -1, $opt, "Terminal", $fontsz)
;~ Sleep($t1)
SplashTextOn("Lucida Console", $message, $breite, $h, -1, -1, $opt, "Lucida Console", $fontsz)
Sleep($t1)


WEnd
;~ For $x = 1 to 20
;~ 	$message = $message & $x & @LF
;~ 	ControlSetText("TitleFoo", "", "Static1", $message)
;~ 	sleep(100)
;~ Next
;~ Sleep(1000*60*60)