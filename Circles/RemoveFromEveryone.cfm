<!doctype html>
<html lang="en">

<head>
</head>

<cfquery name="qFindAllCircles">
  Select CircleID from CircleTbl
  where CircleOwner = #session.userid#
</cfquery>

<cfloop query="qFindAllCircles">
  <cfquery name="qRemoveFromCircles">
    Delete from CircleMemberTbl
    where circleID = #qFindAllCircles.CircleID#
    AND memberid = #url.remID#
    AND CircleID <> #session.MyCircleID#
  </cfquery>
</cfloop>


<cfquery name="qReject">
  Update CircleMemberTbl
  SET RejectedDate = <cfqueryparam value="#session.todayis#" cfsqltype="CF_SQL_TIMESTAMP">,
    status = <cfqueryparam value="Removed" cfsqltype="CF_SQL_VARCHAR">,
      removedby = <cfqueryparam value="#session.userid#" cfsqltype="INTEGER">
        WHERE MemberID = #url.remID#
        AND CircleID = #session.MyCircleID#
</cfquery>

<cflocation url="/Redirect.cfm?gotoPage=EditEveryoneCircle&CircleID=#session.CircleID#" />

</html>