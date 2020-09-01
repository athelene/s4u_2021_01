<cfcomponent>
    <!--- Display the user's picture --->
    <cffunction name="editUserImg" access="remote" returnFormat="json" output="false">
        <cfargument name="userID" required="yes" type="numeric" default="0" />
        <cfquery name="qGetuserImg">
            Select UserMediaLoc
            from UserTbl
            where userID = #arguments.userID#
        </cfquery>
        <cfreturn qGetuserImg>
    </cffunction>



</cfcomponent>