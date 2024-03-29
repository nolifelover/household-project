<html>
  <head>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="box">
      <div class="header">
        <img src="<g:resource dir='images' file='tables_icon.png' />" alt="" width="30" height="30" />
        <g:message code="doCompare.title" args="${[displayCategory]}"/>
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
          <div id="container" style="width: 100%; height: 250px"></div>
          <table cellpadding="0" cellspacing="0" border="0" class="nopage display">
            <thead>
              <tr>
                <th width="70%"><g:message code="account.history.month"/></th>
                <th><g:message code="doCompare.amount"/></th>
                <th><g:message code="common.remark"/></th>
              </tr>
            </thead>
            <tbody>
            <g:each in="${histories}" status="i" var="history">
              <tr class="gradeA ${(i % 2) == 0 ? 'odd' : 'even'}">
                <td>${history.displayMonth}</td>
                <td>${history.amount}</td>
                <td></td>
              </tr>
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
               renderTo: 'container',
               defaultSeriesType: 'line',
               marginRight: 130,
               marginBottom: 25
            },
            title: {
               text: '${message(code:"chart.sum.title")}',
               x: -20 //center
            },
            subtitle: {
               text: '${message(code:"chart.sum.subtitle")}',
               x: -20
            },
            xAxis: {
               categories: ${histories.displayMonth}
            },
            yAxis: {
               title: {
                  text: '${message(code:"unit.price")}'
               },
               plotLines: [{
                  value: 0,
                  width: 1,
                  color: '#808080'
               }]
            },
            tooltip: {
               formatter: function() {
                         return '<b>'+ this.series.name +'</b><br/>'+
                     this.x +': '+ this.y +' ${message(code:"unit.baht")}';
               }
            },
            legend: {
               layout: 'vertical',
               align: 'right',
               verticalAlign: 'top',
               x: -10,
               y: 100,
               borderWidth: 0
            },
            series: [{
               name: '${message(code:"doCompare.amount")}',
               data: ${histories.amount}
            }]
         });


      });
      
    </script>
  </body>
</html>
