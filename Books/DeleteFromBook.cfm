<!doctype html>
<html lang="en">

<head>

  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="/favicon-16x16.png" type="image/png" size="16x16">
  <link rel="icon" href="/favicon-32x32.png" type="image/png" size="32x32">

  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="/assets/css/bootstrap.css">
  <link rel="stylesheet" href="/assets/css/index.css">  

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