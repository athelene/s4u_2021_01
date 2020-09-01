<cfquery name="qAccept">
    Update CircleMemberTbl
    SET AcceptedDate = <cfqueryparam value="#session.todayis#" cfsqltype="CF_SQL_TIMESTAMP">,
        status = <cfqueryparam value="Accepted" cfsqltype="CF_SQL_VARCHAR">
            WHERE CircleMemID = #url.Invitation#
</cfquery>

<cfquery name="qGetRecord">
    Select * from CircleMemberTbl
    where circleMemID = #url.Invitation#
</cfquery>

<cfquery name="qDup">
    Insert into CircleMemberTbl
    (CircleID, MemberID, Invitedby, AcceptedDate, Status)
    Values
    (<cfqueryparam value="#session.MyCircleID#" cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value="#qGetRecord.InvitedBy#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#qGetRecord.MemberID#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#qGetRecord.AcceptedDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                    <cfqueryparam value="Accepted" cfsqltype="CF_SQL_VARCHAR">
                        )
</cfquery>

<cflocation url="/circles/circles.cfm" />