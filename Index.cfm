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

  <cfset session.Iam="dev">
    <cfset session.setState=#CreateUUID()#>
      <cfset session.returnto='Home'>
        <cfset session.librarytab='stories'>
          <cfset session.todayis='stories'>
            <title>Stories For Us</title>
</head>


<body>

  <cfset authurl=application.google.generateAuthUrl("http://localhost:8500/oauth.cfm", session.urltoken)>

    <cfoutput>



      <!-- Material form login -->
      <div class=" row w-25 d-flex justify-content-center">
        <h1>Let's share a story!</h1>
        <h1>Sign in to Stories for Us</h1>
        <cfif isDefined("session.errordup")>
          <h3>
            <cfoutput>#session.errordup#</cfoutput>
          </h3>
        </cfif>
        <!--Card content-->
        <div class="card-body px-lg-5 pt-0">

          <!-- Form -->
          <form class="text-center" style="color: ##757575;" action="SaltLoginAction.cfm" method="post">

            <!-- Email -->
            <div class="md-form">
              <input type="email" id="materialLoginFormEmail" class="form-control" name="email">
              <label for="materialLoginFormEmail">E-mail</label>
            </div>

            <!-- Password -->
            <div class="md-form">
              <input type="password" id="materialLoginFormPassword" class="form-control" name="password">
              <label for="materialLoginFormPassword">Password</label>
            </div>


            <!-- Forgot password -->
            <a href="">Forgot password?</a>
        </div>
      </div>

      <!-- Sign in button -->
      <button class="btn btn-outline-primary btn-rounded btn-block my-4 waves-effect z-depth-0" type="submit">Sign
        in</button>

      <!-- Register -->
      <p>Not a member?
        <a href="/Users/NewSaltUser.cfm">Register</a>
      </p>

      <!-- Social login -->
      <h2>or sign in with:
        <a type="button" class="btn-floating btn-secondary btn-tw" href="#authurl#">
          Google
        </a>
      </h2>

      </form>
      <!-- Form -->

      </div>

      </div>
      <!-- Material form login -->

    </cfoutput>




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