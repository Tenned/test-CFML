<cfcomponent output="false">
	<!---validateUser() Подтверждение данных от пользователя--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userLogin" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<cfset var aErrorMessages = ArrayNew(1) />
		<!---Проверка на пустой логин---->
		<cfif arguments.userLogin EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите логин') />
		</cfif>
		<!---Проверка на пустой пароль---->
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите пароль') />
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---doLogin() вход--->
	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userLogin" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<!--- isUserLoggedIn = false пользователя еще не вошел--->
		<cfset var isUserLoggedIn = false />
		<!---Достаем пользователя из базы данных--->
		<cfquery name="rsLoginUser">
			SELECT login, name, lastname, password
			FROM dbo.UserTable 
			WHERE login = <cfqueryparam value="#arguments.userLogin#" /> 
			AND password = <cfqueryparam value="#arguments.userPassword#" /> 
		</cfquery>
		<!---Проверяем что такой пользователь всего один--->
		<cfif rsLoginUser.recordCount EQ 1>
			<!---Авторизовать пользователя--->
			<cflogin >
				<cfloginuser name="#rsLoginUser.login#" password="#rsLoginUser.password#" roles="default" >
			</cflogin>
			<!---Сохраненяем пользователя в данной сесии --->
			<cfset session.stLoggedInUser = {'userFirstName' = rsLoginUser.name, 'userLastName' = rsLoginUser.lastname, 'userLogin' = rsLoginUser.login, 'userPassword' = rsLoginUser.password} />
			<!---isUserLoggedIn = true пользователя теперь вошел --->
			<cfset var isUserLoggedIn = true />
		</cfif>
		<!---Возвращаем  isUserLoggedIn --->
		<cfreturn isUserLoggedIn />
	</cffunction>
	<!---doLogout() выход--->
	<cffunction name="doLogout" access="public" output="false" returntype="void">
		<!---Удаляем пользователя в данной сесии--->
		<cfset structdelete(session,'stLoggedInUser') />
		<!---Выходим--->
		<cflogout />
	</cffunction>

</cfcomponent>