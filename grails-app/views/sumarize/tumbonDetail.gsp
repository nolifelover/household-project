<%@ page import="com.core.Transaction" %>
<html>
  <head>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
        <g:message code="tumbon.month.title" args="${[displayMonth, params.tumbon, params.district, params.province]}"/>
      </div>
      <div class="body">
        <div class="clearfix">
          <div id="container_income" style="width: 45%; height: 250px; float: left;"></div>
          <div id="container_outcome" style="width: 45%; height: 250px; float: right;"></div>
          <h3 class="cufon"> ${message(code: "income.create.income")}</h3>
          <table cellpadding="0" cellspacing="0" border="0" class="display">
            <thead>
              <tr>
                <th width="50%"><g:message code="income.name"/></th>
                <th width="10%"><g:message code="income.amount"/></th>
                <th width="20%"><g:message code="tumbon.detail.avg"/></th>
                <th width="20%"><g:message code="tumbon.detail.moo"/></th>
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
                      <td style="text-align: right">${avgs."$index"}</td>
                      <td style="text-align: right">${moos."$index"}</td>
                      <td></td>
                    </tr>
                  </g:if>
                  <g:else>
                    <tr>
                      <td>${i+1}.${incomeInstance?.name}</td>
                      <td colspan="3"></td>
                    </tr>
                    <g:each in="${categories}" status="c" var="category">
                      <tr>
                        <td style="padding-left: 30px;">${i+1}.${c+1} ${category?.name}</td>
                        <td style="text-align: right">${values."$category.id"}</td>
                        <td style="text-align: right">${avgs."$category.id"}</td>
                        <td style="text-align: right">${moos."$category.id"}</td>
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
                <th width="50%"><g:message code="income.name"/></th>
                <th width="10%"><g:message code="income.amount"/></th>
                <th width="20%"><g:message code="tumbon.detail.avg"/></th>
                <th width="20%"><g:message code="tumbon.detail.moo"/></th>
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
                      <td style="text-align: right">${avgs."$index"}</td>
                      <td style="text-align: right">${moos."$index"}</td>
                      <td></td>
                    </tr>
                  </g:if>
                  <g:else>
                    <tr>
                      <td>${i+1}.${incomeInstance?.name}</td>
                      <td colspan="3"></td>
                    </tr>
                    <g:each in="${categories}" status="c" var="category">
                      <tr>
                        <td style="padding-left: 30px;">${i+1}.${c+1} ${category?.name}</td>
                        <td style="text-align: right">${values."$category.id"}</td>
                        <td style="text-align: right">${avgs."$category.id"}</td>
                        <td style="text-align: right">${moos."$category.id"}</td>
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
                  showInLegend: true
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
                  showInLegend: true
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
    <g:render template="sidebar"/>
  </body>
</html>
