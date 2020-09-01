<!doctype html>
<html lang="en">

<head>
</head>

<cfquery name="qGetEveryoneCircle">
  Select CircleId from CircleTbl
  where CircleOwner = #session.UserID#
  AND
  CircleSort = '0'
</cfquery>

<cfquery name="AddToEveryone">
  Insert into CircleMemberTbl
  (CircleID, MemberID, InvitedBy, Status)
  Values
  (<cfqueryparam value="#qGetEveryoneCircle.Circleid#" cfsqltype="CF_SQL_INTEGER">,
    <cfqueryparam value="#url.UserID#" cfsqltype="CF_SQL_INTEGER">,
      <cfqueryparam value="#session.UserID#" cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value="Invited" cfsqltype="CF_SQL_VARCHAR">)
</cfquery>

<cflocation url="/circles/EditCircle.cfm?CircleID=#session.mycircleID#" />