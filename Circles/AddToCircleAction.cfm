<!doctype html>
<html lang="en">

<head>
</head>

<cfquery name="AddToCircle">
  Insert into CircleMemberTbl
  (CircleID, MemberID, InvitedBy, Status)
  Values
  (<cfqueryparam value="#Session.Circleid#" cfsqltype="CF_SQL_INTEGER">,
    <cfqueryparam value="#url.NewUser#" cfsqltype="CF_SQL_INTEGER">,
      <cfqueryparam value="#session.UserID#" cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value="Added" cfsqltype="CF_SQL_VARCHAR">)
</cfquery>

<cflocation url="../Redirect.cfm?gotoPage=EditCircle&CircleID=#session.CircleID#" />