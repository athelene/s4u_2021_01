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


  <cfset session.Iam="dev">
    <cfset session.setState=#CreateUUID()#>
      <cfset session.returnto='Home'>
        <cfset session.librarytab='stories'>
          <cfset session.todayis='stories'>
            <title>Stories For Us</title>
</head>


<body>
  <div>
    <div class="container-fluid">
      <cfset authurl=application.google.generateAuthUrl("http://localhost:8500/oauth.cfm", session.urltoken)>
      <cfoutput>
  
        <!-- Logo -->
        <div class="row">
          <div class="col-6">
            <img src="./assets/images/Logo_color_full.png" class="logo" />
          </div>
          <div class="col-5">
            <div class="menu">
              <ul>
                <li>
                  <a href="/">Stories</a>
                </li>
                <li>
                  <a href="/">Circles</a>
                </li>
                <li>
                  <a href="/">About</a>
                </li>
                <li>
                  <a href="/">Feedback</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-1"></div>
        </div>
  
        <div class="row">
          <!-- Headline Content -->
          <div class="col-7 offset-1 card-body">
            <h1 class="headline-text">Remember what's really important.</h1>
            <p class="subheadline-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            <button class="btn btn-secondary font-weight-bold py-2">
              GET STARTED
            </button>
          </div>
  
          <!-- Login Card content-->
          <div class="col-3 card-body">

            <div class="card card-body">
  
              <div class="row">
                <div class="col-12">
  
                  <!-- Error Message -->
                  <cfif isDefined("session.errordup")>
                    <h6 class="font-weight-bold text-danger mb-3">
                      <cfoutput>#session.errordup#</cfoutput>
                    </h6>
                  </cfif>

                  <!-- Form -->
                  <form class="text-left" style="color: ##757575;" action="SaltLoginAction.cfm" method="post">
          
                    <!-- Email -->
                    <div class="form-group">
                      <label for="materialLoginFormEmail">E-mail</label>
                      <input type="email" id="materialLoginFormEmail" class="form-control" name="email">
                    </div>
          
                    <!-- Password -->
                    <div class="form-group mb-0">
                      <label for="materialLoginFormPassword">Password</label>
                      <input type="password" id="materialLoginFormPassword" class="form-control" name="password">
                    </div>
  
                    <div class="text-right">
                      <!-- Forgot password -->
                      <a href="" class="text-text-secondary small">Forgot password?</a>    
                    </div>
          
                    <!-- Sign in button -->
                    <button class="btn btn-primary btn-rounded btn-block py-2 font-weight-bold" type="submit">SIGN IN</button>
  
                    <hr />
  
                    <!-- Register button -->
                    <button class="btn btn-secondary btn-rounded btn-block py-2 font-weight-bold" type="submit" href="/Users/NewSaltUser.cfm">REGISTER</button>
  
                  </form>
  
                  <hr />
  
                  <!-- Social login -->
                  <h6 class="text-dark font-weight-bold">
                    Or sign in with <br>            
                    <a type="button" class="btn btn-outline-secondary pt-2" href="#authurl#">
                      <img src="./assets/images/google.png"  style="max-height: 2rem;" />
                    </a>
                  </h6>
                </div>
              </div>
            </div>
          </div>
          <div class="col-1"></div>
        </div>

        <!-- Call Out Section -->
        <div class="row call-out-section">
            <div class="col-4 text-center text-light">
                <i class="fa fa-history fa-3x my-5"></i>
                <p class="w-50 m-auto">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris</p>
            </div>
            <div class="col-4 text-center text-light">
              <i class="fa fa-book fa-3x my-5"></i>
              <p class="w-50 m-auto">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris</p>
            </div>
            <div class="col-4 text-center text-light">
              <i class="fa fa-circle fa-3x my-5"></i>
              <p class="w-50 m-auto">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris</p>
            </div>
        </div>

        <!-- Copyright -->
        <div class="row copyright">
          <div class="col-12">
            <p style="margin-bottom: 0; padding-top: 1rem">©2020 Stories For Us | All Rights Reserved</p>
          </div>
        </div>
  
      </cfoutput>
    </div>
  </div>




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