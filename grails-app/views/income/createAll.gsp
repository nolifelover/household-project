<html>
  <head>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='forms_icon.png' />" alt="" width="30" height="30" />
        <g:message code="account.create.title"/>
      </div>
      <div class="body">
        <div class="clearfix">
          <g:form action="saveAll" name="transaction_create">
            <fieldset>
              <legend><g:message code="transaction.account"/></legend>
              <p>
                <label><g:message code="account.code"/></label>
                <input name="code" type="text" required="required" value="${accountCode}" class="textfield med"/>
                <small><g:message code="account.code.tips"/></small></p>
              <p>
              <p>
                <label><g:message code="transaction.month"/></label>
                <input name="month" type="text" required="required" value="${month}" class="textfield short"/>
              <p>
              <div id="income-left" style="width: 470px; float: left;">
                <h3 class="cufon"> ${message(code: "income.create.income")}</h3>
                <g:each in="${incomeInstances}" status="i" var="incomeInstance">
                  <g:set var="categories" value="${incomeInstance.sortCategories}" />
                  <g:if test="${categories.size() == 1}">
                    <p style="padding-left: 10px;">
                      <label>${i+1}.${incomeInstance?.name}</label>
                      <input name="category_${categories[0].id}" type="text" value="" class="textfield short"/>
                    <p>
                  </g:if>
                  <g:else>
                    <p style="padding-left: 10px;">
                      <label>${i+1}.${incomeInstance?.name}</label>
                    </p>
                    <g:each in="${categories}" status="c" var="category">
                      <p style="padding-left: 30px;">
                        <label>${i+1}.${c} ${category?.name}</label>
                        <input name="category_${category.id}" type="text" value="" class="textfield short"/>
                      <p>
                    </g:each>
                  </g:else>
                </g:each>
              </div>
              <div id="income-right" style="width: 470px; float: left;">
              <h3 class="cufon"> ${message(code: "income.create.outcome")}</h3>     
                <g:each in="${outcomeInstances}" status="i" var="outcomeInstance">
                  <g:set var="categories" value="${outcomeInstance.sortCategories}" />
                  <g:if test="${categories.size() == 1}">
                    <p style="padding-left: 10px;">
                      <label>${i+1}.${outcomeInstance?.name}</label>
                      <input name="category_${categories[0].id}" type="text" value="" class="textfield short"/>
                    <p>
                  </g:if>
                  <g:else>
                    <p style="padding-left: 10px;">
                      <label>${i+1}.${outcomeInstance?.name}</label>
                    </p>
                    <g:each in="${categories}" status="c" var="category">
                      <p style="padding-left: 30px;">
                        <label>${i+1}.${c+1} ${category?.name}</label>
                        <input name="category_${category.id}" type="text" value="" class="textfield short"/>
                      <p>
                    </g:each>
                  </g:else>
                </g:each>
              </div>
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