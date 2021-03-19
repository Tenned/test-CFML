<cfcomponent output="false">
	<cfset this.name = 'BugTracker' />
	<cfset this.sessionTimeout = createTimespan(1, 0, 0, 0) />	
	<cfset this.datasource = "CfTestCFML" />	
	<cfset this.customTagPaths = expandPath('/TestCFML/customTags') />	
	APP.TBL_USERSdbo.UserTable<cfset this.sessionManagement = true />
	
</cfcomponent>