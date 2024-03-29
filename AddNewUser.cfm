<!doctype html>
<html lang="en">

  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="/favicon-16x16.png" type="image/png" size="16x16">
  <link rel="icon" href="/favicon-32x32.png" type="image/png" size="32x32">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

  <title>Add New User Query</title>
  </head>

  <body>
    <cfparam name="session.errordup" default="">
      <cfset notifydatetime=CREATEODBCDATETIME( Now() ) />

      <body>
        <h1>Sign Up for Stories For Us</h1>

        <h3>
          <cfoutput>#session.errordup#</cfoutput>
        </h3>
        <cftry>
          <cfquery name="qAddUser">
            INSERT INTO UserTbl (UserFirst, UserLast, UserDisplayName, UserEmail, UserSubType, UserAuthID, AdminLevel,
            LastPageView, LastBookView, LastTCView, LastCircleView, UserMediaLoc)
            VALUES(<cfqueryparam value="#trim(form.UserFirst)#" cfsqltype="CF_SQL_VARCHAR">,
              <cfqueryparam value="#trim(form.UserLast)#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#trim(form.UserDisplayName)#" cfsqltype="CF_SQL_VARCHAR">,
                  <cfqueryparam value="#trim(session.newEmail)#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value=1 cfsqltype="CF_SQL_INT">,
                      <cfqueryparam value="#session.newusergoogleid#" cfsqltype="CF_SQL_VARCHAR" , <cfqueryparam
                        value="#form.AdminLevel#" cfsqltype="CF_SQL_INT">,
                        <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">,
                          <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">,
                              <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">, 
                                <cfqueryparam value="/M_Profile/GenericUser.png" cfsqltype="CF_SQL_VARCHAR">                                                                                                   
                                )
          </cfquery>
          <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
          </cfcatch>
        </cftry>

        <cfquery name="qgetUserId">
          Select UserID, UserDisplayName, UserEmail, AdminLevel
          from UserTbl
          where UserEmail = '#session.newemail#'
        </cfquery>
        <cfquery name="qCreateCircle" result="circleResult">
          Insert into CircleTbl
          (CircleOwner, CircleName, CircleSort)
          Values
          (#qgetUserID.UserID#, 'Everyone Circle', '0')
        </cfquery>

        <cfset session.loggedin=true>
          <cfset session.userID=#qgetUserID.userID#>
            <cfset session.userEmail=#qGetUserId.UserEmail#>
              <cfset session.MyCircleID=#circleResult.generatedkey#>

                <cflocation url="Redirect.cfm?goToPage=Home">


                  <!-- Optional JavaScript -->
                  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
                  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                    integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                    crossorigin="anonymous"></script>
                  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
                    crossorigin="anonymous"></script>
                  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
                    crossorigin="anonymous"></script>
      </body>

</html>