<html>
  <head>
    <meta name="layout" content="main" />
</head>
<body>
  <div class="box">
    <div class="header">
      <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
      <g:message code="mhoo.search.title"/>
    </div>
    <div class="body">
      <div class="clearfix">
        <g:form action="searchMooInfo" name="search_moo">
          <fieldset>
              <legend><g:message code="mhoo.search.title.legend"/></legend>
              <p>
                <label><g:message code="account.province"/></label>
                <input name="province" id="province" type="text" class="textfield med"/> 
              </p>
              <p>
                <label><g:message code="account.district"/></label>
                <input name="district" id="district" type="text" class="textfield med"/> 
              </p>
              <p>
                <label><g:message code="account.tumbon"/></label>
                <input name="tumbon" id="tumbon" type="text" class="textfield med"/> 
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
      $('#search_moo').submit(function(event){
    	  $("#indiator").show();    	  
    	  event.preventDefault();
	  var $form = $( this );
	  province = $form.find( 'input[name="province"]' ).val(),
          district = $form.find( 'input[name="district"]' ).val(),
          tumbol = $form.find( 'input[name="tumbon"]' ).val(),
	  url = $form.attr( 'action' );
	  $.post( url, $("#search_moo").serialize(),
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