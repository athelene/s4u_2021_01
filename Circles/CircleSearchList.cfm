<!doctype html>
<html lang="en">

<head>
</head>

<cfif IsDefined('form.searchname')>
  <cfset session.searchname=#form.searchname# />
  session variable set
  <cfelse>
    not set
</cfif>

<cflocation url="/circles/AddToCircle.cfm?CircleID=#session.circleID#" />


</html>