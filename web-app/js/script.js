$(document).ready(function(){

    //Preload images in css
    $.preloadCssImages();


    //Main Navigation
    $('#main_nav > li > ul').hide(); // Hide all subnavigation
    $('#main_nav > li > a.current').parent().children("ul").show(); // Show current subnavigation
								
    $('#main_nav > li > a[href="#"]').click( // Click!
        function() {
            $(this).parent().siblings().children("a").removeClass('current'); // Remove .current class from all tabs
            $(this).addClass('current'); // Add class .current
            $(this).parent().siblings().children("ul").fadeOut(100); // Hide all subnavigation
            $(this).parent().children("ul").fadeIn(100); // Show current subnavigation
            return false;
        }
        );

    // Jump Menu
    $('.jump_menu').hover(function(){
        $('.jump_menu_btn').toggleClass('active');
        $("ul.jump_menu_list").slideDown(200);
    }, function(){
        $('.jump_menu_btn').toggleClass('active');
        $(".jump_menu_list").hide();
    });
					
    //Close button:
    $(".close_notification").click(
        function () {
            $(this).hide();
            $(this).parent().fadeTo('fast', 0, function () {
                $(this).slideUp('fast');
            });
            return false;
        }
        );
			
    //Calendar
    $('#date').jCal({
        day:			new Date( (new Date()).setMonth( (new Date()).getMonth() + 2 ) ),
        days:			1,
        showMonths:		1,
        drawBack:		function () {
            return false;
        },
        monthSelect:	false,
        sDate:			new Date(),
        dCheck:			function (day) {
            if (day.getDay() != 6)
                return 'day';
            else
                return 'invday';
        },
        callback:function (day, days) {
            $('#calTwoDays').val( days );
            $('#calTwoResult').append('<div style="clear:both; font-size:7pt;">' + days + ' days starting ' +
                ( day.getMonth() + 1 ) + '/' + day.getDate() + '/' + day.getFullYear() + '</div>');
            return true;
        }
    });
					
					
    // Expose | Any element with a class of .expose will expose when clicked
    $(".expose").click(function() {
        // perform exposing for the clicked element
        $(this).expose({ });
							
    });

    //Modal on page load
    // select the overlay element - and "make it an overlay"
    $("#facebox").overlay({
        // custom top position
        top: 260,
        // some mask tweaks suitable for facebox-looking dialogs
        mask: {
            // you might also consider a "transparent" color for the mask
            color: '#fff',
            // load mask a little faster
            loadSpeed: 200,
            // very transparent
            opacity: 0.8
        },
        // disable this for modal dialog-type of overlays
        closeOnClick: true,
        // load it immediately after the construction
        load: true
    });
						
						
    // Modal on click
    $("a[rel]").overlay({
										
        // disable this for modal dialog-type of overlays
        closeOnClick: true,
        mask: {
            color: '#fff',
            loadSpeed: 200,
            opacity: 0.8
        }
    });
    
    //Tooltip
    $("[title]").tooltip({						 //will make a tooltip of all elements having a title property
        opacity: 0.8,
        effect: 'slide',
        predelay: 200,
        delay: 10,
        offset:[5, 0]
    })
    .dynamic({
        bottom: {
            direction: 'down',
            bounce: true
        }   //made it dynamic so it will show on bottom if there isnt space on the top
    });
						

				
    //Expandable Tables
			
    var element = ".expandable";
						
    $(element).find("tr:odd").addClass("odd");
    $(element).find("tr:not(.odd)").hide();
    $(element).find("tr:not(.odd)").addClass("grid_dropdown");
    $(element).find("tr:first-child").show();
    $("table.expandable tr.active").click(function(){
        $(this).toggleClass(".odd");
    });
						
    $(element).find("tr.odd").click(function() {
        $(this).toggleClass("active");
        $(this).next("tr").toggle();
        $(this).find(".toggle").toggleClass("collapse");
    });
						
						
						
    // Data Table
    $('.dataTable').dataTable({
    	"sDom": 'T<"clear">lfrtip',
        "bAutoWidth": false, //setting width to 100%
        "aButtons":         [ "copy", "csv", "xls", "print" ]		
    });


    // Data tables that can be exported and printed
    TableTools.DEFAULTS.sSwfPath = "/images/swf/ZeroClipboard.swf";  //path to swf
    $('.dataTable_exportable').dataTable( {
    	"sDom": 'T<"clear">lfrtip',
        "bAutoWidth": false,
    } );

    $('.nopage').dataTable({
        "sDom": 'Tlfrtip',
        "bPaginate": false,
        "bFilter": false,
        "bLengthChange": false,
        "bSort": true,
        "bInfo": false,
        "bAutoWidth": false
    });
    
    $('.nopage_nosort').dataTable({
        "sDom": 'Tlfrtip',
        "bPaginate": false,
        "bFilter": false,
        "bLengthChange": false,
        "bSort": false,
        "bInfo": false,
        "bAutoWidth": false
    });

    //Tabs in box header
    $("ul.sub_nav").tabs("div.panes > div", {
        effect: 'fade'
    });
			
    //Vertical Navigation
    $("ul.vertical_nav").tabs("div.panes_vertical > div", {
        effect: 'fade'
    });
						
    //Horizontal Tabs
    $("ul.horizontal_nav").tabs("div.panes_horizontal > div", {
        effect: 'fade'
    });
						

			
    //Accordion
    $(".accordion").tabs(".accordion div.pane", {
        tabs: 'h2',
        effect: 'slide'
    });
			
			
			
    // Create Graph using Visualize
    $('.graph').visualize({
        type: 'bar',
        width: '620px',
        height: '330px',
        colors: ['#5a88e4','#8cacc6','#2652b4', '#dddddd']
    });
    $('.graph').hide();

    //Wysiwyg
    $('.wysiwyg').wysiwyg();

    //Picker date
    $('.picker_date').AnyTime_picker({
        format: "%d/%m/%Y",
        firstDOW: 1
    });

    $(".picker_time").AnyTime_picker({
        format: "%H:%i"
    });
    
    //Captify
    $('img.captify').captify({
    	// all of these options are... optional
		// ---
		// speed of the mouseover effect
		speedOver: 'fast',
		// speed of the mouseout effect
		speedOut: 'normal',
		// how long to delay the hiding of the caption after mouseout (ms)
		hideDelay: 500,	
		// 'fade', 'slide', 'always-on'
		animation: 'slide',		
		// text/html to be placed at the beginning of every caption
		prefix: '',		
		// opacity of the caption on mouse over
		opacity: '0.7',					
		// the name of the CSS class to apply to the caption box
		className: 'caption-bottom',	
		// position of the caption (top or bottom)
		position: 'bottom',
		// caption span % of the image
		spanWidth: '100%'
    });
 	
    //Validator
    $.tools.validator.localize("th", {
        '*'                     : 'ข้อมูลไม่ถูกต้อง',
	':email'  		: 'รูปแบบอีเมลล์ไม่ถูกต้อง',
	':number' 		: 'ค่าที่กรอกต้องเป็นตัวเลข',
        ':url'                  : 'รูปแบบ url ไม่ถูกต้อง',
	'[max]'	 		: 'ค่าต้องไม่มากกว่า $1',
	'[min]'	 		: 'ค่าต้องมากกว่า $1',
	'[required]'            : 'ต้องใส่ข้อมูลเว้นว่างไม่ได้'
    });

    $.tools.validator.conf.lang = 'th';
    $.tools.validator.conf.messageClass = 'error_form'
    	
    //Convert GET to POST
    $('a.postlink').postlink();
    $('.delete').click(function(){
    	  var answer = confirm('คุณแน่ใจหรือที่ต้องการลบข้อมูลนี้');
    	  return answer // answer is a boolean
    });
    
    //Image Hover
    $('img.image_hover').fadeTo(0,0.5);
    $('img.image_hover').hover(function(){
    	 $(this).stop().fadeTo(500,1.0);
    },function(){
    	$(this).stop().fadeTo(500,0.5);
    });
    
    //Cufon
    Cufon.replace('.cufon');
    Cufon.replace('#logo-cufon');
    //Tooltip
    $(".tooltip").tooltip();
});
