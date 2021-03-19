<!---Разлогиниваемся--->
<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'test CFML.components.authenticationService').doLogout() />
</cfif>



<cfparam name="attributes.title" default="Прототип системы учета ошибок," >
<cfif thistag.executionMode EQ 'start'>

<!doctype html>
<html lang="ru">
<head>
	<meta charset="utf-8" />
	<title><cfoutput>#attributes.title#</cfoutput></title>
	<link href="styles/style.css" rel="stylesheet" type='text/css' />
</head>
<body>
<div class="topnav">
	<cfif structKeyExists(session,'stLoggedInUser')>
    	<!---Мы вошли--->
    	<a class="welcomeUser" href="/test CFML/editProfile.cfm"><cfoutput>Здравствуй, #session.stLoggedInUser.userLastName# #session.stLoggedInUser.userFirstName#!</cfoutput></a>
    <cfelse>
        <!---Мы не вошли--->
  		<a class="welcomeUser" href="Registration.cfm">Регистрация</a>  
	</cfif>	

	    <!---Вход или выход--->
	<cfif structKeyExists(session,'stLoggedInUser')>
    	<!---Мы вошли--->
    	<a class="welcomeUser" href="/test CFML/index.cfm?logout"><cfoutput>Выход</cfoutput></a>
    <cfelse>
        <!---Мы не вошли--->
  		<a class="welcomeUser" href="index.cfm">Вход</a>  
	</cfif>		
	
	
	<div class="topnav-right">
		<a href="newBug.cfm">Новая ошибка</a>
		<a href="listBug.cfm">Список ошибок</a>
		<a href="listUsers.cfm">Список пользователей</a>
	</div>
</div>




  <cfelse>



</body>
</html>

</cfif>