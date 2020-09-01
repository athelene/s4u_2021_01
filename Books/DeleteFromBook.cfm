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

  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />


  <cfquery name="qGetAdminLevel">
    Select AdminLevel
    from UserTbl
    where #session.UserID# = UserID
  </cfquery>
  <cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

  <cfquery name="qDeleteFromBook">
    Delete from BookContentTbl
    where BookID = #url.BookID# and StoryID = #url.StoryID#
  </cfquery>

  <cflocation url="/stories/Story.cfm?StoryID=#session.StoryID#">


    </body>

</html>