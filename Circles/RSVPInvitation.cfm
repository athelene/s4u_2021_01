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

<cfinclude template="/TopNavSmall.cfm">

<cfquery name="qGetInvitations">
  Select CircleMemID, InvitedBy, UserDisplayName
  from CircleMemberTbl
  Left Join UserTbl
  on CircleMemberTbl.Invitedby = UserTbl.UserID
  where MemberId = #session.UserID#
  AND
  Status = 'Invited'
</cfquery>

<h3>Choose to accept or decline each invitation</h3>
<ul class="list-group">
  <cfoutput>
    <cfloop query="qGetInvitations">
      <li class="list-group-item s4u-FeedBlock">
        <div class="md-v-line"></div>
        <h4>
          <a class="btn btn-secondary" href="/circles/AcceptInvitation.cfm?Invitation=#qGetInvitations.CircleMemId#"
            title="Accept Invitation"><i class="fas fa-user-check "></i> </a>
          <a class="btn btn-secondary" href="" title="Decline Invitation"><i class="fas fa-user-times "></i></a>
          #qGetInvitations.UserDisplayName# </h4>
      </li>
    </cfloop>
  </cfoutput>
</ul>

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
        // End of document ready
      });
    </script>


</body>

</html>