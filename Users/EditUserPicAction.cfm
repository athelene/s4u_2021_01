<!doctype html>
<html lang="en">

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=7">

<link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet" href="/assets/css/bootstrap.css">
<link rel="stylesheet" href="/assets/css/index.css">  

</head>

<body>

  <cfif len(Form["fileI"])>

    <cfinclude template="UploadProfile.cfm" />
    <cfset newUserMediaLoc="/M_Profile/" & #session.UserID# & "/" & #session.setFileName# & "." &
      #cffile.clientFileExt# />
    <cfquery name="qUpdateUser">
      UPDATE UserTbl
      SET UserMediaLoc = '#newUserMediaLoc#'
      WHERE UserID = #session.userid#
    </cfquery>
  </cfif>

  <cflocation url="/Users/EditUserPic.cfm" />



  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
    integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous">
  </script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous">
  </script>
</body>

</html>