<html>
  <head>
    <meta name="layout" content="main" />
</head>
<body>
  <div class="box">
    <div class="header">
      <img src="<g:resource dir='images' file='forms_icon.png' />" alt="" width="30" height="30" />
      <g:message code="user.editprofile.title"/>
    </div>
    <div class="body">
      <div class="clearfix">
        <g:hasErrors bean="${userInstance}">
          <div class="error">
            <g:renderErrors bean="${userInstance}" as="list" />
          </div>
        </g:hasErrors>
        <g:form action="updateProfile" name="updateProfile">
          <fieldset>
            <legend><g:message code="user.profile.legend"/></legend>
            <p>
              <label><g:message code="user.fullname"/></label>
              <input name="fullname" type="text" required="required" class="textfield ${hasErrors(bean:userInstance,field:'fullname','error')}" value="${userInstance?.fullname}"/>
            </p>    
            
            <p>
              <label><g:message code="user.email"/></label>
              <input name="email" type="text" required="required" class="textfield ${hasErrors(bean:userInstance,field:'email','error')}" value="${userInstance?.email}"/>
            </p>

            <p>
              <label><g:message code="user.old_password"/></label>
              <input name="old_password" type="password" class="textfield"/>
              <small><g:message code="user.old_password.tips"/></small>
            </p>
          
            <p>
              <label><g:message code="user.new_password"/></label>
              <input name="new_password" type="password" class="textfield"/>
            </p>
            
            <p>
              <label><g:message code="user.new_password_confirm"/></label>
              <input name="new_password_confirm" type="password" class="textfield"/>
            </p>
                        
            <p>
              <input name="submitButton" type="submit" class="button2" id="button2" value="Submit" />
              <input name="cancelButton" type="reset" class="button" id="button" value="Cancel" />
            </p>
            
          </fieldset>          
        </g:form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    $(document).ready(function(){   	  
      $("#behavior_create").validator({
        lang: 'th'
      });      
    });
  </script>
</body>
</html>