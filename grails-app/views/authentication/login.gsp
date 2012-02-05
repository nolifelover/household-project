<html>
<head>
<meta name="layout" content="login" />
<title><g:message code="authentication.login.title" />
</title>
</head>

<body>
	<div class="box box-login">
		<!--Begin Login Header-->
		<div class="header">
			<p>
				<img src="<g:resource dir='images' file='half_width_icon.png' />"
					alt="" width="30" height="30" /><g:message code="authentication.login.title"/>
			</p>
		</div>
		<!--End Login Header-->
		<div class="body">
			<form action='doLogin' method='POST' id='loginForm'>
				<p>
					<label><g:message code="user.username"/></label> <input name="username" type="text"
						class="textfield large" id="textfield" />
				</p>
				<p>
					<label><g:message code="user.password"/></label> <input name="password" type="password"
						class="textfield large" id="textfield2" />
				</p>
				<p>
					<input name="button2" type="submit" class="button2" value="Login" />
				</p>
			</form>
		</div>
	</div>
	
</body>
</html>