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
  <cfset session.storyID=0 />
  <cfset session.circleID=url.circleID />
  <!--- Update LastPage Field --->
  <cfquery name="qSetLastCircleView">
    Update Usertbl
    SET LastCircleView = GetDate()
    WHERE userid = #session.userID#
  </cfquery>

  <!--- Start Nav --->
  <cfinclude template="/TopNavSmall.cfm">

    <cfquery name="qGetCircle">
      Select * from CircleTbl
      where CircleID = #url.CircleID#
    </cfquery>



    <cfoutput>
          <cfif qGetCircle.CircleID IS #session.MyCircleID#>
          <p class="circleListText">#qGetCircle.CircleName#</p>
          <cfelse>
      <h2>#qGetCircle.CircleName#</h2>
      <form action="/circles/EditCircleAction.cfm" enctype="multipart/form-data" method="post">
      <input type="hidden" value="#session.MyCircleID#" id="sessionMyCircleID">
        <div>
          Circle Name:
          <div class="input-group mb-3">
            <input type="text" name="CircleName" value="#trim(qGetCircle.CircleName)#"
              class="form-control InputLeftText" /><br />
            <div class="input-group-append">
              <button class="btn-sm btn-secondary input-group-text" type="submit"><i class="fas fa-check"></i></button>
            </div>
          </div>

        </div>

        <input type="hidden" name="CircleID" value="#qGetCircle.CircleID#" />
      </form>
          </cfif>
      <BR>
      <h2>People in This Circle
            <input type="hidden" value="#session.MyCircleID#" id="sessionMyCircleID">
        <cfif qGetCircle.CircleID IS #session.mycircleID#>
          <a href="/circles/InviteToMyEveryone.cfm" class="btn btn-secondary">
            <i class="fas fa-user-plus"></i></a>
          <cfelse>
            <a href="/circles/AddToCircle.cfm?CircleID=#qGetCircle.CircleID#" class="btn btn-secondary"
              title="Add to this circle">
              <i class="fas fa-user-plus"></i></a>
        </cfif>
      </h2>

      <div id="CircleDiv">
      </div>


    </cfoutput>

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
      <script type="text/javascript" src="/js/badgeUpdates.js"></script>
      <script type="text/javascript" src="/js/s4u.js"></script>

      <script type="text/javascript">
        $(document).ready(function () {



              // Check Notifications
              newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                '#session.LastTCView#' < /cfoutput>);       
                getMemberList( < cfoutput > #url.CircleID# < /cfoutput>);
                  // End of document ready
                });
      </script>
      </body>

</html>