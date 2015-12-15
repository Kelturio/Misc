/**
 * wuala-utils.js
 * 
 * Author: Roger Jaeggi, LaCie AG
 * Date: 2011-01-07
 * 
 */

/********************/
/** Wuala Webstart **/
/********************/

// Timer used for checking if Java is available
var timer;
// Start time of the timer above. Only used for debugging output.
var startTime;
// Maximum duration to load Java (in seconds). After that, the page shows an error message.
var MAX_TIME_TO_LOAD_JAVA = 30;
// current java loading time - script stops waiting for Java as soon as MAX_TIME_TO_LOAD_JAVA is reached
var cLoadingTime = 0;
// Is set to true as soon as the applet has called setJavaEnabled.
var javaEnabled = false;
var wheel = '<img src="/img/loading2.gif" alt="" height="16px" width="16px" style="margin-left: 5px; margin-bottom: -4px;" id="wheel" /> ';

// Path/item we have to open in Wuala
var wualaPath;
var lang;
var useTestVersion;
var useTrunkVersion;
var isBuggyJVM;
var trustedApplet;
var promocode;
var register;
var signin;

//Add a global variable to use as a namespace
var Wuala = Wuala || {};

function parseOptions(options) {
	if ("wualaPath" in options) {
		wualaPath = stripslashes(options["wualaPath"]);
	} else {
		wualaPath = '/';
	}
	if ("useTestVersion" in options) {
		useTestVersion = options["useTestVersion"] == 1? true : false;
	} else {
		useTestVersion = false;
	}
	if ("useTrunkVersion" in options) {
		useTrunkVersion = options["useTrunkVersion"] == 1? true : false;
	} else {
		useTrunkVersion = false;
	}	
	if ("isBuggyJVM" in options) {
		isBuggyJVM = options["isBuggyJVM"] == 1? true : false;
	} else {
		isBuggyJVM = false;
	}
	if ("lang" in options) {
		lang = options["lang"];
	} else {
		lang = "en";
	}
	if ("trustedApplet" in options) {
		trustedApplet = options["trustedApplet"];
	}
	if ("promocode" in options) {
		promocode = options["promocode"];
	} else {
		promocode = "";
	}
	if ("signin" in options) {
		signin = options["signin"] == 1? true : false;
	} else {
		signin = false;
	}
	if ("register" in options) {
		register = options["register"] == 1? true : false;
	} else {
		register = false;
	}
	
}

function stripslashes(str) {
	str=str.replace(/\\'/g,'\'');
	str=str.replace(/\\"/g,'"');
	str=str.replace(/\\\\/g,'\\');
	str=str.replace(/\\0/g,'\0');
	return str;
}

/**
 * Initializes Wuala webstart.
 * We use an iFrame to avoid lifecycle problems. Loading an applet by DOM manipulations
 * can cause NPEs because the JVM tries to load the jar file before it was downloaded.
 * The iFrame solves this problem because the applet is loaded when the page is loaded.
 */
function initWebstart(options) {
	parseOptions(options);
	$('#startWualaButton').click(function(event) {
		if ($("input[@name='dialogSetting']:checked").val() == 'register') {
			signin = false;
			register = true;
		} else if ($("input[@name='dialogSetting']:checked").val() == 'signin') {
			signin = true;
			register = false;
		}
		var iframe = '<iframe src="/' + lang + '/applet?wualaPath=' + wualaPath + '&useTestVersion=' + useTestVersion + '&useTrunkVersion=' + useTrunkVersion + '&promocode='+ promocode + '&signin=' + signin + '&register=' + register + '" name="myWualaAppletPage" style="border: 0px; height: 1px; width: 1px; overflow; hidden;" frameborder="0" scrolling="no"></iframe>';
		$('#trustedApplet').html(iframe).show();
		event.preventDefault(); // do not open href link
	});
}

function loadTrustedApplet() {
	var iframe = '<iframe src="/' + lang + '/applet?wualaPath=' + wualaPath + '&useTestVersion=' + useTestVersion + '&useTrunkVersion=' + useTrunkVersion + '&promocode='+ promocode + '&signin=' + signin + '&register=' + register + '" name="myWualaAppletPage" style="border: 0px; height: 1px; width: 1px; overflow; hidden;" frameborder="0" scrolling="no"></iframe>';
	$('#trustedApplet').html(iframe).show();
}

/**
 * Init IFrame. Methods is called after IFrame was loaded.'.
 */
function initIFrame(options) {
	parseOptions(options);
	startTime = new Date();
	initAppletMsg();
}

/**
 * Init appletMsg div element. This div element is used to display useful 
 * information to the end user.
 * 
 */
function initAppletMsg() {
	if (isBuggyJVM) {
		switch(lang) {
		case 'de':
			$('#appletMsg').html("Wuala wird gestartet und öffnet in einem neuen Fenster.");
			break;
		case 'fr':
			$('#appletMsg').html("Wuala va s'ouvrir dans une nouvelle fenêtre.");
			break;
		case 'es':
			$('#appletMsg').html("Wuala se abrirá en una ventana nueva.");
			break;
		case 'pt':
			$('#appletMsg').html("O Wuala será aberto numa nova janela.");
			break;
		case 'zh':
			$('#appletMsg').html("Wuala 将在新窗口内打开。");
			break;
		case 'nl':
			$('#appletMsg').html("Wuala wordt geopend in een nieuw venster.");
			break;
		case 'it':
			$('#appletMsg').html("Wuala verrà aperto in una nuova finestra.");
			break;
		default:
			$('#appletMsg').html("Wuala will open in a new window.");	
			break;
		}
		setJavaEnabled();
	} else if (!javaEnabled) {
		handleJavaCounter();
		switch(lang) {
			case 'de':
				$('#appletMsg').html(wheel + '<strong>Suche Java ... <span id="java-loading-counter"></span></strong>');
				break;
			case 'fr':
				$('#appletMsg').html(wheel + '<strong>Vérification de Java ... <span id="java-loading-counter"></span></strong>');
				break;
			case 'es':
				$('#appletMsg').html(wheel + '<strong>Comprobando Java... <span id="java-loading-counter"></span></strong>');
				break;
			case 'pt':
				$('#appletMsg').html(wheel + '<strong>A verificar o Java... <span id="java-loading-counter"></span></strong>');
				break;
			case 'zh':
				$('#appletMsg').html(wheel + '<strong>正在检查 Java ... <span id="java-loading-counter"></span></strong>');
				break;
			case 'nl':
				$('#appletMsg').html(wheel + '<strong>Controleren op Java... <span id="java-loading-counter"></span></strong>');
				break;
			case 'it':
				$('#appletMsg').html(wheel + '<strong>Ricerca di Java... <span id="java-loading-counter"></span></strong>');
				break;
			default:
				$('#appletMsg').html(wheel + '<strong>Checking for Java ... <span id="java-loading-counter"></span></strong>');
				break;
		}
	}
}

/** 
 * Hide start link/button. 
 * This is necessary if it is not possible to start Wuala from the web.
 */
function removeStartLink() {
	$("#startWualaButton").remove();
}


/**
 * Updates the Java counter on the website. 
 * Calls setJavaDisabled() if loading time >= MAX_TIME_TO_LOAD_JAVA. 
 */
function handleJavaCounter() {
	cLoadingTime = cLoadingTime + 1;
	if (cLoadingTime >= MAX_TIME_TO_LOAD_JAVA) {
		clearTimeout(timer);
		setJavaDisabled();
	} else {
		$('#java-loading-counter').html((cLoadingTime) + "s");
		timer = setTimeout ("handleJavaCounter()", 1000);
	}
}

/**
 * Called by applet on startup to notify the webapplication about Java support.
 */
function setJavaEnabled() {
	clearTimeout(timer);
	javaEnabled = true;
	appendLogText("Java was loaded in " + (new Date() - startTime) + " ms.");
}

/**
 * Gets called by the timer if setJavaEnabled() is not called before
 * the timer finishes. In this case, it was not possible to start Java.
 */
function setJavaDisabled() {
	javaEnabled = false;
	hasJvmError = true;
	if (lang == "de") {
		jvmErrorMsg = "<strong>Java ist nicht verfügbar</strong><br /><br />";
		jvmErrorMsg += '<p class="detailed-message">Wuala konnte nicht direkt gestartet werden. Alternativ können Sie Wuala auch <a href="/de/download">herunterladen</a> und von Ihrem Computer aus starten.</p>';
	} else if (lang == "fr") {
		jvmErrorMsg = "<strong>Java doit être installé dans votre navigateur</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Wuala n'a pas réussi à démarrer depuis votre navigateur. Essayez de <a href=\"/fr/download\">télécharger</a> Wuala et de l'executer depuis votre ordinateur.</p>";	
	} else if (lang == "es") {
		jvmErrorMsg = "<strong>No está disponible Java</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Wuala no ha podido abrirse directamente desde la web. Intente <a href=\"/es/download\">descargar</a> Wuala y ejecutarlo desde su ordenador.</p>";	
	} else if (lang == "pt") {
		jvmErrorMsg = "<strong>O Java não está disponível</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Não foi possível iniciar o Wuala directamente a partir da Internet. Experimente <a href=\"/pt/download\">transferir</a> o Wuala e executá-lo a partir do computador.</p>";	
	} else if (lang == "zh") {
		jvmErrorMsg = "<strong>Java 不可用</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Wuala 无法直接从网页上启动。请尝试<a href=\"/es/download\">下载</a> Wuala 并从计算机上运行。</p>";	
	} else if (lang == "nl") {
		jvmErrorMsg = "<strong>Java is niet beschikbaar</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Wuala kan niet rechtstreeks vanaf internet worden gestart. Probeer Wuala te <a href=\"/nl/download\">downloaden</a> en vervolgens uit te voeren vanaf uw computer.</p>";	
	} else if (lang == "it") {
		jvmErrorMsg = "<strong>Java non è disponibile</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Non è stato possibile avviare Wuala direttamente dal Web. Prova a <a href=\"/it/download\">scaricare</a> Wuala ed eseguirlo direttamente dal tuo computer.</p>";	
	} else {
		jvmErrorMsg = "<strong>Java is not available</strong><br /><br />";
		jvmErrorMsg += "<p class=\"detailed-message\">Wuala was unable to start directly from the web. Try to <a href=\"/en/download\">download</a> Wuala and run it from your computer.</p>";	
	}
	
	removeStartLink();
	$('#wheel').hide();
	$('#appletMsg').html(jvmErrorMsg).show();
	$('#appletContainer').css({'border-color' : 'red', 'background-color' : '#fcfcfc'});
}

/**
 * Called by the applet if there is a problem.
 * 
 * @param title Title of the message (will be bold)
 * @param message Message to display
 */
function handleProblem(title, message) {
	$('#wheel').hide();
	$('#appletMsg').html('<strong>' + title + '</strong><p class="detailed-message">' + message + '</p>');
	removeStartLink();
}

/**
 * Called by the applet if there is something to log. For debugging only.
 * Show debugging output by setting the GET parameter 'debug' to 1.
 * 
 * @param text Text to append to the debug log
 */
function appendLogText(text) {	
	$('#debugMsg').append("<br />" +  text);
}

/**
 * Called by the applet to show information to the user. 
 * 
 * @param title Title of the information.
 * @param moreInfo Additional information. Can be empty.
 * @param showWheel Shows a spinning wheel if true.
 */
function setInfoText(title, moreInfo, showWheel) {
	if (moreInfo !== "") {
		$('#appletMsg').html(wheel + '<strong>' + title + '</strong><p class="detailed-message">' + moreInfo + '</p>');
	} else {
		$('#appletMsg').html(wheel + '<strong>' + title + '</strong>');
	}
	
	if (showWheel == "true") {
		$('#wheel').show();
	} else {
		$('#wheel').hide();
	}
}

/**
 * Print the applet. This must be done when the page is loaded. To avoid 
 * the "Click OK to load additional content" on IE6, we load the applet 
 * by the use of JavaScript. 
 */
function writeAppletTag() {
	document.writeln('<applet code="com.wuala.applet.TrustedApplet.class" archive="' + trustedApplet + '" width="1px" height="1px" mayscript="true" name="Wuala" id="wualaApplet">');	
	document.writeln('<param name="path" value="' + wualaPath + '" />');
	document.writeln('<param name="lang" value="' + lang + '" />');
	document.writeln('<param name="hasJVMBug" value="' + isBuggyJVM + '" />');
	document.writeln('<param name="useTestVersion" value="' + useTestVersion + '" />');
	document.writeln('<param name="useTrunkVersion" value="' + useTrunkVersion + '" />');
	document.writeln('<param name="promocode" value="' + promocode + '" />');
	document.writeln('<param name="signin" value="' + signin + '" />');
	document.writeln('<param name="register" value="' + register + '" />');
	document.writeln('</applet>');
}

var javaLoadStart = new Date();

function setLang(cLang) {
	lang = cLang;
}

function initImagePreview(element, img, width) {	
	xOffset = 10;
	yOffset = 30;
	element.hover(
		function(e) {
			this.t = this.title;
			this.title = "";	
			var c = (this.t !== "") ? "<br />" + this.t : "";
			$("body").append("<p id='previewImageContainer'><img src='" + img + "' alt='Image preview' />"+ c +"</p>");								 
			$("#previewImageContainer").css("top",(e.pageY - xOffset - 200) + "px");
			$("#previewImageContainer").css("left",(e.pageX + yOffset) + "px");
			$("#previewImageContainer").css("z-index", "99");
			$("#previewImageContainer").css("width", width + "px");
			$("#previewImageContainer").fadeIn("fast");						
		},
		function(){
			this.title = this.t;	
			$("#previewImageContainer").remove();
	    }
	);
	element.mousemove(function(e) {
		$("#previewImageContainer").css("top",(e.pageY - xOffset - 200) + "px");
		$("#previewImageContainer").css("left",(e.pageX + yOffset) + "px");
	});	
	
}

function toggleAccountOptions(active) {
	if (active == 'register') {
		register = true;
		signin = false;
	} else if (active == 'signin') {
		signin = true;
		register = false;
	}
}

/****************/
/** Wuala FAQs **/
/****************/

function toggleFAQ(on){
	var target = $('#faq_' + on);
	$('#faq_categories > ul').each(function() {

		if ($(this).attr('id') == 'faq_' + on) {
			target.css({'display' : 'block'});
		} else {
			$(this).css({'display' : 'none'});
		}
	});
	$('#faq_categories > img').each(function() {
		if ($(this).attr('id') == 'faq_img_' + on) {
			$(this).attr('src', '/img/icons/bullet_down.png');
		} else {
			$(this).attr('src', '/img/icons/bullet_go.png');
		}
	});
}

function handleFAQSearchText(default_text) {
	if ($('#q').val() == default_text) {
		$('#q').attr('value', '');
	}
}


function markFAQEntry(hash) {
	$('#faq_entries > p').each(function() {
		$(this).css({'background' : 'transparent'});
	});
	
	hash = hash.substring(1);
	var a = $('#p_' + hash);
	if (a !== null) {
		a.css({'backgroundColor' : '#ffffcc'});
	}
}
