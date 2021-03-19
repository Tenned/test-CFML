<!---Обработка--->
<cfif structkeyExists(form,'submitForm')>
	<!---Создаём экземпляр компонента службы аутентификации --->
	<cfset authenticationService = createobject("component",'test CFML.components.authenticationService') />
	<!---проверка данных на сервере--->
	<cfset aErrorMessages = authenticationService.validateUser(form.fld_login,form.fld_password) />
	<cfif ArrayisEmpty(aErrorMessages)>
		<!---входим в систему--->
		<cfset isUserLoggedIn = authenticationService.doLogin(form.fld_login,form.fld_password) />
	</cfif>
</cfif>


<cfmodule template="customTags/front.cfm" title="Вход">


<!---Форма для входа--->
<div >
<cfform id="frmLogin" preservedata="true">
	<fieldset id="center_fieldset">
    <legend>Вход</legend>
    
    <!---Нет доступа--->    
	<cfif structKeyExists(url,'noaccess')>
    	<p class="errorMessage">Пожалуйста зарегистрируйтесь.</p>
    </cfif>
    
    <!---Ошибка входа--->
    <cfif structKeyExists(variables,'aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
    	<cfoutput>
    		<cfloop array="#aErrorMessages#" item="message">
    			<p class="errorMessage">#message#</p>
    		</cfloop>
    	</cfoutput>
    </cfif>
    <!---Нет такого пользователя--->    
    <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
    	<p class="errorMessage">Неверный логин и пароль</p>
    </cfif>
    
    
    <cfif structKeyExists(session,'stLoggedInUser')>
    	<!---Мы вошли--->
    	<p><cfoutput>Здравствуй, #session.stLoggedInUser.userLastName# #session.stLoggedInUser.userFirstName#!</cfoutput></p>
    <cfelse>    

    
    
					<dl>
			        	<dt><label for="fld_login">Логин</label></dt>
						<dd><cfinput type="text" name="fld_login" id="fld_login" required="true" validateAt="onSubmit" message="Введите логин" /></dd>
			
			    		<dt><label for="fld_password">Пароль</label></dt>
			            <dd><cfinput type="password" name="fld_password" id="fld_password" required="true"  validateAt="onSubmit" message="Введите пароль" /></dd>
			    
			        </dl>
			        <cfinput type="submit" name="submitForm" id="fld_submitLogin" value="Войти" />
		</cfif>
			    </fieldset>
			</cfform>
			</div>

</cfmodule>