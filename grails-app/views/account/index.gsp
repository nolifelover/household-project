<html>
  <head>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
        <g:message code="account.index.title"/>
      </div>
      <div class="body">
        <div class="clearfix">
          <table cellpadding="0" cellspacing="0" border="0" class="nopage display">
            <thead>
              <tr>
                <th width="60"><g:message code="account.code"/></th>
                <th><g:message code="account.householder"/></th>
                <th><g:message code="account.familyNumber"/></th>
                <th><g:message code="account.province"/></th>
                <th><g:message code="account.district"/></th>
                <th width="20%"><g:message code="common.remark"/></th>
              </tr>
            </thead>
            <tbody>
            <g:each in="${accountsInstances}" status="i" var="accountInstance">
              <tr class="gradeA ${(i % 2) == 0 ? 'odd' : 'even'}">
                <td class="data_order"><g:link controller="account" action="code" params="${[id: accountInstance.code]}">${accountInstance.code}</g:link></td>
                <td>${accountInstance.householder}</td>
                <td>${accountInstance.familyNumber}</td>
                <td>${accountInstance.province}</td>
                <td>${accountInstance.district}</td>
                <td><g:link controller="account" action="code" params="${[id: accountInstance.code]}"><g:message code="income.show"/></g:link> | <g:link controller="account" action="edit" params="${[id: accountInstance.code]}"><g:message code="account.edit.label"/></g:link> | <g:link controller="income" action="createAll" params="${[code: accountInstance.code]}">${message(code:"income.create")}</g:link></td>
              </tr>
            </g:each>
            </tbody>
          </table>
          <div class="pagination clearfix">
            <g:paginate total="${accountTotalInstance}" />
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
