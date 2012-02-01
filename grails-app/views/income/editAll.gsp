<html>
  <head>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
        <g:message code="income.edit.title"/>
      </div>
      <div class="body">
        <div class="clearfix">
          <g:form action="updateAll" name="transaction_create">
            <fieldset>
              <legend><g:message code="transaction.account"/></legend>
              <p>
                <label><g:message code="account.code"/></label>
                <input name="code" type="text" required="required" value="${accountCode}" class="textfield med" readonly="true"/>
                <small><g:message code="account.code.tips"/></small></p>
              <p>
              <p>
                <label><g:message code="transaction.month"/></label>
                <input name="month" type="text" required="required" value="${month}" class="textfield short" readonly="true"/>
              <p>
              <div style="clear: both;"></div>
              <h3 class="cufon"> ${message(code: "income.create.income")}</h3>
              <table cellpadding="0" cellspacing="0" border="0" class="display">
                <thead>
                  <tr>
                    <th width="70%"><g:message code="income.name"/></th>
                    <th width="10%"><g:message code="income.amount"/></th>
                    <th width="20%"><g:message code="common.remark"/></th>
                  </tr>
                </thead>
                <tbody>           
                    <g:each in="${incomeInstances}" status="i" var="incomeInstance">
                      <g:set var="categories" value="${incomeInstance.sortCategories}" />
                      <g:if test="${categories.size() == 1}">
                        <g:set var="index" value="${categories[0].id}" />
                        <tr>
                          <td>${i+1}.${incomeInstance?.name}</td>
                          <td style="text-align: right"><input name="category_${categories[0].id}" type="text" value="${values."$index"}" class="textfield short"/></td>
                          <td></td>
                        </tr>
                      </g:if>
                      <g:else>
                        <tr>
                          <td>${i+1}.${incomeInstance?.name}</td>
                          <td colspan="2"></td>
                        </tr>
                        <g:each in="${categories}" status="c" var="category">
                          <tr>
                            <td style="padding-left: 30px;">${i+1}.${c+1} ${category?.name}</td>
                            <td style="text-align: right"><input name="category_${category.id}" type="text" value="${values."$category.id"}" class="textfield short"/></td>
                            <td></td>
                          </tr>
                        </g:each>
                      </g:else>
                    </g:each>
                </tbody>
              </table>
              <h3 class="cufon"> ${message(code: "income.create.outcome")}</h3>
              <table cellpadding="0" cellspacing="0" border="0" class="display">
                <thead>
                  <tr>
                    <th width="70%"><g:message code="income.name"/></th>
                    <th width="10%"><g:message code="income.amount"/></th>
                    <th width="20%"><g:message code="common.remark"/></th>
                  </tr>
                </thead>
                <tbody>           
                    <g:each in="${outcomeInstances}" status="i" var="incomeInstance">
                      <g:set var="categories" value="${incomeInstance.sortCategories}" />
                      <g:if test="${categories.size() == 1}">
                        <g:set var="index" value="${categories[0].id}" />
                        <tr>
                          <td>${i+1}.${incomeInstance?.name}</td>
                          <td style="text-align: right"><input name="category_${categories[0].id}" type="text" value="${values."$index"}" class="textfield short"/></td>
                          <td></td>
                        </tr>
                      </g:if>
                      <g:else>
                        <tr>
                          <td>${i+1}.${incomeInstance?.name}</td>
                          <td colspan="2"></td>
                        </tr>
                        <g:each in="${categories}" status="c" var="category">
                          <tr>
                            <td style="padding-left: 30px;">${i+1}.${c+1} ${category?.name}</td>
                            <td style="text-align: right"><input name="category_${category.id}" type="text" value="${values."$category.id"}" class="textfield short"/></td>
                            <td></td>
                          </tr>
                        </g:each>
                      </g:else>
                    </g:each>
                </tbody>
              </table>
            </div>
            <p>
              <input name="submitButton" type="submit" class="button2" id="button2" value="Submit" />
              <input name="cancelButton" type="reset" class="button" id="button" value="Cancel" />
            </p>
            </fieldset>          
          </g:form>
      </div>
    </div>
  </body>
</html>
