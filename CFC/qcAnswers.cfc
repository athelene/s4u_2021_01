<!--- Returns all of a users circles with their ID and name --->
<!--- Requires Session.UserID --->
<cfcomponent>

    <cffunction name="getQCAnswers" access="remote" returnFormat="json" output="false">
        <cfargument name="QCID" required="yes" type="numeric" default="0">
            <cfargument name="EveryoneCircle" required="yes" type="numeric" default="0">
                <cfargument name="userID" required="yes" type="numeric" default="0">
                    <cfquery name="qQCAnswers">
                        Select VPAnswerTbl.UserID, VPAnswerTbl.ViewPointID, VPAnswerTbl.VPAnswer,
                        UserTbl.UserDisplayName, UserTbl.UserMediaLoc,
                        UserTbl.UserFirst, UserTbl.UserLast, VPAnswerTbl.VPAnswerID
                        from VPAnswerTbl
                        Left join UserTbl
                        on VPAnswerTbl.UserID = UserTbl.UserID
                        where VPAnswer is not null
                        AND
                        ViewPointID = #arguments.QCID#
                        AND VPAnswerTbl.UserID in
                        (select MemberID from CircleMemberTbl

                        where CircleID = #arguments.EveryoneCircle#)
                        UNION
                        Select VPAnswerTbl.UserID, VPAnswerTbl.ViewPointID, VPAnswerTbl.VPAnswer,
                        UserTbl.UserDisplayName, UserTbl.UserMediaLoc,
                        UserTbl.UserFirst, UserTbl.UserLast, VPAnswerTbl.VPAnswerID
                        from VPAnswerTbl
                        Left join UserTbl
                        on VPAnswerTbl.UserID = UserTbl.UserID
                        where VPAnswerTbl.UserID = #arguments.UserID# AND
                        ViewPointID = #arguments.QCID#
                        Order by UserLast, UserFirst
                    </cfquery>
                    <cfif qQCAnswers.RecordCount IS 0>
                        <cfreturn #arguments.QCID# />
                        <cfelse>
                            <cfreturn qQCAnswers />
                    </cfif>
    </cffunction>

    <cffunction name="saveMyAnswer" access="remote" returnFormat="json" output="false">
        <cfargument name="QCID" required="yes" type="numeric" default="0">
            <cfargument name="UserID" required="yes" type="numeric" default="0">
                <cfargument name="QCAnswer" required="yes" type="string" default="0">
                    <cfquery name="qSaveAnswer">
                        INSERT INTO VPAnswerTbl
                        (VPAnswer, UserID, ViewPointID)
                        VALUES(
                        <cfqueryparam value="#arguments.QCAnswer#" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam value="#arguments.UserID#" cfsqltype="CF_SQL_INTEGER">,
                                <cfqueryparam value="#arguments.QCID#" cfsqltype="CF_SQL_INTEGER">
                                    )
                    </cfquery>
                    <cfquery name="qGetMyAnswer">
                        Select VPAnswer
                        from VPAnswerTbl
                        where VPAnswerID = #arguments.QCID#
                        AND UserID = #arguments.UserID#
                    </cfquery>
                    <cfif qGetMyAnswer.RecordCount IS 0>
                        <cfreturn "You haven't answered yet." />
                        <cfelse>
                            <cfreturn qGetMyAnswer />
                    </cfif>
    </cffunction>

    <cffunction name="getMyAnswer" access="remote" returnFormat="json" output="false">
        <cfargument name="QCID" required="yes" type="numeric" default="0">
            <cfargument name="UserID" required="yes" type="numeric" default="0">
                <cfquery name="qGetMyAnswer">
                    Select trim(VPAnswer) as VPAnswer
                    from VPAnswerTbl
                    where ViewpointID = #arguments.QCID#
                    AND UserID = #arguments.UserID#
                </cfquery>
                <cfreturn qGetMyAnswer />

    </cffunction>

    <cffunction name="saveMyEdit" access="remote" returnFormat="json" output="false">
        <cfargument name="QCID" required="yes" type="numeric" default="0">
            <cfargument name="UserID" required="yes" type="numeric" default="0">
                <cfargument name="QCAnswer" required="yes" type="string" default="0">

                    <cfquery name="qEditAnswer">
                        Update VPAnswerTbl
                        SET VPAnswer = <cfqueryparam value="#trim(arguments.QCAnswer)#" cfsqltype="CF_SQL_VARCHAR">
                            WHERE userID = #arguments.UserID#
                            AND ViewPointID = #arguments.QCID#
                    </cfquery>

                    <cfreturn />
    </cffunction>

    <cffunction name="deleteMyAnswer" access="remote" returnFormat="json" output="false">
        <cfargument name="QCID" required="yes" type="numeric" default="0">
            <cfargument name="UserID" required="yes" type="numeric" default="0">

                <cfquery name="qDeleteAnswer">
                    Delete from VPAnswerTbl
                    WHERE userID = #arguments.UserID#
                    AND ViewPointID = #arguments.QCID#
                </cfquery>

                <cfreturn />
    </cffunction>

</cfcomponent>