<cfif Not IsDefined('form.ExcludeID') OR form.excludeID IS 'NONE'>
    <!--- Set the exclude session back to 0 --->
    <cfset session.ExcludeID=0>

        <!--- Check for IDs to add to the AddTbl, if so go to the page to allow user to select them --->
        <cfif session.AddID IS 1>
            <cfset session.AddID=0>
                <cflocation url="/Redirect.cfm?gotoPage=RestrictAdd&CircleID=#session.CircleID#">
                    <cfelse>

                        <!--- If there are no names to be added, go back to page edit --->
                        <cflocation url="/Redirect.cfm?gotoPage=EditStory&storyID=#session.StoryID#">
        </cfif>
</cfif>

<!--- Take the list of people to add and turn it into an array --->

<cfset Excludearray=ListToArray(#form.ExcludeID#) />

<!--- Loop through the array and add each id to the ExcludeTbl --->

<cfloop from="1" to="#arrayLen(Excludearray)#" index="i">
    <cfset newExcludeID=Excludearray[i]>
        <cfquery name="ExcludeID">
            Insert into ExcludeTbl
            (ExcludeUser, StoryID)
            VALUES
            (<cfqueryparam value=#newExcludeID# cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value=#session.StoryID# cfsqltype="CF_SQL_INTEGER">)
        </cfquery>

</cfloop>

<!--- Set the exclude session back to 0 --->
<cfset session.ExcludeID=0>

    <!--- Check for IDs to add to the AddTbl, if so go to the page to allow user to select them --->
    <cfif session.AddID IS 1>
        <cfset session.AddID=0>
            <cflocation url="/Redirect.cfm?gotoPage=RestrictAdd&CircleID=#session.CircleID#">
                <cfelse>

                    <!--- If there are no names to be added, go back to page edit --->
                    <cflocation url="/Redirect.cfm?gotoPage=EditStory&storyID=#session.StoryID#">
    </cfif>