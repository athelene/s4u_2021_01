<cfquery name="qDeleteExclude">
    Delete from ExcludeTbl
    where ExcludeID = #url.ExcludeID#
</cfquery>

<cflocation url="/Redirect.cfm?gotoPage=RestrictEx&CircleID=#session.CircleID#">