<cfmodule template="customTags/front.cfm" title="Добавление новой ошибки">
 
		<cfform id="NewForm">
				<fieldset id="center_fieldset">
					<legend>Регистрация нового пользователя</legend>							
					 	<cfif structkeyexists(form,"submitForm")>					 		
					 		<cfquery name="rslogin">
					    		SELECT login
					    		FROM UserTable 
					    		WHERE login = <cfqueryparam value='#form.fld_login#' />
					    	</cfquery>					    	
					 		<cfif rslogin.recordcount EQ 0>					 						 			
								<cfquery datasource="CfTestCFML">
										INSERT INTO UserTable
										(login, name, lastname, password)
										VALUES
										(<cfqueryparam value='#form.fld_login#' />, <cfqueryparam value='#form.fld_name#' />, <cfqueryparam value='#form.fld_lastname#' />, <cfqueryparam value='#form.fld_password#' />)
								</cfquery>
								
								<p class="okMessage">Пользователь зарегистрирован</p>
							<cfelse>
								<p class="errorMessage">Такой Логин уже занят</p>
							</cfif>
						</cfif>
					<dl>
						<dt><label>Логин</label></dt>
						<dd><input name="fld_login" id="fld_login" required='true' message="Пожалуйста придумайте Логин"/></dd>
						<dt><label>Фамилия</label></dt>
						<dd><input name="fld_lastname" id="fld_lastname" required='true' message="Пожалуйста введите фамилию"/></dd>
						<dt><label>Имя</label></dt>
						<dd><input name="fld_name" id="fld_name" required='true' message="Пожалуйста введите имя"/></dd>						
						<dt><label>Пароль</label></dt>
						<dd><input name="fld_password" type="password" id="fld_password" required='true' message="Пожалуйста придумайте пароль"/></dd>
					</dl>
					<input type="submit" name="submitForm" id="fld_newBugSubmit" value="Отправить" />
				</fieldset>
			</cfform>

</cfmodule>