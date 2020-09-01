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
        <!-- Material form register -->
        <div class="card">

            <h5 class="card-header Primary-color white-text text-center py-4">
                <strong>Sign Up</strong>
            </h5>

            <!--Card content-->
            <div class="card-body px-lg-5 pt-0">

                <!-- Form -->
                <form class="text-center" style="color: #757575;" method="post" action="AddNewUser.cfm"
                    name="NewUserForm">

                    <div class="form-row">
                        <div class="col">
                            <!-- First name -->
                            <div class="md-form">
                                <input type="text" required="true" id="materialRegisterFormFirstName"
                                    class="form-control" name="UserFirst">
                                <label for="materialRegisterFormFirstName">First name</label>
                            </div>
                        </div>
                        <div class="col">
                            <!-- Last name -->
                            <div class="md-form">
                                <input type="text" required="true" id="materialRegisterFormLastName"
                                    class="form-control" name="UserLast">
                                <label for="materialRegisterFormLastName">Last name</label>
                            </div>
                        </div>
                        <div class="col">
                            <!-- Display name -->
                            <div class="md-form">
                                <input type="email" id="materialRegisterFormDisplayName" class="form-control"
                                    name="UserDisplayName">
                                <label for="materialRegisterFormDisplayName">Full name as it will appear to
                                    others</label>
                            </div>
                        </div>
                    </div>

                    <!-- E-mail -->
                    <div class="md-form mt-0">
                        <input type="email" id="materialRegisterFormEmail" class="form-control">
                        <label for="materialRegisterFormEmail">E-mail</label>
                    </div>

                    <!-- Sign up button -->
                    <button class="btn btn-outline-primary btn-rounded btn-block my-4 waves-effect z-depth-0"
                        type="submit">Update</button>

                    <hr>

                    <!-- Terms of service -->
                    <p>By clicking
                        <em>Update</em> you agree to our
                        <a href="" target="_blank">terms of service</a>
                        <input type="hidden" name="AdminLevel" value=1>
                </form>
                <!-- Form -->

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