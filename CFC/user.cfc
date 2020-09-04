<!--- Returns all of a users circles with their ID and name --->
<!--- Requires Session.UserID --->
<cfcomponent>

    <cffunction name="getUser" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />

        <cfquery name="qGetUser">
            Select UserID, UserFirst, UserLast, UserDisplayName, PrimaryCircle 
            from UserTbl 
            where UserID = #arguments.Userid#
        </Cfquery>

        <cfreturn qGetUser />
    </cffunction>

</cfcomponent>