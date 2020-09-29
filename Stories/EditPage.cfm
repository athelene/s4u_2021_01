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

    <script src="/ckeditor/ckeditor.js"></script>
    <!--- Ajax Components --->
    <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
    <cfajaxproxy cfc="cfc.mem" jsclassname="mem" />
    <cfajaxproxy cfc="cfc.add" jsclassname="add" />
    <cfajaxproxy cfc="cfc.exc" jsclassname="exc" />
    <cfajaxproxy cfc="cfc.FeatureImg" jsclassname="FeatureImg" />

        <!--- Start Nav --->
        <cfinclude template="/TopNavSmall.cfm">

            <cfquery name="qMyStory">
                Select * from StoryTbl
                where storyID = #url.storyID# and UserID = #session.userid#
            </cfquery>

            <cfset session.storyid=qMyStory.StoryID />

            <cfquery name="qGetCircles">
                Select * from CircleTbl
                where CircleOwner = #session.Userid#
                Order By CircleSort
            </cfquery>

            <cfquery name="qGetCircleMembers">
                Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'In' AS ExcStatus,
                trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First
                FROM CircleMemberTbl
                left join CircleTbl
                on CircleMemberTbl.CircleID = CircleTbl.CircleID
                join UserTbl
                on CircleMemberTbl.MemberID = UserTbl.UserID
                where CircleTbl.CircleID = #qMyStory.CircleID#
                AND CircleMemberTbl.MemberID not in
                (select ExcludeUser from ExcludeTbl
                where storyID = #session.storyID#)

                UNION

                Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'Out' AS ExcStatus,
                trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First
                FROM CircleMemberTbl
                left join CircleTbl
                on CircleMemberTbl.CircleID = CircleTbl.CircleID
                join UserTbl
                on CircleMemberTbl.MemberID = UserTbl.UserID
                where CircleTbl.CircleID = #qMyStory.CircleID#
                AND CircleMemberTbl.MemberID in
                (select ExcludeUser from ExcludeTbl
                where storyID = #session.storyID#)

                order by Last, First
            </cfquery>

                <cfif qMyStory.StoryTypeID EQ 2>
                    <cfinclude template="EditInterview.cfm">

                        <cfelseif qMyStory.StoryTypeID EQ 3>
                            <cfinclude template="EditRecipe.cfm">

                                <cfelse>
                                    <cfinclude template="EditOtherPages.cfm">
                </cfif>



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
                <script type="text/javascript" src="/js/s4u.js"></script>
                <script type="text/javascript" src="/js/editFeatureImg.js"></script>
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

                                // Check Notifications
                                newPages(<cfoutput>#session.userid#, '#session.LastPageView#',
                                    '#session.LastBookView#',
                                    '#session.LastTCView#' </cfoutput>);
                                    updateMedia(<cfoutput >#session.StoryID#, #session.UserID#</cfoutput>);
                                        // End of document ready
                                    });
                </script>


                </body>

</html>