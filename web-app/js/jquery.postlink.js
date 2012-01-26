(function($){
    $.fn.postlink = function(options) {
        var defaults = {
            enabled: true,
            debug: true
        };

        var options = $.extend(defaults, options);

        return this.each(function() {
            $obj = $(this);
            if ( $obj[0].tagName != "A") {
                alert("Cannot use postlink plugin on non 'A' elements");
            }
            $obj.click(function(clickEvent) {
                clickEvent.preventDefault();
                var $link=$(this);
                var href=$link.attr("href");
                if ( ! isValidPostLink(href) ) {
                    alert("postlink plugin: Link does not contain a valid href (must contain a ?)");
                }
                console.info("Clicked " + href);
                var hrefObj = parseLink(href);
                var answer =  confirm('คุณแน่ใจหรือที่จะดำเนินการต่อ');
                if(answer == true){
                	 var $linkForm = createPostForm(hrefObj);
                     $('body').append($linkForm);
                     $linkForm.submit();
                     console.info("Click Complete");
                }              
            });
        });
        function isValidPostLink(linkHref) {
        	/*
            var hrefRegex = /\?/; //Link should contain a ?
            var returnBool = false;
            if ( linkHref.match( hrefRegex) ) {
                    returnBool = true;
            }
            return returnBool;
            */
        	return true;
        }
        function createPostForm(hrefObj) {
            var linkForm = document.createElement("form");
            $linkForm = $(linkForm);
            if (hrefObj.url && hrefObj.url.length > 0) {
                $linkForm.attr("action", hrefObj.url);
            }
            $linkForm.attr("method", "post");
            var thisDate = new Date();
            $linkForm.attr("id", "postlinkForm_" + thisDate.getTime());
            var counter=0;
            for (var parmKey in hrefObj.keyPairs) {
                var input = document.createElement("input");
                var $input = $(input);
                $input.attr("id", "postlink_hidden_" + parmKey + counter + "_input");
                $input.attr("type", "hidden");
                $input.attr("name", parmKey);
                $input.attr("value", hrefObj.keyPairs[parmKey]);
                $linkForm.append($input);
            }
            return $linkForm;
        }

        function parseLink(linkHref) {
            var hrefObj = {
                url: null,
                keyPairs: {}
            };
            var urlParts = linkHref.split('?');
            if (urlParts[0] !== "" || urlParts[0] > 0) {
                hrefObj.url = urlParts[0];
            }
            if(urlParts.length > 1){
            	var queryString = urlParts[1];
                var hrefKeyPairs = queryString.split('&');
                while (hrefKeyPairs.length > 0) {
                    var keyPair = hrefKeyPairs.shift().split('=');
                    hrefObj.keyPairs[keyPair[0]] = keyPair[1];
                }
            }
            
            return hrefObj;
        }
    };
})(jQuery);