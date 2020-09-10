<!doctype html>
<html lang="en">

  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="/favicon-16x16.png" type="image/png" size="16x16">
  <link rel="icon" href="/favicon-32x32.png" type="image/png" size="32x32">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="/css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

    <title>Stories For Us</title>
    </head>
    <cfset authurl=application.google.generateAuthUrl("http://localhost:8500/oauth.cfm", session.urltoken)>

        <body class="newSaltUser">

            <!-- Material form login -->
            <div class="row w-50 d-flex ">

                <h1>Create a Stories for Us Account</h1>

                <h5>By creating this account I agree to the Stories for Us User Agreement and
                    <a href="/privacypolicy.cfm" target="_blank">
                        Privacy Policy. </a></h5>
                <BR /><BR />
                <cfif isDefined("session.errordup")>
                    <h3>
                        <cfoutput>#session.errordup#</cfoutput>
                    </h3>
                </cfif>
                <!--Card content-->
                <div class="card-body px-lg-5 pt-0">

                    <!-- Form -->
                    <form class="text-center" style="color: ##757575;" action="NewSaltUserAction.cfm" method="post">
                        <!-- Name -->

                        <!-- First Name-->
                        <div class="md-form">
                            <input type="text" id="defaultContactFormName" class="form-control mb-4"
                                placeholder="First Name" name="UserFirst">
                            <label for="materialLoginFormEmail">First Name</label>
                        </div>

                        <!-- Last Name -->
                        <div class="md-form">
                            <input type="text" id="defaultContactFormName" class="form-control mb-4"
                                placeholder="Last Name" name="UserLast">
                            <label for="materialLoginFormEmail">Last Name</label>
                        </div>

                        <!-- Last Name -->
                        <div class="md-form">
                            <input type="text" id="defaultContactFormName" class="form-control mb-4"
                                placeholder="How you want your name to display" name="UserDisplayName">
                            <label for="materialLoginFormEmail">Display Name</label>
                        </div>

                        <!-- Email -->

                        <div class="md-form">
                            <cfif isDefined("form.Email")>
                                <input type="email" id="materialLoginFormEmail" class="form-control" name="email"
                                    value="<cfoutput>#form.email#</cfoutput>">
                                <cfelse>
                                    <input type="email" id="materialLoginFormEmail" class="form-control" name="email">
                            </cfif>
                            <label for="materialLoginFormEmail">E-mail</label>
                        </div>

                        <!-- Password -->
                        <div class="md-form">
                            <input type="password" id="materialLoginFormPassword" class="form-control" name="password">
                            <label for="materialLoginFormPassword">Create a Password</label>
                        </div>

                        <!---                 Referrer if exists --->
                        <cfif isDefined("Form.Sender")>

                            <input type="hidden" name="Sender" value="<cfoutput>#form.Sender#</cfoutput>" />
                        </cfif>
                        <!-- Sign in button -->
                        <button class="btn btn-outline-primary btn-rounded btn-block my-4 waves-effect z-depth-0"
                            type="submit">Create My Account</button>


                        <!-- Social login -->
                        <h2>or sign up with <br />
                            <a type="button" href="<cfoutput>#authurl#</cfoutput>">
                                <button type="button btn-secondary" class="btn">
                                    <i class="fab fa-google"></i>
                                    <span>Google</span>
                                </button>
                            </a>
                        </h2>

                    </form>
                    <!-- Form -->

                </div>

            </div>
            <!-- Material form login -->

            <!-- JQuery -->
            <script type="text/javascript" src="/js/jquery.min.js"></script>
            <!-- Bootstrap tooltips -->
            <script type="text/javascript" src="/js/popper.min.js"></script>
            <!-- Bootstrap core JavaScript -->
            <script type="text/javascript" src="/js/bootstrap.min.js"></script>
            <!-- MDB core JavaScript -->
            <script type="text/javascript" src="/js/mdb.min.js"></script>
        </body>

</html>