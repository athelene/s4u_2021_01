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
<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />


<!--- Start Nav --->
<cfinclude template="/TopNavSmall.cfm">

  <cfquery name="qGetBookTitle">
    Select BookTitle
    from BookTbl
    where BookID = #session.BookID#
  </cfquery>

  <cfquery name="qGetMyStories">
    Select StoryTbl.StoryTitle, StoryTbl.StoryID
    from StoryTbl
    where 
    (
    StoryTbl.Userid = #session.userID#  
    OR 
    (StoryTbl.Userid <> #session.userID# 
    AND 
      (CircleID in
        (select CircleID from CircleMemberTbl
        where MemberID = #session.UserID#) )
      ) 
    AND ( StoryTbl.StoryID not in
        (Select StoryID from ExcludeTbl
        where ExcludeUser = #session.UserID#)
        )
    )
    and StoryID NOT IN
    ( Select BookContentTbl.StoryID
    from BookTbl
    join BookContentTbl
    on BookTbl.BookID = BookContentTbl.BookID
    where BookTbl.BookID = #session.BookID# )

  </cfquery>



  <body>

    <cfoutput>
      <h1>Add Pages To " #qGetBookTitle.BookTitle#"</h1>


      <!--Blue select-->
      <form action="/stories/AddStoriesToBookAction.cfm" enctype="multipart/form-data" method="post">

        <select class="mdb-select md-form colorful-select dropdown-secondary" multiple searchable="Search pages.."
          name="data">
          <option value="" disabled selected>Choose your pages</option>
          <cfloop query="qGetMyStories">
            <option value="#qGetMyStories.StoryID#">#qGetMyStories.StoryTitle#</option>
          </cfloop>
        </select>

        <div class="text-center">

          <button class="btn btn-secondary btn-floating" type="submit">
            <i class="fas fa-check"></i>
          </button>

        </div>
      </form>
      <BR><BR><BR><BR><BR><BR><BR>
      <cfinclude template="/FooterMobile.cfm">
    </cfoutput>

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

    <!-- Optional JavaScript -->
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
            newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
              '#session.LastTCView#' < /cfoutput>);

              // End of document ready
            });
    </script>

  </body>

</html>