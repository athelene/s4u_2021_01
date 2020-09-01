<!doctype html>
<html lang="en">

<head>
</head>

<cfquery name="qRemoveFromCircle">
  Delete from CircleMemberTbl
  where CircleMemID = #url.remID#
</cfquery>


<cflocation url="/circles/EditCircle.cfm&CircleID=#session.CircleID#" />

</html>