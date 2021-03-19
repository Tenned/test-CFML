<cfif NOT isUserLoggedIn()>
	<cflocation url="index.cfm?noaccess" >
</cfif>

<cfmodule template="customTags/front.cfm" title="Изменение информации о ошибке">

 <cfquery datasource="CfTestCFML" name="rsAllStatus">
			SELECT idStatus, status
			FROM dbo.StatusTable
			ORDER BY idStatus 
</cfquery>

 <cfquery datasource="CfTestCFML" name="rsAllUrgency">
			SELECT idUrgency, urgency
			FROM dbo.UrgencyTable
			ORDER BY idUrgency 
</cfquery>

 <cfquery datasource="CfTestCFML" name="rsAllCriticality">
			SELECT idCriticality, criticality
			FROM dbo.CriticalityTable
			ORDER BY idCriticality 
</cfquery>

 <cfquery datasource="CfTestCFML" name="rsAllAction">
			SELECT idAction, action
			FROM dbo.ActionTable
			ORDER BY idAction 
</cfquery>

<cfif isDefined("url.BugId")>
 	<cfif structkeyexists(form,"submitForm")>
 	<!---	Забросы для изменения данных таблиц--->
		<cfquery datasource="CfTestCFML" >
			UPDATE dbo.BugTable
			SET date = CURRENT_TIMESTAMP,
				shortDescription = '#form.fld_shortDescription#',
				detailedDescription = '#form.fld_detailedDescription#',
				bugStatusID = '#form.fld_Status#',
				bugUrgencyID = '#form.fld_Urgency#',
				bugCriticalityID = '#form.fld_Criticality#',
				userLogin =  '#session.stLoggedInUser.userLogin#'
			WHERE id = #url.BugId#
		</cfquery>

		 <cfquery datasource="CfTestCFML">
					INSERT INTO dbo.BugHistoryTable
					(bugId, date, bugActionID, comment, userLogin)
					VALUES
					('#url.BugId#', CURRENT_TIMESTAMP, '#form.fld_action#', '#form.fld_comment#', '#session.stLoggedInUser.userLogin#')
		</cfquery>
	</cfif>		
		
	<!---	Заброс для отображения данных таблиц--->
	<cfquery datasource="CfTestCFML" name="BugHistoryTable">
				SELECT bugId, date, action, comment, name, lastname
				FROM BugHistoryTable, ActionTable, UserTable
				WHERE bugId = #url.BugId#
				AND userLogin = login 	
				AND idAction = bugActionID
				ORDER BY date DESC 
	</cfquery>
	
	 <cfquery datasource="CfTestCFML" name="BugToUpdate">
				SELECT shortDescription, detailedDescription, status, urgency, criticality, date, id, idstatus, name, lastname,idStatus, idUrgency, idCriticality
				FROM BugTable, CriticalityTable, StatusTable, UrgencyTable, UserTable
				WHERE id = #url.BugId#
				AND BugTable.userLogin = UserTable.login 				
				AND idStatus = bugStatusID 
				AND idUrgency = bugUrgencyID
				AND idCriticality = bugCriticalityID 
	</cfquery>

</cfif>


<div >
	<cfoutput query="BugToUpdate">
		<table>
			<thead>
				<tr>
					<td colspan="2">Информация об ошибке</td>
				</tr>
			</thead>
			<tr>
				<td>Дата изменения</td>
				<td> #BugToUpdate.date#</td>
			</tr>
			<tr>
				<td>Пользователь</td>
				<td>#lastname# #name#</td>
			</tr>
			<tr>
				<td>Статус</td>
				<td>#BugToUpdate.status#</td>
			</tr>
			<tr>
				<td>Срочность</td>
				<td>#BugToUpdate.urgency#</td>
			</tr>
			<tr>
				<td>Критичность</td>
				<td>#BugToUpdate.criticality#</td>
			</tr>
			<tr>
				<td>Краткое описание</td>
				<td>#BugToUpdate.shortDescription#</td>
			</tr>
			<tr>
				<td>Полное описание</td>
				<td>#BugToUpdate.detailedDescription#</td>
			</tr>
		</table>
	</cfoutput>
</div>


<cfform id="NewForm">
	<fieldset id="center_fieldset">
		<cfif BugToUpdate.idstatus NEQ 3 >
			<legend>Изменить</legend>
			<dl>					
				<dt><label>Короткое описание</label></dt>
				<dd><cfinput name="fld_shortDescription" id="fld_shortDescription" value="#BugToUpdate.shortDescription#" required='true' message="Пожалуйста заполните описание проблемы"/></dd>
				<dt><label>Подробное описание</label></dt>
				<dd><cftextarea name="fld_detailedDescription" id="fld_detailedDescription" value="#BugToUpdate.detailedDescription#" required='true' message="Пожалуйста заполните описание проблемы"></cftextarea></dd>
				<dt><label>Статус</label></dt>
				<dd>
					<cfselect name="fld_Status" id="fld_Status" selected='#BugToUpdate.idStatus#' query="rsAllStatus" value="idStatus" display="status" queryposition="below">
						<option value="0">Укажате статус</option>
					</cfselect>
				</dd>
				<dt><label>Срочность</label></dt>
				<dd>
					<cfselect name="fld_Urgency" id="fld_Urgency" selected='#BugToUpdate.idUrgency#' query="rsAllUrgency" value="idUrgency" display="urgency" queryposition="below">
						<option value="0">Укажате на сколько срочно</option>
					</cfselect>
				</dd>	
				<dt><label>Критичность</label></dt>					
				<dd>
					<cfselect name="fld_Criticality" id="fld_Criticality" selected='#BugToUpdate.idCriticality#' query="rsAllCriticality" value="idCriticality" display="criticality" queryposition="below">
						<option value="0">Укажате критичность</option>
					</cfselect>
				</dd>
				<dt><label>Действие</label></dt>					
				<dd>
					<cfselect name="fld_action" id="fld_action" query="rsAllAction" value="idAction" display="action" queryposition="below">
						<option value="0">Укажате действие</option>
					</cfselect>
				</dd>
				<dt><label>Комментарий</label></dt>
				<dd><textarea name="fld_comment" id="fld_comment" required='true' message="Пожалуйста оставте комментарий"></textarea></dd>
		
			</dl>
			
			<input type="submit" name="submitForm" id="fld_newBugSubmit" value="Обновить" />
			<cfelse>
				<p class="errorMessage" align="center">Ошибка закрыта, изменение невозможно</p>
			</cfif>
	</fieldset>
</cfform>


<div >	
	
	<fieldset style="width:800px; margin: 0 auto; ">
		<legend>История ошибки</legend>
			<dl>
				<dt><label>Здесь будет выводится история ошибки</label></dt>
				<cfoutput query="BugHistoryTable">
					<table>
						<tr>
							<td>Дата изменения</td>
							<td> #BugHistoryTable.date#</td>
						</tr>
						<tr>
							<td>Действие</td>
							<td>#BugHistoryTable.action#</td>
						</tr>
						<tr>
							<td>Комментарий</td>
							<td>#BugHistoryTable.comment#</td>
						</tr>
						<tr>
							<td>Пользователь</td>
							<td>#lastname# #name#</td>
						</tr>
					</table>
				</cfoutput>
			</dl>
	</fieldset>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</div>

</cfmodule>