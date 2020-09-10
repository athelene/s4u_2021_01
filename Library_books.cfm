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

  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
  <cfajaxproxy cfc="cfc.BookFilter" jsclassname="BookFilter" />

    <!--- Update LastPage Field --->
    <cfquery name="qSetLastBookView">
      Update Usertbl
      SET LastBookView = GetDate()
      WHERE userid = #session.userID#
    </cfquery>

<body>
  <!--- Start Nav --->
  <cfinclude template="/topNavSmall.cfm">

    <h2>Books and Time Capsules</h2>

    <div class="btn-group bg-light" data-toggle="buttons">
      <label class="btn btn-secondary btn-rounded form-check-label active">
        <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked
          onClick="getAllBooks(<cfoutput>#session.userid#</cfoutput>)">
        All </label>
      <label class="btn btn-secondary btn-rounded form-check-label">
        <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off"
          onClick="getMyBooks(<cfoutput>#session.userid#</cfoutput>)"> Only Mine
      </label>
      <label class="btn btn-secondary btn-rounded form-check-label">
        <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off"
          onClick="getOtherBooks(<cfoutput>#session.userid#</cfoutput>)"> Other People's
      </label>
    </div>
    <!-- Material checked -->
    <div class="switch sortContainer">
      <span class="sortContainer">
        Books <label>
          <input type="checkbox" checked id="showBooks" value="on">
          <span class="lever"></span>
        </label>
      </span>
      <span class="sortContainer">
        <label>
          Time Capsules
          <input type="checkbox" checked id="showTCs" value="on">
          <span class="lever"></span>
        </label>
      </span>
    </div>

    <BR /><BR />
    <cfoutput>
      <div id="BookDiv">

      </div>
    </cfoutput>
    <cfinclude template="/FooterMobile.cfm">


      <!-- JQuery -->
      <script type="text/javascript" src="js/jquery.min.js"></script>
      <!-- Bootstrap tooltips -->
      <script type="text/javascript" src="js/popper.min.js"></script>
      <!-- Bootstrap core JavaScript -->
      <script type="text/javascript" src="js/bootstrap.min.js"></script>
      <!-- MDB core JavaScript -->
      <script type="text/javascript" src="js/mdb.min.js"></script>

      <!-- Optional JavaScript -->
      <script type="text/javascript" src="/js/s4u.js"></script>
      <script type="text/javascript" src="/js/bkfilters.js"></script>
      <script type="text/javascript" src="/js/badgeUpdates.js"></script>
      <script type="text/javascript">
        $(document).ready(function () {

              $(function () {
                $(".sticky").sticky({
                  topSpacing: 90,
                  zIndex: 2,
                  stopper: "#YourStopperId"
                });
              });

              // MDB Lightbox Init
              $(function () {
                $("#mdb-lightbox-ui").load("mdb-addons/mdb-lightbox-ui.html");
              });

              // Check Notifications
              newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                '#session.LastTCView#' < /cfoutput>);
                getAllBooks( < cfoutput > #session.userid# < /cfoutput>);
                  // End of document ready
                });
      </script>


</body>

</html>