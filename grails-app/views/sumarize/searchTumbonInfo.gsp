<div id="content">
  <div class="clearfix">
    <table cellpadding="0" cellspacing="0" border="0" class="nopage display">
      <thead>
        <tr>
          <th><g:message code="account.tumbon"/></th>
      <th><g:message code="account.district"/></th>
      <th><g:message code="account.province"/></th>
      <th width="20%"><g:message code="common.remark"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${tumbonInstances}" status="i" var="tumbonInstance">
        <tr class="gradeA ${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link controller="sumarize" action="tumbonAll" params="${[tumbon: tumbonInstance.tumbon, district: tumbonInstance.district, province: tumbonInstance.province]}">${tumbonInstance.tumbon}</g:link></td>
          <td>${tumbonInstance.district}</td>
          <td>${tumbonInstance.province}</td>
          <td><g:link controller="sumarize" action="tumbonAll" params="${[tumbon: tumbonInstance.tumbon, district: tumbonInstance.district, province: tumbonInstance.province]}"><g:message code="tumbon.search.detail"/></g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
</div>
