<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <g:render template="/layouts/meta"/>
    <g:layoutHead />
  </head>
  <body>
    <!-- Header -->
    <div id="header_bg">

      <!-- Header Wrapper -->
      <div class="wrapper">

        <g:render template="/layouts/header"/> 

        <!-- Main Navigation -->
        <ul id="main_nav">
          <g:menuMain current="account" message="${message(code:'menu.account.data')}" link="#">
            <g:menuSub current="account.index" link="${createLink(controller:'account', action:'index')}">${message(code:'menu.account.data.index')}</g:menuSub>
            <g:menuSub current="account.search" link="${createLink(controller:'account', action:'search')}">${message(code:'menu.account.data.search')}</g:menuSub>
            <g:menuSub current="account.create|account.add" link="${createLink(controller:'account', action:'create')}">${message(code:'menu.account.data.create')}</g:menuSub>
            <g:menuSub current="account.code" link="#" correct="true">${message(code:'menu.account.code')}</g:menuSub>
          </g:menuMain>
          <g:menuMain current="income" message="${message(code:'menu.income.data')}" link="#">
            <g:menuSub current="income.create" link="${createLink(controller:'income', action:'createAll')}">${message(code:'menu.income.data.create')}</g:menuSub>
            <g:menuSub current="income.detail" correct="true" link="#">${message(code:'menu.income.detail')}</g:menuSub>
          </g:menuMain>
          <g:menuMain current="sumarize" message="${message(code:'menu.sum')}" link="#">
            <g:menuSub current="sumarize.searchMoo" link="${createLink(controller:'sumarize', action:'searchMoo')}">${message(code:'menu.sum.searchMoo')}</g:menuSub>
            <g:menuSub current="sumarize.mooAll"  correct="true" link="#">${message(code:'menu.sum.moo')}</g:menuSub>
            <g:menuSub current="sumarize.mooDetail" correct="true" link="#">${message(code:'menu.sum.mooDetail')}</g:menuSub>
            <g:menuSub current="sumarize.searchTumbon" link="${createLink(controller:'sumarize', action:'searchTumbon')}">${message(code:'menu.sum.searchTumbon')}</g:menuSub>
            <g:menuSub current="sumarize.tumbonAll"  correct="true" link="#">${message(code:'menu.sum.tumbon')}</g:menuSub>
            <g:menuSub current="sumarize.tumbonDetail" correct="true" link="#">${message(code:'menu.sum.tumbonDetail')}</g:menuSub>
            <g:menuSub current="sumarize.compare|sumarize.doCompare" correct="true" link="#">${message(code:'menu.compare')}</g:menuSub>
          </g:menuMain>
          <g:menuMain current="user" message="${message(code:'menu.user')}" link="#">
            <g:menuSub current="user.editProfile" link="${createLink(controller:'user', action:'editProfile')}">${message(code:'menu.user.profile')}</g:menuSub>
          </g:menuMain>
        </ul>
        <!-- End Main Navigation -->

      </div>
      <!-- End Wrapper -->
    </div>
    <!-- End Header -->

    <!-- Template Content Background -->
    <div id="content_bg" class="clearfix">
      <!-- Main Content Area -->
      <div class="content wrapper clearfix">
        <!-- Flash Message-->
        <g:if test="${flash.message}">
          <div class="${flash.css}">
            <img src="<g:resource dir='images' file='${flash.css}_icon.png'/>" alt="Information" width="28" height="29" class="icon" />
            <strong>Information:</strong> <g:message code="${flash.message}"/><a href="#" class="close_notification" title="Click to Close"><img src="<g:resource dir='images' file='close_icon.gif'/>" width="6" height="6" alt="Close" /></a>
          </div>
        </g:if>
        <!-- Sidebar -->
        <div class="sidebar">
          <!-- Sidebar Content -->
          <g:pageProperty name="page.sidebar" />
          <!-- Calendar Box -->
          <div class="small_box">
            <div class="header">
              <img src="<g:resource dir='images' file='calendar_icon.png'/>" alt="Calendar" width="24" height="24" />Calendar
            </div>
            <div class="body">
              <div id="date" class="clearfix">
              </div>
              <!--Date picker applied to any div of date id-->
            </div>
          </div>
          <!-- End Calendar Box -->
        </div>
        <!-- End Sidebar -->
        <!-- Main Column -->
        <div class="main_column">
          <g:layoutBody />
        </div>
        <!-- End Main Column -->
      </div>
      <!-- End Main Content Area -->
    </div>    
    <!-- End Template Content Background -->
    <g:render template="/layouts/footer"/>
  </body>
</html>