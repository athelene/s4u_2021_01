<cfcomponent>
    <!--- Search Pages --->
    <cffunction name="sessionUserid" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfquery name="qUserID">
            Select UserID from UserTbl
            where UserID = #arguments.userid#
        </cfquery>
        <cfreturn qUserID>
    </cffunction>
</cfcomponent>