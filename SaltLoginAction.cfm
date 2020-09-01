<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Stories For Us</title>
</head>

<body>
  <h1>Let's tell a story!</h1>
  <cfquery name="Authenticate">
    SELECT
    UserHash,
    UserSaltPW
    FROM
    UserTbl
    WHERE
    UserEmail = <cfqueryparam cfsqltype="varchar" value="#form.email#">
  </cfquery>

  <cfif !Authenticate.recordCount>
    <!--- The user is not in the database.  Redirect them to the login page with an error message. --->
    <br />
    <cfset session.errordup="There is no user with that email address." />
    <cflocation url="/index.cfm" />
  </cfif>

  <cfif Authenticate.UserHash eq hash(form.Password & Authenticate.UserSaltPW, "SHA-512" )>
    <!--- User is authenticated. Run whatever code is needed to establish a user session. --->
    <cfquery name="qgetUserId">
      Select *
      from UserTbl
      where UserEmail = '#form.email#'
    </cfquery>
    <cfset session.loggedin=true>
      <cfset session.userID=#qGetUserId.Userid#>
        <cfset session.userEmail=#qGetUserId.UserEmail#>
          <cfquery name=qGetEveryoneCircle>
            Select CircleID from CircleTbl
            where CircleOwner = #session.Userid#
            AND CircleSort = '0'
          </cfquery>
          <cfset session.MyCircleID=#qGetEveryoneCircle.CircleID#>
            <cfscript>
              session.todayis = Now();
              session.LastPageView = Now();
              session.LastBookView = Now();
              session.LastTCView = Now();
              session.LastCircleView = Now();
            </cfscript>
            <cflocation url="Redirect.cfm?goToPage=Home" />

            <cfelse>
              <cfset session.errordup="Incorrect Password" />
              <cflocation url="/index.cfm" />
              <!--- User is not authenticated. Redirect them to the login page with an error message. --->
  </cfif>

</body>

</html>