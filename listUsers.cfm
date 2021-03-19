<cfif NOT isUserLoggedIn()>
	<cflocation url="index.cfm?noaccess" >
</cfif>

<cfmodule template="customTags/front.cfm" title="Список ошибок">

 <cfquery datasource="CfTestCFML" name="rsAllBug">
			SELECT login, name, lastname
			FROM UserTable
</cfquery>

      <table id="center">
		<!---Вывод списка ошибок--->
			<thead>
				<tr>
					<td colspan="3">Список пользователей</td>
				</tr>
			</thead>	
						
			<tr>
				<td>Логин</td>
				<td>Фамилия</td>
				<td>Имя</td>
			</tr>				
			
		<cfoutput query="rsAllBug">
			<tr>
				<td>#login#</td>
				<td>#lastname#</td>
				<td>#name#</td>

			</tr>
		</cfoutput>
      </table>



</cfmodule>