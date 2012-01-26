<g:content tag="sidebar">
  <g:if test='${!(params.action =~ "(search|compare)")}'>
    <div class="small_box">
      <div class="header">
        <img src="<g:resource dir='images' file='accordion_icon.png'/>" alt="Menu" width="24" height="24" /><g:message code="common.menu"/>
      </div>
      <div class="body">
        <div class="clearfix">
          <ul class="bulleted_list">
            <li>
              <g:link action="compare" params="${[moo: params.moo, tumbon: params.tumbon, district: params.district, province: params.province]}"><g:message code="menu.compare"/></g:link>
            </li>
          </ul>
        </div>
        <!--Date picker applied to any div of date id-->
      </div>
    </div>
  </g:if>
</g:content>