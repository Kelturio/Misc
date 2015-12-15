/*jshint forin:true, noarg:true, noempty:true, eqeqeq:true, evil:true, bitwise:true, strict:true, undef:true, curly:true, browser:true, indent:4, maxerr:50 */
/*globals $, window, Wuala, wualaHttpLoader*/

$(function () {
	"use strict";
	var $socialshareprivacy = $('#socialshareprivacy'),
		$fancybox = $('a.fancybox'),
		getHost = function (url) {
			return url.match(/(https?:\/\/.[^\/]+)/)[1];
		},
		localWualaUrl = 'http://127.0.0.1:' + Wuala.getStatusServerPort(),
		getSecretKey = function (sep) {
			var key = Wuala.getSecretKey();
			if (key !== '') {
				key = sep + 'key=' + key;
			}
			return key;
		},
		launch_fallback = function (url) {
			document.location.href = '/' + Wuala.getLang() + '/launch?wualaPath=' + url + getSecretKey('&');
		},
		launch = function (url) {
			url += getSecretKey('&'); 
			if (window.location.protocol === 'https:') {
				if (!$.browser.msie && Wuala.getSecretKey() !== '') {
					launch_fallback(url);
				} else {
					document.location.href = window.location.protocol + "//" + window.location.hostname + "/launch/running?wualaPath=" + url + "&protocol=https&lang=" + Wuala.getLang();
					setTimeout(function () {launch_fallback(url); }, 1000);
				}
			} else {
				if (wualaHttpLoader) {
					$('<iframe style="display:none" src="http://127.0.0.1:' + Wuala.getStatusServerPort() + '/launch?wualaPath=' + url + '"></iframe>').appendTo('body');
				} else {
					launch_fallback(url);
				}
			}
		};
	
	//Add a script that will tell us if wuala is up and running
	if (window.location.protocol === 'http:') {
		$('body').append('<script type="text/javascript" src="' + localWualaUrl + '/js/wualaHttpLoader.js"></script>')
			.append('<script type="text/javascript" src="' + localWualaUrl + '/wualaHttpLoader.js"></script>');
	}
		
	// user can click the whole div element
	$("div.item-container").click(function (event) {
		var $a = $(this).children().next('div.item-name').children('a'),
			$target = $(event.target);

		if ($target.is('img') && $target.attr('longdesc') === 'single-view') {
			return true;
		} else if ($target.is('img') && $target.attr('longdesc') === 'download') {
			return true;
		} else if ($target.is('a.DL_1') || $target.is('a.info_2')) { //is the download or info link
			return true;
		} else {
			if ($a.attr('href') !== 'undefined') {
				if (event.metaKey || event.ctrlKey) {
					window.open($a.attr("href"));
				} else {
					window.location = $a.attr("href");
				}
				event.preventDefault();
			}
		}
	});

	$fancybox.click(function () {
		var clickedElem = $(this).attr('href'),
			idx = 0, 
			pos = idx,
			data = $fancybox.map(function () {
				var $this = $(this),
					href = $this.attr('href'),
					imgsrc = $this.find('img').attr('src'),
					startUrl = getHost(imgsrc),
					previewUrl = getHost(imgsrc) + '/previewImage' + href;

				if (href === clickedElem) {
					pos = idx;
				}
				idx++;				
				return {
					//'href': '/en/api/preview' + href,
					'href': previewUrl,
					'title': $this.attr('title')
				};
			}).get();
		
		$.fancybox(data, {'imageScale': true,
			'overlayShow': true,
			'opacity': true,
			'hideOnOverlayClick': true,
			'centerOnScroll': true,
			'overlayColor': '#000000',
			'overlayOpacity': 0.8,
			'transitionIn': 'elastic',
			'transitionOut': 'elastic',
			'titlePosition': 'inside',
			'index': pos,
			'titleFormat': function (titleStr, currentArray, currentIndex, current) {
				//console.debug(titleStr, currentArray, currentIndex, current);
				var href = current.href,
					ishttps = href.indexOf('https://') === 0,
					hostWithRootPath = getHost(href) + '/previewImage',
					pathWithQuery = href.substring(hostWithRootPath.length),
					downloadurl = 'http' + (ishttps ? 's' : '') + '://content.wuala.com/contents' + pathWithQuery.replace('dl=0&', '') + '&dl=1',
					path = pathWithQuery.substring(0, pathWithQuery.indexOf('?')),
					key = Wuala.getSecretKey(),
					footer = '<a href="' + downloadurl + '" style="text-decoration: underline;">';

				footer += '<img alt="" style="margin-bottom: -2px" src="/img/icons/DL_1.png" /> ';
				footer += titleStr;
				footer += '</a>';
				footer += '<div style="margin-top: 5px;">';
				if (key) {
					path += '?key=' + key;
				}
				footer += '<a class="openInWuala" href="' + path + '" style="text-decoration: underline;">';
				footer += '<img src="/img/wuala_icon.png" alt="" style="margin-bottom: -2px" /> ' + Wuala.translations['open.view.helper.openInWuala'];
				footer += '</a>';
				footer += '</div>';
				return footer;
			}
		});
		return false;
	});
	
	$('a.openInWuala').live('click', function () {
		launch($(this).attr('href'));
		return false;
	});
	
	//Init the social share privacy if any:
	if ($socialshareprivacy.length > 0) {
		var settings = {
			'cookie_domain': 'wuala.com',
			'txt_help': 'If you activate these buttons, your data is transmitted to Facebook, Twitter or Google in the US and may be stored there. For further information press <em>i</em>.',
			'settings_perma': 'Permanently enable and agree to the data transmission:',
			'css_path': '/css/socialshareprivacy.css',
			services: {
				facebook : {
					'app_id': '282012448490836',
					'dummy_img': '/img/socialshareprivacy/dummy_facebook_en.png',
					'txt_info': 'If you flip the switch, the Facebook Button will activate, making it possible to send your recommendation to Facebook. Your data is transmitted already by just activating the Button. See <em>i</em>.',
                    'txt_fb_off': 'not connected with Facebook',
                    'txt_fb_on': 'connected with Facebook',
                    'display_name': 'Facebook',
                    'language': Wuala.getLocale()
				}, 
				twitter : {
					'dummy_img': '/img/socialshareprivacy/dummy_twitter.png',
                    'txt_info': 'If you flip the switch, the Twitter Button will activate, making it possible to send your recommendation to Twitter. Your data is transmitted already by just activating the Button. See <em>i</em>.',
                    'txt_twitter_off': 'not connected with Twitter',
                    'txt_twitter_on': 'connected with Twitter'
				},
				gplus : {
					'dummy_img': '/img/socialshareprivacy/dummy_gplus.png',
                    'txt_info': 'If you flip the switch, the Google+ Button will activate, making it possible to send your recommendation to Google. Your data is transmitted already by just activating the Button. See <em>i</em>.',
                    'txt_gplus_off': 'not connected with Google+',
                    'txt_plus_on': 'connected with Google+',
                    'language': Wuala.getLocale()
				}
			}
		};
		if (Wuala.getLang() === 'de') {
			settings.services = {
				facebook : {
					'app_id': '282012448490836',
					'dummy_img': '/img/socialshareprivacy/dummy_facebook.png',
                    'language': Wuala.getLocale()
				}, 
				twitter : {
					'dummy_img': '/img/socialshareprivacy/dummy_twitter.png'
				},
				gplus : {
					'dummy_img': '/img/socialshareprivacy/dummy_gplus.png',
                    'language': Wuala.getLocale()
				}
			};
		}
		$socialshareprivacy.socialSharePrivacy(settings); 
	}
});