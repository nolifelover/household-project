<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <g:render template="/layouts/meta"/>
    <g:layoutHead />
</head>

<body id="login_page">

	<div class="wrapper content">
		<g:layoutBody />
		<!-- Flash Message-->
		<g:if test="${flash.message}">
			<div class="info">
				<img src="<g:resource dir='images' file='info_icon.png'/>"
					alt="Information" width="28" height="29" class="icon" /> <strong>Information:</strong>
				<g:message code="${flash.message}" />${flash.message}
				<a href="#" class="close_notification" title="Click to Close"><img
					src="<g:resource dir='images' file='close_icon.gif'/>" width="6"
					height="6" alt="Close" />
				</a>
			</div>
		</g:if>
	</div>
	<script type="text/javascript"> Cufon.now(); </script>
</body>
</html>