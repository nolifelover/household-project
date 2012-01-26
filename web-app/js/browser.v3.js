/*
The MIT License

Copyright (c) 2010 Kristopher Khoury, www.keencore.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

function ftf(){
	
	var fox 			= this;
	var output			= [];
	var is_open 		= false;
	var browser_name 	= "";
	var page_obj		= "ftf_page";
	var cookie_obj		= "ftf_popup";
	var rate_you		= 3;
	var localized = {
		"text_download" : "Download",
		"text_upgrade_now" : "Upgrade",
		"text_you" : "YOU",
		"button_continue" : "Continue Anyway",
		"button_close" : "Close",
		"text_you_are_using" : "You are using",
		"message_failed" : "It is strongly recommended that you use an alternative browser.",
		"message_acceptable" : "Not bad. Try using our other recommendations.",
		"message_recommended" : "Good choice. Stick with it.",
		"message_error" : "Sorry, something went wrong. We're fixing it.",
		"status_loading" : "Loading...", 
		"status_approved" : "Browser Approved.", 
		"status_acceptable" : "Browser Acceptable.", 
		"status_failed" : "Browser Failed.", 
		"link_check" : "Check"
	};
	var browser_info = {
		"firefox" : {
			"url" : "http://www.mozilla.com/en-US/firefox/firefox.html",
			"version" : "8.0"
		},
		"chrome" : {
			"url" : "http://www.google.com/chrome/index.html?hl=en-GB&brand=CHMA&utm_campaign=en_gb&utm_source=en_gb-ha-apac-in-bk&utm_medium=ha",
			"version" : "15.0"
		},
		"opera" : {
			"url" : "http://www.opera.com/download/",
			"version" : "11.5"
		},
		"safari" : {
			"url" : "http://www.apple.com/safari/download/",
			"version" : "5.1"
		},
		"ie" : {
			"url" : "http://www.microsoft.com/windows/internet-explorer/worldwide-sites.aspx",
			"version" : "10.0"
		}		
	};
	
	fox.rate = {
		"firefox" : 1,
		"chrome" : 1,
		"opera" : 2,
		"safari" : 1,
		"ie6" : 3,		
		"ie7" : 3,		
		"ie8" : 2	
	};
	fox.icons = {
		"firefox" : 	"icons/32/firefox.gif",
		"chrome" : 		"icons/32/chrome.gif",
		"opera" : 		"icons/32/opera.gif",
		"safari" : 		"icons/32/safari.gif",
		"ie6" : 		"icons/32/ie6.gif",		
		"ie7" : 		"icons/32/ie7.gif",		
		"ie8" : 		"icons/32/ie8.gif"	
	};

	fox.instance_name 	= "ftf";
	fox.output_to 		= "ftf_link";
	fox.css_external 	= "http://freethefoxes.googlecode.com/svn/trunk/css/latest.v3.css";
	fox.lang_external 	= "";
	fox.onload 			= true;
	
	fox.get_obj = function() {
		var elements = new Array();
		for (var i = 0; i < arguments.length; i++) {
			var element = arguments[i];
			if(typeof element == 'string'){
				element = document.getElementById(element);
			}
			if(arguments.length == 1){
				return element;
			}
			elements.push(element);
		}
		return elements;
	}
	fox.get_cookie = function(cookiename) {	
		if(document.cookie.length>0){
			cookiestart = document.cookie.indexOf(cookiename + "=");
			if (cookiestart!=-1){
				cookiestart = (cookiestart+cookiename.length+1);
				cookieend = document.cookie.indexOf(";",cookiestart);
				if(cookieend==-1){cookieend=document.cookie.length};
				return unescape(document.cookie.substring(cookiestart,cookieend));
			}
		}
		return "";
	}
	fox.set_cookie = function(cookiename,value,expiredays) {	
		if(navigator.cookieEnabled){
			var expdate=new Date();
			expdate.setDate(expdate.getDate()+expiredays);
			document.cookie = cookiename+"="+escape(value)+((expiredays==null) ? "" : ";expires="+expdate.toGMTString());
		}
	}
	fox.get_wh = function(){
		var __w = 0
		var __h = 0;
		if(typeof(window.innerWidth) == 'number'){
			__w = window.innerWidth;
			__h = window.innerHeight;
		}else if(document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)){
			__w = document.documentElement.clientWidth;
			__h = document.documentElement.clientHeight;
		}else if(document.body && (document.body.clientWidth || document.body.clientHeight)){
			__w = document.body.clientWidth;
			__h = document.body.clientHeight;
		}
		return [__w,__h];
	}
	fox.get_scroll = function(){
		var __x = 0
		var __y = 0;
		if( typeof( window.pageYOffset ) == 'number' ) {
			__y = window.pageYOffset;
			__x = window.pageXOffset;
		} else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
			__y = document.body.scrollTop;
			__x = document.body.scrollLeft;
		} else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
			__y = document.documentElement.scrollTop;
			__x = document.documentElement.scrollLeft;
		}
		return [__x,__y];
	}
	fox.check = function() {
		if(document.getElementById(page_obj) != null){
			var __h = fox.get_scroll()[1]+fox.get_wh()[1];
			document.getElementById(page_obj).style.display = "block";
			document.getElementById(page_obj).style.top = "0px";
			document.getElementById(page_obj).style.height = __h+"px";
		}
		scroll(0,0);
		is_open = true;
	}
	fox.close_modal = function() {
		document.getElementById(page_obj).style.display = "none";
		//document.body.style.overflow = "auto";
		is_open = false;
	}
	fox.continue_anyway = function() {
		fox.set_cookie(cookie_obj,'Shown',365);
		fox.close_modal();
	}
	fox.get_browser_version = function(friendly,period) {
		var version_value = "";
		
		if(/firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent.toLowerCase())){ //FIREFOX
			version_value = RegExp.$1;
		}else if(/msie (\d+\.\d+);/.test(navigator.userAgent.toLowerCase())){ //IE
			version_value = RegExp.$1;
		}else if(RegExp(" AppleWebKit/").test(navigator.userAgent)){ //SAFARI OR CHROME
			var user_agent = navigator.userAgent;
			var look_for_safari = user_agent.indexOf("Safari");
			var user_agent_part1 = user_agent.substr(0,look_for_safari);
			var look_for_last_slash = user_agent_part1.lastIndexOf("/")+1;
			var difference_of = look_for_safari-look_for_last_slash;
			var version_number = user_agent.substr(look_for_last_slash,difference_of);
			if(navigator.userAgent.toLowerCase().indexOf('chrome') > -1){
				version_value = version_number;
			}else{
				version_value = version_number;
			}		
		}else if(RegExp("Opera/").test(navigator.userAgent)){ //OPERA
			var user_agent = navigator.userAgent;
			var look_for_version = user_agent.indexOf("Version/");
			var version_number = user_agent.substr(look_for_version+8,6);
			version_value = version_number;
		}else{
			version_value = navigator.appVersion;
		}
		
		if(friendly){
			array_version = version_value.split(".");
			if(array_version.length > 1){
				version_value = array_version[0];
				if(period){
					version_value += ".";
				}
				version_value += array_version[1];
			}
		}
		return version_value;
	}
	fox.get_browser_name = function() {	
		var br="Unknown";
		if (fox.is_firefox) br= 'Firefox';
		if (fox.is_ie()) br= 'Internet Explorer';
		if (fox.is_opera()) br='Opera';
		if (fox.is_chrome()) br='Chrome';
		if (fox.is_safari()) br='Safari';
		return br;
	}
	fox.is_ie = function()			{var result=false;if(/msie (\d+\.\d+);/.test(navigator.userAgent.toLowerCase())){var ieversion=new Number(RegExp.$1);if (ieversion>0){result=true;}}return result;}
	fox.is_ie6 = function()			{var result=false;if(/msie (\d+\.\d+);/.test(navigator.userAgent.toLowerCase())){var ieversion=new Number(RegExp.$1);if(ieversion==6){result=true;}}return result;}
	fox.is_ie7 = function()			{var result=false;if(/msie (\d+\.\d+);/.test(navigator.userAgent.toLowerCase())){var ieversion=new Number(RegExp.$1);if(ieversion==7){result=true;}}return result;}
	fox.is_ie8 = function()			{var result=false;if(/msie (\d+\.\d+);/.test(navigator.userAgent.toLowerCase())){var ieversion=new Number(RegExp.$1);if(ieversion==8){result=true;}}return result;}
	fox.is_firefox = function()		{var result=false;if(/firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent.toLowerCase())){var ffversion=new Number(RegExp.$1);if(ffversion>=0){result=true;}}return result;}
	fox.is_safari = function()		{var result=false;result = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;if(/safari[\/\s](\d+\.\d+)/.test(navigator.userAgent.toLowerCase())){var oprversion=new Number(RegExp.$1);if(!result && oprversion>0){result=true;}else{result=false;}}return result;}
	fox.is_chrome = function()		{var result=false;result = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;return result;}
	fox.is_opera = function()		{var result=false;if(/opera[\/\s](\d+\.\d+)/.test(navigator.userAgent.toLowerCase())){var oprversion=new Number(RegExp.$1);if (oprversion>0){result=true;}}return result;}

	fox.css = function(){
		var css = document.createElement('link');
		css.setAttribute("href",fox.css_external);
		css.setAttribute("media","screen, projection");
		css.setAttribute("rel","stylesheet");
		css.setAttribute("type","text/css");
		document.getElementsByTagName("head")[0].appendChild(css);
	}
	fox.footer = function(){
		var ftf_link_object = document.getElementById(fox.output_to);
		
		if (ftf_link_object == null){
			var span = document.createElement('span');
			span.setAttribute("id","ftf_link");
			//span.innerHTML = localized.status_loading;
			document.body.appendChild(span);
		}else{
			ftf_link_object.innerHTML = "Loading...";
		}
	}
	fox.build = function() {
		var final_output = [];
				
		browser_name = fox.get_browser_name() + " " + fox.get_browser_version(true,true);
		
		////////////////////////////////////////////////
		Browsers = new Array();
		Browsers[Browsers.length] = fox.browser('FireFox',fox.rate.firefox,fox.icons.firefox,browser_info.firefox.url,browser_info.firefox.version,fox.is_firefox());
		Browsers[Browsers.length] = fox.browser('Chrome',fox.rate.chrome,fox.icons.chrome,browser_info.chrome.url,browser_info.chrome.version,fox.is_chrome());
		Browsers[Browsers.length] = fox.browser('Safari',fox.rate.safari,fox.icons.safari,browser_info.safari.url,browser_info.safari.version,fox.is_safari());
		Browsers[Browsers.length] = fox.browser('Opera',fox.rate.opera,fox.icons.opera,browser_info.opera.url,browser_info.opera.version,fox.is_opera());
		if(fox.is_ie6()){
			Browsers[Browsers.length] = fox.browser('IE',fox.rate.ie6,fox.icons.ie6,browser_info.ie.url,browser_info.ie.version,fox.is_ie6());
		}else if(fox.is_ie7()){
			Browsers[Browsers.length] = fox.browser('IE',fox.rate.ie7,fox.icons.ie7,browser_info.ie.url,browser_info.ie.version,fox.is_ie7());
		}else{
			Browsers[Browsers.length] = fox.browser('IE',fox.rate.ie8,fox.icons.ie8,browser_info.ie.url,browser_info.ie.version,fox.is_ie8());
		}
		
		////////////////////////////////////////////////
		var recommended_output = 	[];
		var acceptable_output = 	[];
		var failed_output = 		[];
			
		for (i=0;i<Browsers.length;i++){
			browser = Browsers[i];
			switch(rate_you){
				case 1:
					recommended_output.push(Browsers[i]);
					break;
				case 2:
					acceptable_output.push(Browsers[i]);
					break;
				case 3:
					failed_output.push(Browsers[i]);
					break;
				default:
					failed_output.push(Browsers[i]);
					break;
			}
		}
		////////////////////////////////////////////////
		
		var div_page = document.createElement('div');
		div_page.setAttribute("id","ftf_page");
		div_page.setAttribute("style","display:none;");

		final_output.push('<div id="ftf_background" onclick="'+fox.instance_name+'.close_modal()"></div>');
		final_output.push('<div id="ftf_outer">');
		final_output.push('<div id="ftf_inner" >');
		
		switch(rate_you){
			case 1:
				final_output.push('<div id="ftf_header" class="ftf_recommended">');
				final_output.push(localized.text_you_are_using + ' <span class="ftf_browser_name">' + browser_name + '</span><br />');
				final_output.push(localized.message_recommended);
				final_output.push('</div>');
				break;
			case 2:
				final_output.push('<div id="ftf_header" class="ftf_acceptable">');
				final_output.push(localized.text_you_are_using + ' <span class="ftf_browser_name">' + browser_name + '</span><br />');
				final_output.push(localized.message_acceptable);
				final_output.push('</div>');
				break;
			case 3:
				final_output.push('<div id="ftf_header" class="ftf_failed">');
				final_output.push(localized.text_you_are_using + ' <span class="ftf_browser_name">' + browser_name + '</span><br />');
				final_output.push(localized.message_failed);
				final_output.push('</div>');
				break;
			default:
				final_output.push('<div id="ftf_header" class="ftf_failed">');
				final_output.push(localized.message_error);
				final_output.push('</div>');
				break;
		}
	
		final_output.push('<div id="ftf_body_outer">');
		final_output.push('<div id="ftf_body_inner">');
		final_output.push(recommended_output.join(" "));
		final_output.push(acceptable_output.join(" "));
		final_output.push(failed_output.join(" "));
		final_output.push('</div>');
		final_output.push('</div>');
		final_output.push('<div id="ftf_footer">');
		final_output.push('<div class="ftf_left"><a href="http://www.foobarsystem.com" target=_blank>Foobarsystem.com</a></div>');
		final_output.push('<div class="ftf_right"><a href="Javascript:'+fox.instance_name+'.continue_anyway()">');
		
		////////////////////////////////////////////////
		ftf_popup_shown = fox.get_cookie(cookie_obj);
		if(ftf_popup_shown==null || ftf_popup_shown==""){
			final_output.push(localized.button_continue);
		}else{
			final_output.push(localized.button_close);
		}
		////////////////////////////////////////////////
		
		final_output.push('</a></div>');
		final_output.push('<br />');
		final_output.push('</div>');
		final_output.push('</div>');
		final_output.push('</div>');
		
		
		//FOOTER LINK
		////////////////////////////////////////////////
		var ftf_link_object = document.getElementById(fox.output_to);
		var link_output = [];
		
		switch(rate_you){
			case 1:
				link_output.push(localized.status_approved);
				break;
			case 2:
				link_output.push(localized.status_acceptable);
				break;
			case 3:
				link_output.push(localized.status_failed);
				break;
			default:
				link_output.push("FTF Error");
				break;
		}
		//link_output.push(" <a href='Javascript:"+fox.instance_name+".check();'>"+localized.link_check+"</a>");
		
		if (ftf_link_object == null){
			var div_link = document.createElement('div');
			div_link.setAttribute("id","ftf_link");
			div_link.innerHTML = localized.status_loading;
			document.body.appendChild(div_link);
		}
		//ftf_link_object.innerHTML = link_output.join(" ");
		////////////////////////////////////////////////
		
		////////////////////////////////////////////////
		
		div_page.innerHTML = final_output.join(" ");
		document.body.appendChild(div_page);

		//IF FAIL & ONLOAD
		////////////////////////////////////////////////
		if(rate_you == 3 && fox.onload){
			ftf_popup_shown = fox.get_cookie(cookie_obj);
			if(ftf_popup_shown == null || ftf_popup_shown == ""){
				fox.check();
			}
		}
		////////////////////////////////////////////////
	}
	fox.browser = function(name,rating,icon,url,version,this_you) {	
		var final_output = [];
		var class_value = "ftf_browser_link";
		
		switch(rating){
			case 1:
				class_value += " recommended";
				break;
			case 2:
				class_value += " appectable";
				break;
			case 3:
				class_value += " failed";
				break;
		}
		
		if(this_you){
			rate_you = rating;
			class_value += " you";
		}
		
		final_output.push('<a href="' + url + '" class="'+class_value+'" target="_blank" onclick="setTimeout(function(){'+fox.instance_name+'.close_modal();},1000);">');
		final_output.push('<div class="ftf_browser_icon"><img src="' + icon + '" border="0" /></div>');
		final_output.push('<div class="ftf_browser_name">' + name +'</div>');
		final_output.push('<div class="ftf_browser_version">latest v' + version + '</div>');
		
		if(this_you){
			if(Number(version) > fox.get_browser_version(true,true)){
				final_output.push('<div class="ftf_browser_download"><b>' + localized.text_upgrade_now + '</b></div>');
			}else{
				final_output.push('<div class="ftf_browser_download"><b>' + localized.text_you + '</b></div>');
			}
		}else{
			if(rating < 3){
				if(rating == 1){
					final_output.push('<div class="ftf_browser_download"><b>' + localized.text_download + '</b></div>');
				}else{
					final_output.push('<div class="ftf_browser_download">' + localized.text_download + '</div>');
				}
			}else{
				final_output.push('<div class="ftf_browser_download">&nbsp;</div>');
			}
		}
		final_output.push('</a>');
		return final_output.join(" ");
	}
	fox.init = function() {
		if(document.getElementById(fox.output_to) != null){
			var ftf_link_object = document.getElementById(fox.output_to);
			//ftf_link_object.innerHTML = localized.status_loading;
		}
			
		if(fox.lang_external.length != 0){
			fox.ajax();
			setTimeout(function(){
				fox.css();
				fox.footer();
				fox.build();
			},1000);
		}else{
			setTimeout(function(){
				fox.css();
				fox.footer();
				fox.build();
			},500);
		}
	}
	fox.ajax = function(){
		var xml = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		xml.open("get",fox.lang_external,true);
		xml.setRequestHeader("Content-Type","application/json");
		xml.onreadystatechange = function(){
			if(xml.readyState == 4){
				if(xml.status == 200){
					localized = eval( "(" + xml.responseText + ")" );
				}
			}
		};
		xml.send("");
	}
}