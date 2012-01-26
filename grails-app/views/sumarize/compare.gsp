<html>
  <head>
    <meta name="layout" content="main" />
</head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
        <g:message code="compare.title"/>
      </div>
      <div class="body">
        <div class="clearfix">
          <div class="warning">
            <p>
              <g:if test="${isMoo}">
                <g:message code="account.moo"/> : <b>${params.moo}</b> 
              </g:if>
              <g:message code="account.tumbon"/> : <b>${params.tumbon}</b> 
              <g:message code="account.district"/> : <b>${params.district}</b> 
              <g:message code="account.province"/> : <b>${params.province}</b> 
            </p>
          </div>
          <g:form action="doCompare" name="compare">
            <fieldset>
              <legend><g:message code="compare.legend"/></legend>
              <p>
                <g:hiddenField name="moo" value="${params.moo}"/>
                <g:hiddenField name="tumbon" value="${params.tumbon}"/>
                <g:hiddenField name="district" value="${params.district}"/>
                <g:hiddenField name="province" value="${params.province}"/>
                <label><g:message code="compare.category"/></label>
                <g:select name="category"
                          from="${categories}"
                          optionKey="value"
                          optionValue="name"/>
                </p>
              <input name="ajax_info" type="submit" class="button2" id="button2" value="Submit" />                       
            </fieldset>             
          </g:form>
        </div>
      </div>
    </div>
  </body>
</html>