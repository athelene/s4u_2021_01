<!doctype html>
<html lang="en">

<head>

  <title>Stories For Us</title>
</head>

<body>
  <cfset getNow=now() />

  <cfoutput>

    <cfquery name="qAddCircle">
      Insert into CircleTbl
      (CircleOwner, CircleName, CircleSort)
      values
      (<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value="#form.CircleName#" cfsqltype="CF_SQL_VARCHAR">,
          <cfqueryparam value="#form.CircleName#" cfsqltype="CF_SQL_VARCHAR">
            )
    </cfquery>

  </cfoutput>

  <cflocation url="/circles/Circles.cfm" />
</body>

</html>