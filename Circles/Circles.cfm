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
    <cfajaxproxy cfc="cfc.cir" jsclassname="cir" />

<!--- Start Nav --->
  <cfinclude template="/topNavSmall.cfm">
  
  <cfif IsDefined('session.MyCircleID')>

    <cfelse>
      <cfquery name="qGetCircleID">
        Select CircleID from CircleTbl
        where circleOwner = #session.Userid#
        AND CircleSort = '0'
      </cfquery>
      <cfset session.MyCircleID=qGetCircleID.CircleID />
  </cfif>
  


  <h2>My Circles

 
      <a id="newInvitations" href="/Circles/RSVPInvitation.cfm" class="btn  mb-3 btn-rounded btn-warning HiddenStoryStarter">
        Answer Invitations</a>

    <BR />
    <a href="" class="btn  mb-3 btn-secondary" data-toggle="modal" data-target="#modalLoginForm">
      New Circle</a>

  </h2>

  <!--- Beginning of New Circle Modal --->
  <form action="/circles/NewCircleAction.cfm" enctype="multipart/form-data" method="post">
    <div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">Add a Circle</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body mx-3">
            <div class="md-form mb-5">
              <input name="circleName" type="text" id="defaultForm-circle" class="form-control validate"
                placeholder="Type the circle name here" />
            </div>

          </div>
          <div class="modal-footer d-flex justify-content-center">
            <button class="btn btn-secondary">Save</button>
          </div>
        </div>
      </div>
    </div>
</form>
    <!--- End of New Circle Modal --->
 <input type="hidden" id="userID" value="<cfoutput>#session.userid#</cfoutput>">
<div id="CircleDiv">
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
        newPages(<cfoutput>#session.userid#, '#session.LastPageView#', '#session.LastBookView#', '#session.LastTCView#'</cfoutput>);
        getCircles(<cfoutput>#session.userid#</cfoutput>);
        // End of document ready
      });
    </script>


</body>

</html>