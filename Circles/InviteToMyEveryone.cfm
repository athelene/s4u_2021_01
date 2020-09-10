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
<cfajaxproxy cfc="cfc.mem" jsclassname="mem" />

<cfquery name="qSetEveryoneCircle">
  Select CircleID from
  CircleTbl
  Where CircleOwner = #session.Userid#
  and CircleSort = '0'
</cfquery>
<cfset session.myCircleID=qSetEveryoneCircle.CircleID>
  <input type="hidden" id="session.userid" value="<cfoutput>#session.Userid#</cfoutput>">
  <!--- Start Nav --->
  <cfinclude template="/TopNavSmall.cfm">

    <!---   Start Page --->

    <h2>Search for A Member to Invite to Your Everyone Circle</h2>


    <div class="active-cyan-3 active-cyan-4 mb-4">
      <input class="form-control" type="text" placeholder="Search" id="searchInput" aria-label="Search" />
      <button class="btn btn-secondary"
        onclick="searchFullMembership(<cfoutput>#session.myCircleID#</cfoutput>)">Search</button>
    </div>

    <div id="searchDiv">

    </div>
    <HR>
    <h2>Current Members:</h2>
    <div id="CircleDiv">

    </div>
    <HR>
    <h2>Invited Members:</h2>
    <div id="invitedDiv">

    </div>

    <BR><BR><BR><BR>
    <!---         Start Footer --->
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
      <script type="text/javascript" src="/js/s4u.js"></script>

      <script type="text/javascript">
        $(document).ready(function () {

              // Check Notifications
              newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                  '#session.LastTCView#' < /cfoutput>);  
                  getMemberList( < cfoutput > #session.myCircleID# < /cfoutput>);     
                    getInvitedList( < cfoutput > #session.myCircleID# < /cfoutput>);     
                      // End of document ready
                    });
      </script>
      </body>

</html>