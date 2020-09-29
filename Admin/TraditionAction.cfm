<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">

  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="/assets/css/bootstrap.css">
  <link rel="stylesheet" href="/assets/css/index.css">  

<body>
  <cfquery name="insertQCQuestion">
    insert into TraditionTypeTbl 
    (TraditionName)
    VALUES 
    (
    <cfqueryparam value="#form.Tradition#" cfsqltype="CF_SQL_VARCHAR">
    )
  </cfquery>

<cflocation url="TraditionAdd.cfm">
</body>

</html>
