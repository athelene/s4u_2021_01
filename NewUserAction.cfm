<!doctype html>
<html lang="en">
  <>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

  <title>Stories For Us</title>
  </head>
  <body>
<cfset session.errordup = "">

<cfquery name="qCheckforDup">
  Select useremail from userTbl
  where Useremail = '#form.userEmail#'
</cfquery>

<cfif qCheckforDup.recordcount GT 0>
    <cfset session.errordup = #trim(form.userEmail)# & ' is already taken. Please select another Google email address.'>
    <cflocation url="newuser.cfm">
</cfif>


    <cfset session.logintype = "newuser">
    <cfset session.userEmail = #trim(form.userEmail)#>


<cfset authurl = application.google.generateAuthUrl(application.callback, session.urltoken)>

<h1>Confirmation Required</h1>
 

<p>
  In order to use this app, you must confirm with your Google account. Click to login below.
</p>

<cfoutput>
	<p>
	<a href="#authurl#">LOGIN!</a>
	</p>
</cfoutput>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
  </body>
</html>