<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=7">
    <link rel="icon" href="/img/mdb-favicon.ico" type="image/x-icon">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/css/index.css">  
    
    <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
</head>

<body>
    <cfquery name="qCheckMembership">
        Select UserID, UserEmail from UserTbl
        where UserEmail = '#form.InviteEmail#'
    </cfquery>

    <cfif qCheckMembership.Recordcount GT 0>

        <cfquery name=qInCircles>
            Select MemberID from CircleMemberTbl
            where MemberID = #qCheckMembership.UserID#
            AND CircleID = #session.mycircleID#
        </cfquery>

        <cfinclude template="/TopNavSmall.cfm">

            <cfif qInCircles.RecordCount GT 0>
                <div class="text-center">
                    <h2>
                        <cfoutput>#form.InviteName#</cfoutput> is already in your Everyone Circle.
                    </h2><BR>
                </div>
                <cfelse>

                    <div class="text-center">
                        <h2>This person is a member of Stories for Us. </h2><BR>
                        <a href="<cfoutput>AddtoEveryone.cfm?userid=#qCheckMembership.UserID#</cfoutput>"
                            class="btn btn-primary" class="btn btn-primary btn-rounded">Invite them to your circles</a>
                    </div>
            </cfif>
            <cfelse>
    <cfif (isDefined("form.InvitationTypeChk"))>
        <cfset InvitationType = 1>
        <cfelse>
        <cfset InvitationType = 2>
    </cfif>

    <cfif (isDefined("form.InvitationType"))>
        <cfset InvitationType = #form.InvitationType#>
    </cfif>
                <cfquery name="qGetUserDisplayName">
                    Select UserID, UserDisplayName from UserTbl
                    where userid = #session.userid#
                </cfquery>

                <cfquery name="qSendInvitation">
                    Insert into InvitationTbl
                    (InviteName, InviteEmail, InviteDate, ReminderCount, LastContactDate,
                    InvitedBy, InvitationType)
                    VALUES
                    ('#form.InviteName#', '#form.InviteEmail#', GETDATE(), 1, GETDATE(),
                    #qGetUserDisplayName.userid#, #InvitationType#)
                </cfquery>

                <cfset vSubject='Join ' & #qGetUserDisplayName.UserDisplayName# & ' on Stories For Us!'>
                    <cfif session.Iam IS 'DEV'>
                        <cfset
                            vActionPage='http://localhost:8500//circles/InvitationLanding.cfm?InvNo=?InvNo=<cfoutput>#session.userid#</cfoutput>'>
                            <cfelse>
                                <cfset
                                    vActionPage='http://www.storiesforus.com/circles/InvitationLanding.cfm?InvNo=?InvNo=<cfoutput>#session.userid#</cfoutput>'>
                    </cfif>

                    <cfoutput>

                        <cfmail from="Storyteller@storiesforus.com" to="#form.InviteEmail#" subject="#vSubject#"
                            type="HTML">


                            <div style="color:blue; margin:1em; font-size:125%">
                                #qGetUserDisplayName.userdisplayname# is using Stories For Us to keep people close to
                                them connected. Please join us
                                to share stories of the past and present across generations - all without all the
                                nonesense of social media. <BR><BR>
                                Check it out with a 30-day free trial.<BR><BR>

                                <a href="http://localhost:8500/Circles/InvitationLanding.cfm?InvNo=#session.userid#">
                                    Take a Look</a>
                            </div>
                            <input type="hidden" value=>


                        </cfmail>
                    </cfoutput>
                     <cflocation url="/circles/InviteNewMember.cfm"> 
    </cfif>

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
                            // End of document ready
                        });
        </script>
</body>

</html>