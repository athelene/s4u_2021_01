<!doctype html>
<html lang="en">

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=7">

    <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link href="css/mdb.min.css" rel="stylesheet">
    <link href="/s4u.css" rel="stylesheet">
    <link href="/main.css" rel="stylesheet">
    <title>Add New User Query</title>
    </head>

    <body>
        <cfparam name="session.errordup" default="">
            <cfset notifydatetime=CREATEODBCDATETIME( Now() ) />

            <body>
                <h1>Sign Up for Stories For Us</h1>
                <cfquery name="qTestForDup">
                    Select UserID from UserTbl
                    where UserEmail = '#form.email#'
                </cfquery>

                <cfif qTestForDup.RecordCount GT 0>
                    <cfset #session.errordup#="That email address is already registered." />
                    <cflocation url="NewSaltUser.cfm">
                </cfif>
                <cfset passwordSalt=hash(generateSecretKey("AES"),"SHA-512")>
                    <cftry>
                        <cfquery name="qAddUser" result="rGetUserID">
                            INSERT INTO UserTbl (UserAuthType, UserSaltPW, UserHash, UserFirst, UserLast,
                            UserDisplayName,
                            UserEmail, UserSubType, UserAuthID, AdminLevel,
                            LastPageView, LastBookView, LastTCView, LastCircleView)
                            VALUES(
                            <cfqueryparam value="E" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#passwordSalt#">,
                            <cfqueryparam cfsqltype="CF_SQL_VARCHAR"
                                value="#hash(form.Password & passwordSalt,'SHA-512')#">,
                            <cfqueryparam value="#trim(form.UserFirst)#" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam value="#trim(form.UserLast)#" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam value="#trim(form.UserDisplayName)#" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam value="#trim(form.Email)#" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
                            <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">,
                            <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
                            <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#notifydatetime#" cfsqltype="cf_sql_timestamp">
                            )
                        </cfquery>

                        <cfcatch type="any">
                            Error: <cfoutput>#cfcatch.message#</cfoutput>
                        </cfcatch>
                    </cftry>

                    <cfquery name="qCreateCircle" result="circleResult">
                        Insert into CircleTbl
                        (CircleOwner, CircleName, CircleSort)
                        Values
                        (#rGetUserID.generatedkey#, 'Everyone Circle', '0')
                    </cfquery>
                    <cfquery name="qUpdateUserCircle">
                    update UserTbl 
                    set primaryCircle = #circleResult.generatedkey# 
                    where userID = #rGetUserID.generatedkey#
                    </cfquery>

                    <cfif isDefined("form.Sender")>
                        <cfoutput>#form.Sender# is defined</cfoutput>
                        <cfquery name="qUpdateInvitationTbl">
                            Update InvitationTbl
                            SET ConvertDate = GETDATE()
                            WHERE InviteEmail = '#form.Email#'
                            AND InvitedBy = #form.Sender#
                        </cfquery>
                    <cfset session.TodayIs=datetimeformat(now(), "YYYY-MM-DD HH:nn:ss" ) />
                        <cfquery name="qGetInviterInfo">
                        Select InvitedBy, primaryCircle 
                        from InvitationTbl 
                        left join UserTbl 
                        on InvitationTbl.InvitedBy = UserTbl.UserID 
                        where InviteEmail = '#form.Email#'
                        AND InvitedBy = #form.Sender#
                        </cfquery>
                        <cfquery name="qUpdateInviterCircle">
                        Insert into CircleMemberTbl 
                        (CircleID, MemberID, InvitedBy, AcceptedDate, Status) 
                        Values  
                        (
                        <cfqueryparam value="#qGetInviterInfo.primaryCircle#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#rGetUserID.generatedkey#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#qGetInviterInfo.InvitedBy#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#session.TodayIs#" cfsqltype="CF_SQL_DATE">,
                        <cfqueryparam value="Accepted" cfsqltype="CF_SQL_VARCHAR"> 
                        )
                        </cfquery>

                        <cfquery name="qUpdateInvitedCircle">
                        Insert into CircleMemberTbl 
                        (CircleID, MemberID, InvitedBy, AcceptedDate, Status) 
                        Values  
                        (
                        <cfqueryparam value="#circleResult.generatedkey#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#qGetInviterInfo.InvitedBy#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#rGetUserID.generatedkey#" cfsqltype="CF_SQL_INTEGER">,
                        <cfqueryparam value="#session.TodayIs#" cfsqltype="CF_SQL_DATE">,
                        <cfqueryparam value="Accepted" cfsqltype="CF_SQL_VARCHAR"> 
                        )
                        </cfquery>
                        <cfelse>
                            <cfoutput>No sender detected</cfoutput>
                    </cfif>
                    <cfset session.TodayIs=datetimeformat(now(), "YYYY-MM-DD HH:nn:ss" ) />
                    <cfset session.loggedin=true>
                        <cfset session.userID=#rGetUserID.generatedkey#>
                            <cfset session.userEmail=#form.Email#>
                                <cfset session.MyCircleID=#circleResult.generatedkey#>




                                    <cflocation url="/homepage.cfm"> --->


                                        <!-- Optional JavaScript -->
                                        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
                                        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                                            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                                            crossorigin="anonymous"></script>
                                        <script
                                            src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                                            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
                                            crossorigin="anonymous"></script>
                                        <script
                                            src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                                            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
                                            crossorigin="anonymous"></script>
            </body>

</html>