<html>
  <head>
    <meta name="layout" content="main" />
</head>
<body>
  <div class="box">
    <div class="header">
      <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
      <g:message code="tumbon.search.title"/>
    </div>
    <div class="body">
      <div class="clearfix">
        <g:form action="searchTumbonInfo" name="search_tumbon">
          <fieldset>
              <legend><g:message code="tumbon.search.title.legend"/></legend>
              <p>
                <label><g:message code="account.province"/></label>
                <input name="province" id="province" type="text" class="textfield med"/> 
              </p>
              <p>
                <label><g:message code="account.district"/></label>
                <input name="district" id="district" type="text" class="textfield med"/> 
              </p>
              <input name="ajax_info" type="submit" class="button2" id="button2" value="Submit" />
              <div id="indiator" style="display: none"><img src="<g:resource dir='images' file='indicator.gif' />" alt=""/></div>
              <div id="info_result"></div>                        
            </fieldset>             
        </g:form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    $(document).ready(function(){
      $('#search_tumbon').submit(function(event){
    	  $("#indiator").show();    	  
    	  event.preventDefault();
	  var $form = $( this );
	  url = $form.attr( 'action' );
	  $.post( url, $("#search_tumbon").serialize(),
	        function( data ) {
	           var content = $( data ).find( '#content' );
	           $( "#info_result" ).html( data );
	            $( "#indiator" ).hide();
	        }
	  )
      });
    });
  </script>
  <g:render template="sidebar"/>
</body>
</html>