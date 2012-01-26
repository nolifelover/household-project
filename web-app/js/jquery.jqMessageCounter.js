/* jQuery jqMessageCharCounter plugin
 * Examples and documentation at: http://www.bulksms.in.th/
 * Version: 1.0 (05/07/2010)
 * No license. Use it however you want. Just keep this notice included.
 * Requires: jQuery v1.3+
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
(function($) {

    $.fn.extend({
        jqMessageCounter: function(givenOptions) {
            return this.each(function() {
                var $this = $(this),
                options = $.extend({
                    maxUniChars:200,
                    maxAsciChars:450,
                    msgUni:70,
                    msgAsci:160,
                    msgFontSize: '12px',
                    msgFontColor: '#478BBF',
                    msgFontFamily: 'Arial',
                    msgTextAlign: 'right',
                    msgAppendMethod: 'insertAfter'
                }, givenOptions);
	
                if(options.maxChars <= 0) return;
			
                // create counter element
                var jqMessageCounterMsg = $("<div class=\"jqMessageCounterMsg\">&nbsp;</div>");
                var jqMessageCounterMsgStyle = {
                    'font-size' : options.msgFontSize,
                    'font-family' : options.msgFontFamily,
                    'color' : options.msgFontColor,
                    'text-align' : options.msgTextAlign,
                    'width' : $this.width(),
                    'opacity' : 0
                };
                var isUnicode = false;
                jqMessageCounterMsg.css(jqMessageCounterMsgStyle);
                // append counter element to DOM
                jqMessageCounterMsg[options.msgAppendMethod]($this);
			
                // bind events to this element
                $this
                .bind('keydown keyup keypress', doCount)
                .bind('focus paste', function(){setTimeout(doCount, 10);})
                .bind('blur', function(){jqMessageCounterMsg.stop().fadeTo( 'fast', 0);return false;});
			
                function doCount(){
                    var val = $this.val(),
                    length = val.length,
                    maxLength,
                    charLess,
                    maxSize,
                    totalMessage
					
                    flagUnicode(val, length);
                    if(isUnicode){
                        maxLength = options.msgUni;
                        maxSize = options.maxUniChars;
                        charLess = 3;
                    }else{
                        maxLength = options.msgAsci;
                        maxSize = options.maxAsciChars;
                        charLess = 7;
                    }
				
                    if(length >= maxSize){
                        val = val.substring(0, maxSize);
                    }
				
                    if(length > maxSize){
                        // keep scroll bar position
                        var originalScrollTopPosition = $this.scrollTop();
                        $this.val(val.substring(0, maxSize));
                        $this.scrollTop(originalScrollTopPosition);
                    }
				
                    if(length > maxLength){
                        totalMessage = Math.floor(((length - 1) / (maxLength - charLess)) + 1);
                    }else{
                        totalMessage = Math.floor(((length - 1) / (maxLength)) + 1);
                    }
				
                    jqMessageCounterMsg.html('ตัวอักษร: ' + $this.val().length + "/" + totalMessage);
                    jqMessageCounterMsg.stop().fadeTo( 'fast', 1);
                };
			
                function flagUnicode(message, length){
                    for(i=0; i<length; i++){
                        var ch = message.charCodeAt(i);
                        if(ch > 127){
                            isUnicode = true;
                            return;
                        }
                    }
                };
            });
        }
    });

})(jQuery);