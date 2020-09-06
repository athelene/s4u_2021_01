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

<body>
  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />

  <cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

  <cfquery name="qGetEveryoneCircle">
    Select primaryCircle from userTbl
    where userID = #session.UserID#
  </cfquery>
  <cfset session.myCircleID=#qGetEveryoneCircle.primaryCircle#>

    <!---     Start page here --->
    <cfquery name="qGetUserSubType">
      Select UserSubType from UserTbl
      where userid = #session.userid#
    </cfquery>
    <cfquery name="qSentInvitations">
      Select InvitationID, InviteName, InviteEmail,
      InviteDate, InvitedBy
      from InvitationTbl
      where InvitedBy = #session.userID#
      AND ConvertDate is null
    </cfquery>
    <cfquery name="qMemberInvitations">
      Select CircleMemID, UserTbl.UserDisplayName
      from CircleMemberTbl
      left join UserTbl
      on CircleMemberTbl.CircleMemID = UserTbl.UserID
      where CircleMemberTbl.InvitedBy = #session.Userid#
      and CircleMemberTbl.CircleID = #session.mycircleID#
      and CircleMemberTbl.Status = 'Invited'
    </cfquery>
    <cfquery name="qAcceptedInvitations">
      Select InvitationID, InviteName, InviteEmail,
      InviteDate, InvitedBy
      from InvitationTbl
      where InvitedBy = #session.userID#
      AND ConvertDate is not null
      order by InviteName desc
    </cfquery>

    <!--- Start Nav --->
    <cfinclude template="/TopNavSmall.cfm">

      <cfif qGetUserSubType.UserSubType IS 1>
      <cfquery name="qAdminCharterInvites">
        Select AdminVarValue 
        from AdminVarTbl 
        where AdminVarName = 'CharterInvites'
      </cfquery>
      <cfquery name="qGetCharterCount">
        Select InvitationID, InvitationType
        from InvitationTbl 
        where 
        InvitedBy = #session.userID# 
        AND InvitationType = 1
      </cfquery>
      <cfset remainingInvitations = #val(qAdminCharterInvites.AdminVarValue)# - #qGetCharterCount.RecordCount#>
<cfoutput>
<cfif #remainingInvitations# GT 0> 
<h4>
As a charter member of Stories For Us, you have #remainingInvitations# remaining invitations to share with a friend so they can also have a lifetime, 
free use of this app. 
</h4>
</cfif>

          <form class="text-center border border-light p-5" enctype="multipart/form-data" method="post"
            action="/Circles/InviteNewMemberAction.cfm">

            <p class="h4 mb-4">Invite a Friend</p>

            <p>Send an invitation to a friend to become a Stories For Us Member</p>

            <!-- Name -->
            <input type="text" id="InviteName" name="InviteName" class="form-control mb-4" placeholder="Name">

            <!-- Email -->
            <input type="email" name="InviteEmail" class="form-control mb-4" placeholder="E-mail">

            <!-- InvitationType -->

<cfif #remainingInvitations# GT 0>            
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="InvitationType" name="InvitationTypeChk">
                <label class="form-check-label" for="InvitationType">Do you want to invite this person as one of your charter members?</label>
            </div>
</cfif>
            <input type="checkbox" name="InviteEmail" class="form-control mb-4">

            <!-- Sign in button -->
            <button class="btn btn-secondary btn-block" type="submit">send Invitation</button>


          </form>
          <!-- Default form subscription -->
</cfoutput>
        <cfelse>

          <form class="text-center border border-light p-5" enctype="multipart/form-data" method="post"
            action="/Circles/InviteNewMemberAction.cfm">

            <p class="h4 mb-4">Invite a Friend</p>

            <p>Send an invitation to a friend to become a Stories For Us Member</p>

            <!-- Name -->
            <input type="text" id="InviteName" name="InviteName" class="form-control mb-4" placeholder="Name">

            <!-- Email -->
            <input type="email" name="InviteEmail" class="form-control mb-4" placeholder="E-mail">
            <input type="hidden" name="InvitationType" value="2">
            <!-- Sign in button -->
            <button class="btn btn-secondary btn-block" type="submit">send Invitation</button>


          </form>
          <!-- Default form subscription -->

      </cfif>

      <div class="text-center">

        <cfif qSentInvitations.RecordCount GT 0>
          <cfoutput>
            <h4>Open New Member Invitations:</h4>
            <ul class="list-group">
              <cfloop query="qsentInvitations">
                <li class="list-group-item">#qsentInvitations.InviteName# (sent to
                  #qSentInvitations.InviteEmail# ) </li>
              </cfloop>
            </ul>
          </cfoutput>
        </cfif>
      </div>

      <div class="text-center">
        <cfif qMemberInvitations.RecordCount GT 0>
          <HR>
          <cfoutput>
            <h4>Open Member Invitations:</h4>
            <ul class="list-group">
              <cfloop query="qMemberInvitations">
                <li class="list-group-item">#qMemberInvitations.UserDisplayName# </li>
              </cfloop>
            </ul>
          </cfoutput>
        </cfif>
      </div>


      <cfif qAcceptedInvitations.RecordCount GT 0>
        <HR>
        <cfoutput>
          <h4>Accepted New Member Invitations:</h4>
          <ul class="list-group">
            <cfloop query="qAcceptedInvitations">
              <li class="list-group-item">#qAcceptedInvitations.InviteName#
                (#qAcceptedInvitations.InviteEmail# ) accepted on #dateformat(qAcceptedInvitations.InviteDate,
                "MM-DD-YYY")# </li>
            </cfloop>
          </ul>
        </cfoutput>
      </cfif>
      </div>

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
                newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                  '#session.LastTCView#' < /cfoutput>);

                  // End of document ready
                });
        </script>


</body>

</html>