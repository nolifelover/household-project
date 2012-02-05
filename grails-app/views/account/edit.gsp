<html>
  <head>
    <meta name="layout" content="main" />
</head>
<body>
  <div class="box">
    <div class="header">
      <img src="<g:resource dir='images' file='forms_icon.png' />" alt="" width="30" height="30" />
      <g:message code="account.edit.title"/>
    </div>
    <div class="body">
      <div class="clearfix">
        <g:hasErrors bean="${accountInstance}">
          <div class="error">
            <g:renderErrors bean="${accountInstance}" as="list" />
          </div>
        </g:hasErrors>
        <g:form action="update" name="behavior_create">
          <fieldset>
            <g:hiddenField name="id" value="${accountInstance.id}"/>
            <legend><g:message code="account.edit.legend"/></legend>
            <p>
              <label><g:message code="account.code"/></label>
              <input name="code" type="text" required="required" class="textfield ${hasErrors(bean:accountInstance,field:'code','error')}" value="${accountInstance?.code}"/>
              <small><g:message code="account.code.tips"/></small></p>
            <p>

            <p>
              <label><g:message code="account.familyNumber"/></label>
              <input name="familyNumber" type="text" maxlength="3" pattern="^[\-]?[0-9]{1,3}[0-9]?" class="textfield ${hasErrors(bean:accountInstance,field:'familyNumber','error')}"  value="${accountInstance?.familyNumber}"/>
              <small><g:message code="account.familyNumber.tips"/></small></p>
            <p>
          
            <p>
              <label><g:message code="account.householder"/></label>
              <input name="householder" type="text" required="required" class="textfield med ${hasErrors(bean:accountInstance,field:'householder','error')}" value="${accountInstance?.householder}"/>
              <small><g:message code="account.householder.tips"/></small></p>
            <p>
              
            <p>
              <label><g:message code="account.moo"/></label>
              <input name="moo" type="text" maxlength="3" pattern="^[\-]?[0-9]{1,3}[0-9]?" class="textfield ${hasErrors(bean:accountInstance,field:'moo','error')}"  value="${accountInstance?.moo}"/>
            <p>
              
            <p>
              <label><g:message code="account.tumbon"/></label>
              <input name="tumbon" type="text" required="required" class="textfield med ${hasErrors(bean:accountInstance,field:'tumbon','error')}" value="${accountInstance?.tumbon}"/>
            <p>
              
            <p>
              <label><g:message code="account.district"/></label>
              <input name="district" type="text" required="required" class="textfield med ${hasErrors(bean:accountInstance,field:'district','error')}" value="${accountInstance?.district}"/>
            <p>
              
            <p>
              <label><g:message code="account.province"/></label>
              <input name="province" type="text" required="required" class="textfield med ${hasErrors(bean:accountInstance,field:'district','error')}" value="${accountInstance?.province}"/>
            <p>
                        
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