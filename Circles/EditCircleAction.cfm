<!doctype html>
<html lang="en">

<head>

  <title>Stories For Us</title>
</head>

<body>

  <cfquery name="qEditCircle">
    Update CircleTbl
    SET CircleName = <cfqueryparam value="#trim(form.CircleName)#" cfsqltype="CF_SQL_VARCHAR">,
      CircleSort = <cfqueryparam value="#trim(form.CircleName)#" cfsqltype="CF_SQL_VARCHAR">
        WHERE CircleID = #Form.CircleID#
  </cfquery>


  <cflocation url="/Circles/Circles.cfm" />




</body>

</html>