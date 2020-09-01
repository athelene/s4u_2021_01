<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

<body>
  <cfquery name="insertQCQuestion">
    insert into ViewPointTbl 
    (viewpointQ, ViewPointDate)
    VALUES 
    (
    <cfqueryparam value="#form.QC#" cfsqltype="CF_SQL_VARCHAR">,
    <cfqueryparam value="#form.qcDate#" cfsqltype="CF_SQL_DATE">
    )
  </cfquery>

<cflocation url="QuickConnectQuestionAdd.cfm">
</body>

</html>
