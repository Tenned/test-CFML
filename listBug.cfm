<cfif NOT isUserLoggedIn()>
	<cflocation url="index.cfm?noaccess" >
</cfif>

<cfmodule template="customTags/front.cfm" title="Список ошибок">

 <cfquery datasource="CfTestCFML" name="rsAllBug">
			SELECT id, date, shortDescription, detailedDescription, userLogin, status, urgency, criticality, name, lastname
			FROM BugTable, UserTable, CriticalityTable, StatusTable, UrgencyTable 
			WHERE BugTable.userLogin = UserTable.login
			AND idStatus = bugStatusID 
			AND idUrgency = bugUrgencyID
			AND idCriticality = bugCriticalityID 
			ORDER BY date
</cfquery>

      <table id="center">
		<!---Вывод списка ошибок--->
			<thead>
				<tr>
					<td colspan="9">Список ошибок</td>
				</tr>
			</thead>
			<tr>
				<td>Id</td>
				<td>Дата</td>
				<td>Короткое описание</td>
				<td>Подробное описание</td>
				<td>Пользователь</td>
				<td>Статус</td>
				<td>Срочность</td>
				<td>Критичность</td>
				<td></td>
			</tr>
		<cfoutput query="rsAllBug">
			<tr>
				<td>#id#</td>
				<td>#dateFormat(date, 'mmm dd yyyy')#</td>
				<td>#shortDescription#</td>
				<td>#detailedDescription#</td>
				<td>#lastname# #name#</td>
				<td>#status#</td>
				<td>#urgency#</td>
				<td>#criticality#</td>
				<td><a href="editBug.cfm?BugId=#id#">Редактировать</a></td>
			</tr>
		</cfoutput>
      </table>



</cfmodule>