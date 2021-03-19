<cfif NOT isUserLoggedIn()>
	<cflocation url="index.cfm?noaccess" >
</cfif>

<cfif structkeyexists(form,"submitForm")>
	<cfquery datasource="CfTestCFML" >
		UPDATE dbo.UserTable
		SET lastname = '#form.fld_lastname#',
			name = '#form.fld_name#'
			WHERE login = '#session.stLoggedInUser.userLogin#'
	</cfquery>
	<cfset session.stLoggedInUser.userFirstName = '#form.fld_name#' />
	<cfset session.stLoggedInUser.userLastName = '#form.fld_lastname#' />
							 
</cfif>	

<cfmodule template="customTags/front.cfm" title="Редактирование профиля">
		<cfform id="ChangeProfile">
				<fieldset id="center_fieldset">
					<legend>Изменить данные</legend>
					
					<dl>
						<dt><label>Укажите фамилию</label></dt>
						<dd><cfinput name="fld_lastname" id="fld_lastname" value='#session.stLoggedInUser.userLastName#' required='true' message="Укажите фамилию"/></dd>
						<dt><label>Укажите имя</label></dt>
						<dd><cfinput name="fld_name" id="fld_name" value='#session.stLoggedInUser.userFirstName#' required='true' message="Укажите имя"/></dd>
					</dl>				
					<input type="submit" name="submitForm" id="fld_newBugSubmit" value="Измененить" />
				</fieldset>
			</cfform>

		<cfform id="ChangePassword">
				<fieldset id="center_fieldset">
					<legend>Изменить пароль</legend>
						<!---Если все пароли подтвердились--->
					 	<cfif structkeyexists(form,"submitPasswordForm")>
						  	<cfif form.fld_newPsw eq form.fld_aganPsw 
						  	AND form.fld_oldPsw eq #session.stLoggedInUser.userPassword#>
								<cfquery datasource="CfTestCFML" >
									UPDATE dbo.UserTable
									SET password = '#form.fld_newPsw#'
									WHERE login = '#session.stLoggedInUser.userLogin#'									
								</cfquery>
								<cfset session.stLoggedInUser.userPassword = '#form.fld_newPsw#' />
								<p class="okMessage">Пароль сменен</p>	  		
							<cfelse>			
						 		<p class="errorMessage">Подтвердите пароль</p>
							</cfif>	
						</cfif>						
					<dl>
						<dt><label>Старый пароль</label></dt>
						<dd><cfinput name="fld_oldPsw" type="password" id="fld_oldPsw" required='true' message="Заполните все поля"/></dd>
						<dt><label>Новый пароль</label></dt>
						<dd><cfinput name="fld_newPsw" type="password" id="fld_newPsw" required='true' message="Заполните все поля"/></dd>
						<dt><label>Подтвердите  пароль</label></dt>
						<dd><cfinput name="fld_aganPsw" type="password" id="fld_aganPsw" required='true' message="Заполните все поля"/></dd>

					</dl>
					
					<input type="submit" name="submitPasswordForm" id="fld_newBugSubmit" value="Отправить" />
				</fieldset>
			</cfform>

</cfmodule>