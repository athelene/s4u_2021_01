<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/css/index.css">  
    
    <cfajaxproxy cfc="cfc.user" jsclassname="user" />
  
    <title>Stories For Us</title>
  </head>
  <body>
    <h1>Oauth</h1>

<!--- Validate the result --->

<cfset session.Todayis = DateFormat(Now(),"YYYY-MM-DD")>
<cfparam name="url.code" default="">
<cfparam name="url.state" default="">
<cfparam name="url.error" default="">
<cfset result = application.google.validateResult(url.code, url.error, url.state, session.setState)>

<cfif not result.status>
  <!--- Imagine a nicer error here. --->
	<cfoutput>
		<h1>Error!</h1>
		#result.message#
	</cfoutput>
	<cfabort>
</cfif>

<cfset session.token = result.token>


<cfif IsDefined("session.token")>
 <cfset me = application.google.getProfile(session.token.access_token)>
<!---  <cfset session.loggedin = true> --->
<cfquery name="qgetUserId">
  Select UserID, UserDisplayName, UserEmail, PrimaryCircle 
  from UserTbl
  where UserEmail = '#me.email#'
</cfquery>

<cfdump var="#me#" label="google info">
<cfif qgetUserID.recordcount GT 0>

  <cfset session.loggedin = true>
  <cfset session.userID = #qGetUserId.Userid#>
  <cfset session.userEmail = #qGetUserId.UserEmail#>
  <cfset session.MyCircleID = #qGetUserID.PrimaryCircle#>

    <cfscript>
  session.todayis = Now();
  session.LastPageView = Now();
  session.LastBookView = Now();
  session.LastTCView = Now();
  session.LastCircleView = Now();
</cfscript>
  <cflocation url="HomePage.cfm">  

    <cfelse>

  <cfset session.loggedin = false>
  <cfset session.userID = 0>
  <cfset session.newusergoogleid = me.id>
  <cfset session.newemail = me.email>


  <cflocation url="/users/newsaltuser.cfm">  

</cfif>


<cfelse>
Error validating.
</cfif>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
      <!-- Optional JavaScript -->
      <script type="text/javascript" src="/js/s4u.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

              getUserInfo(<cfoutput>#session.userid#</cfoutput>);
                  // End of document ready
                });
      </script>
  </body>
</html>