<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=7">

    <link rel="icon" href="/img/mdb-favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link href="/css/mdb.min.css" rel="stylesheet">
    <link href="/s4u.css" rel="stylesheet">
    <link href="/main.css" rel="stylesheet">
</head>
<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
<cfajaxproxy cfc="cfc.userImg" jsclassname="userImg" />

<cfquery name="qSetEveryoneCircle">
    Select primaryCircle from userTbl
    where userID = #session.UserID# 
</cfquery>
<cfset session.myCircleID=qSetEveryoneCircle.primaryCircle>

    <body>

        <cfinclude template="/TopNavSmall.cfm">
            <cfset session.setFileName=#CreateUUID()#>

                <cfquery name="qGetUserInfo">
                    Select * from UserTbl
                    where userid = #session.userid#
                </cfquery>

                <!-- Material form register -->
                <div class="card">

                    <h5 class="card-header bg-secondary white-text text-center py-4">
                        <strong> 
                        <cfif qGetUserInfo.UserFirst IS '' OR qGetUserInfo.UserLast IS '' OR qGetUserInfo.UserDisplayName IS ''>
                        You are missing information. Please update your profile.
                        <cfelse>
                        Update Your Profile
                        </cfif>                        
                        </strong>
                    </h5>

                    <!--Card content-->
                    <div class="card-body px-lg-5 pt-0">

                        <!-- Form -->
                        <form class="text-center" style="color: #757575;" action="/Users/EditUserProfileAction.cfm"
                            name="userPicForm" method="post" enctype="multipart/form-data">
                            <cfoutput>
                                <div class="form-row">

                                    <div class="col">
                                        <!-- First name -->
                                        <div class="md-form">
                                            <input type="text" id="materialRegisterFormFirstName" class="form-control"
                                                name="UserFirst" value="#trim(qGetUserInfo.UserFirst)#"
                                                oninput="lightUpUpdateProfileBtn()">
                                            <label for="materialRegisterFormFirstName">First name</label><BR />
                                            <!-- E-mail -->
                                            <div class="md-form mt-0">
                                                <input type="email" id="materialRegisterFormEmail" class="form-control"
                                                    name="UserEmail" value="#trim(qGetUserInfo.UserEmail)#"
                                                    onchange="lightUpUpdateProfileBtn()">
                                                <label for="materialRegisterFormEmail">E-mail</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <!-- Last name -->
                                        <div class="md-form">
                                            <input type="text" id="materialRegisterFormLastName" class="form-control"
                                                name="UserLast" value="#trim(qGetUserInfo.UserLast)#"
                                                onchange="lightUpUpdateProfileBtn()">
                                            <label for="materialRegisterFormLastName">Last name</label>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <!-- Display name -->
                                        <div class="md-form">
                                            <input type="text" id="materialRegisterFormLastName" class="form-control"
                                                name="UserDisplayName" value="#trim(qGetUserInfo.UserDisplayName)#"
                                                onchange="lightUpUpdateProfileBtn()">
                                            <label for="materialRegisterFormDisplayName">Full name as it will appear to
                                                others</label>
                                        </div>
                                    </div>
                                </div>
                                <BR />


                                <!-- Sign up button -->
                                <button id="updateProfileBtn"
                                    class="btn bg-secondary white-text btn-rounded btn-block my-4 waves-effect z-depth-0"
                                    type="submit">Update</button>

                                <hr>

                                <!-- Terms of service -->
                                <p>By clicking
                                    <em>Update</em> you agree to our
                                    <a href="" target="_blank">terms of service</a>
                            </cfoutput>
                        </form>
                        <!-- Form -->

                    </div>

                </div>
                <!-- Material form register -->
                <br /><br /><br /><br /><br /><br />

                <cfinclude template="/FooterMobile.cfm">
                    <!-- JQuery -->
                    <script type="text/javascript" src="/js/jquery.min.js"></script>
                    <!-- Bootstrap tooltips -->
                    <script type="text/javascript" src="/js/popper.min.js"></script>
                    <!-- Bootstrap core JavaScript -->
                    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
                    <!-- MDB core JavaScript -->
                    <script type="text/javascript" src="/js/mdb.min.js"></script>

                    <!-- Optional JavaScript -->
                    <script type="text/javascript" src="/js/homeFeed.js"></script>
                    <script type="text/javascript" src="/js/badgeUpdates.js"></script>
                    <script type="text/javascript" src="/js/editUserImg.js"></script>
                    <script type="text/javascript">
                        $(document).ready(function () {

                                    $(function () {
                                        $(".sticky").sticky({
                                            topSpacing: 90,
                                            zIndex: 2,
                                            stopper: "#YourStopperId"
                                        });
                                    });

                                    $('.mdb-select').materialSelect();

                                    // MDB Lightbox Init
                                    $(function () {
                                        $("#mdb-lightbox-ui").load("mdb-addons/mdb-lightbox-ui.html");
                                    });

                                    newPages( < cfoutput > #session.userid#, '#session.LastPageView#',
                                        '#session.LastBookView#', '#session.LastTCView#' < /cfoutput>);
                                        // hideUpdateProfileBtn();
                                        // End of document ready
                                    });
                    </script>


    </body>