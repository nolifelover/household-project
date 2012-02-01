<div id="content">
  <div class="clearfix">
    <table cellpadding="0" cellspacing="0" border="0" class="nopage display">
      <thead>
        <tr>
          <th><g:message code="account.moo"/></th>
      <th><g:message code="account.tumbon"/></th>
      <th><g:message code="account.district"/></th>
      <th><g:message code="account.province"/></th>
      <th width="20%"><g:message code="common.remark"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${mooInstances}" status="i" var="mooInstance">
        <tr class="gradeA ${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link controller="sumarize" action="mooAll" params="${[moo: mooInstance.moo, tumbon: mooInstance.tumbon, district: mooInstance.district, province: mooInstance.province]}">${mooInstance.moo}</g:link></td>
          <td>${mooInstance.tumbon}</td>
          <td>${mooInstance.district}</td>
          <td>${mooInstance.province}</td>
          <td><g:link controller="sumarize" action="mooAll" params="${[moo: mooInstance.moo, tumbon: mooInstance.tumbon, district: mooInstance.district, province: mooInstance.province]}"><g:message code="moo.search.detail"/></g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
</div>
