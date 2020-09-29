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

  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
  <cfajaxproxy cfc="cfc.mem" jsclassname="mem" />

  <!--- Start Nav --->
  <cfinclude template="/TopNavSmall.cfm">

    <cfquery name="qGetCircleName">
      Select CircleName from CircleTbl
      where circleID = #url.CircleID#
    </cfquery>
    <input id="sessionuserid" type="hidden" value="<cfoutput>#session.userID#</cfoutput>">
    <h2>Search from your Everyone Circle to Add to <cfoutput>#qGetCircleName.CircleName#</cfoutput>
    </h2>

    <div class="active-cyan-3 active-cyan-4 mb-4">
      <input class="form-control" id="searchInput" type="text" placeholder="Search" name="SearchName"
        aria-label="Search" />
      <button class="btn btn-secondary"
        onclick="searchEveryoneList(<cfoutput>#url.CircleID#,#session.mycircleID#</cfoutput>)">Search</button>
    </div>


    <div id="searchDiv">


    </div>
    <h4>Current Members</h4>
    <div class="list-group" id="CircleDiv">


    </div>



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
      <script type="text/javascript" src="/js/circleFilter.js"></script>
      <script type="text/javascript" src="/js/everyoneCircleFilter.js"></script>
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
                getMemberList( < cfoutput > #url.CircleID# < /cfoutput>);
                  // End of document ready
                });
      </script>


      </body>

</html>