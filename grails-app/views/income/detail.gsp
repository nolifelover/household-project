<html>
  <head>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
        <g:message code="income.detail.title"/> ${displayMonth} <g:link controller="account" action="code" params="${[id: accountInstance.code]}">(${accountInstance.code} - ${accountInstance.householder}) </g:link>
      </div>
      <div class="body">
        <div class="clearfix">
          <div class="warning">
            <p>
              <g:message code="account.moo"/> : <b>${accountInstance.moo}</b> 
              <g:message code="account.tumbon"/> : <b>${accountInstance.tumbon}</b> 
              <g:message code="account.district"/> : <b>${accountInstance.district}</b> 
              <g:message code="account.province"/> : <b>${accountInstance.province}</b> 
            </p>
          </div>
          <div id="container_income" style="width: 45%; height: 250px; float: left;"></div>
          <div id="container_outcome" style="width: 45%; height: 250px; float: right;"></div>
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
                      <td style="text-align: right">${values."$index"}</td>
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
                        <td style="text-align: right">${values."$category.id"}</td>
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
                      <td style="text-align: right">${values."$index"}</td>
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
                        <td style="text-align: right">${values."$category.id"}</td>
                        <td></td>
                      </tr>
                    </g:each>
                  </g:else>
                </g:each>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      var chart;
      $(document).ready(function() {
         chart = new Highcharts.Chart({
            chart: {
               renderTo: 'container_income',
               plotBackgroundColor: null,
               plotBorderWidth: null,
               plotShadow: false
            },
            title: {
               text: '${message(code:"chart.detail.income.title")}'
            },
            tooltip: {
               formatter: function() {
                  return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %';
               }
            },
            plotOptions: {
               pie: {
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                     enabled: false,
                     formatter: function() {
                        return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %';
                     }
                  },
                  showInLegend: false
               }
            },
             series: [{
               type: 'pie',
               name: 'Income share',
               data: ${pieIncome}
            }]
         });
         
         chart = new Highcharts.Chart({
            chart: {
               renderTo: 'container_outcome',
               plotBackgroundColor: null,
               plotBorderWidth: null,
               plotShadow: false
            },
            title: {
               text: '${message(code:"chart.detail.outcome.title")}'
            },
            tooltip: {
               formatter: function() {
                  return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %';
               }
            },
            plotOptions: {
               pie: {
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                     enabled: false,
                     formatter: function() {
                        return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %';
                     }
                  },
                  showInLegend: false
               }
            },
             series: [{
               type: 'pie',
               name: 'Outcome Share',
               data: ${pieOutcome}
            }]
         });
      });
      
    </script>
  </body>
</html>
