<!--- Returns all of a users circles with their ID and name --->
<!--- Requires Session.UserID --->
<cfcomponent>

    <cffunction name="getCircle" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />

        <cfquery name="qryCircle">

            Select CircleTbl.CircleID, trim(CircleTbl.CircleName) AS CircleName, 
            UserTbl.PrimaryCircle
            FROM CircleTbl
            join UserTbl 
            on CircleTbl.CircleOwner = UserTbl.UserID
            where CircleTbl.CircleOwner = #arguments.Userid# 
            order by CircleTbl.CircleName
        </Cfquery>

        <cfreturn qryCircle />
    </cffunction>

    <cffunction name="deleteCircle" access="remote" returnFormat="json" output="false">
        <cfargument name="circleID" required="yes" type="numeric" default="0" />
        <cfargument name="userID" required="yes" type="numeric" default="0" />
        <cfif #arguments.circleID# IS #session.MyCircleID#>

        <cfelse>
        <cfquery name="qryDeleteCircle">
            Delete from CircleTbl
            where CircleTbl.CircleID = #arguments.circleID#
        </cfquery>
        </cfif>
        <cfquery name="qryGetCircles">
            Select CircleTbl.CircleID, trim(CircleTbl.CircleName) AS CircleName, 
            trim(CircleSort) as CircleSort
            FROM CircleTbl
            where CircleTbl.CircleOwner = #arguments.Userid#
            order by CircleTbl.CircleSort
        </cfquery>
        <cfreturn qryGetCircles />
    </cffunction>
</cfcomponent>