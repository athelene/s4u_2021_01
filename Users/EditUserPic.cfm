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
    <link href="/css/mdb.min.css" rel="stylesheet">
    <link href="/s4u.css" rel="stylesheet">
    <link href="/main.css" rel="stylesheet">
</head>
<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
<cfajaxproxy cfc="cfc.userImg" jsclassname="userImg" />

<cfquery name="qSetEveryoneCircle">
    Select CircleID from CircleTbl
    where CircleOwner = #session.UserID# AND
    CircleSort = '0'
</cfquery>
<cfset session.myCircleID=qSetEveryoneCircle.CircleID>

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
                        <strong>Click on the picture to select a new image</strong>
                    </h5>

                    <!--Card content-->
                    <div class="card-body px-lg-5 pt-0">

                        <!-- Form -->
                        <form class="text-center" style="color: #757575;" action="/Users/EditUserPicAction.cfm"
                            name="userPicForm" method="post" enctype="multipart/form-data">
                            <cfoutput>
                                <div class="form-row">
                                    <div class="col" id="userImgDiv">
                                        <!-- Profile Picture -->

                                    </div>
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
                                        findUserImg( < cfoutput > #session.userid# < /cfoutput>);
                                            hideUpdateProfileBtn();
                                            // End of document ready
                                        });
                    </script>


    </body>