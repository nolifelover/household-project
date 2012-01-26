<html>
  <head>
    <meta name="layout" content="main" />
</head>
<body>
  <div class="box">
    <div class="header">
      <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
      <g:message code="account.search.title"/>
    </div>
    <div class="body">
      <div class="clearfix">
        <g:form action="searchInfo" name="search_info">
          <fieldset>
            <legend><g:message code="account.search.title.legend"/></legend>
            <p>
              <label><g:message code="account.search.fieldsearch"/></label>
              <input name="query" id="query" type="text" required="required" class="textfield med"/> <input name="ajax_info" type="submit" class="button2" id="button2" value="Submit" />
            </p>
            <div id="indiator" style="display: none"><img src="<g:resource dir='images' file='indicator.gif' />" alt=""/></div>
            <div id="info_result"></div>                        
          </fieldset>          
        </g:form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    $(document).ready(function(){
      $('#search_info').submit(function(event){
    	  $("#indiator").show();    	  
    	  event.preventDefault();
	      var $form = $( this ),
	      	query = $form.find( 'input[name="query"]' ).val(),
	      	url = $form.attr( 'action' );
	      $.post( url, { q: query } ,
	    	      function( data ) {
	    	          var content = $( data ).find( '#content' );
	    	          $( "#info_result" ).html( data );
	    	          $( "#indiator" ).hide();
	    	      }
	   	  )
      });
    });
  </script>
</body>
</html>