<cfif NOT isUserLoggedIn()>
	<cflocation url="index.cfm?noaccess" >
</cfif>

<cfmodule template="customTags/front.cfm" title="Добавление новой ошибки">
 
 <!---Запросы для селектов	--->
 
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


		<cfform id="NewForm">
				<fieldset id="center_fieldset">
					<legend>Регистрация новой ошибки</legend>
					
					 	<cfif structkeyexists(form,"submitForm")>
							 <cfquery datasource="CfTestCFML">
										INSERT INTO dbo.BugTable
										(shortDescription, detailedDescription, bugStatusID, bugUrgencyID, bugCriticalityID, date, userLogin)
										VALUES
										(<cfqueryparam value='#form.fld_shortDescription#' />, <cfqueryparam value='#form.fld_detailedDescription#' />, 1, '#form.fld_Urgency#', '#form.fld_Criticality#', CURRENT_TIMESTAMP, '#session.stLoggedInUser.userLogin#')
							</cfquery>
							<p class="okMessage">Ошибка зарегистрирована</p>	
						</cfif>													
					
					<dl>
						<dt><label>Короткое описание</label></dt>
						<dd><input name="fld_shortDescription" id="fld_shortDescription" required='true' message="Пожалуйста заполните описание проблемы"/></dd>
						<dt><label>Подробное описание</label></dt>
						<dd><textarea name="fld_detailedDescription" id="fld_detailedDescription" required='true' message="Пожалуйста заполните описание проблемы"></textarea></dd>
<!---						<dt><label>Статус</label></dt>
						<dd>
							<cfselect name="fld_Status" id="fld_Status" query="rsAllStatus" value="status" display="status" queryposition="below">
								<option value="0">Укажате статус</option>
							</cfselect>
						</dd>--->
						<dt><label>Срочность</label></dt>
						<dd>
							<cfselect name="fld_Urgency" id="fld_Urgency" query="rsAllUrgency" value="idUrgency" display="urgency" queryposition="below">
								<option value="0">Укажате на сколько срочно</option>
							</cfselect>
						</dd>	
						<dt><label>Критичность</label></dt>					
						<dd>
							<cfselect name="fld_Criticality" id="fld_Criticality" query="rsAllCriticality" value="idCriticality" display="criticality" queryposition="below">
								<option value="0">Укажате критичность</option>
							</cfselect>
						</dd>
						

					</dl>
					<input type="submit" name="submitForm" id="fld_newBugSubmit" value="Отправить" />
				</fieldset>
			</cfform>

</cfmodule>