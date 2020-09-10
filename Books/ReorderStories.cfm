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

  <script src="/ckeditor/ckeditor.js"></script>

  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />


  <!--- Start Nav --->
  <cfinclude template="/TopNavSmall.cfm">
    <script src="/Books/DragnDrop.js" defer></script>

    <cfquery name=qGetStories>
      Select StoryTbl.StoryTitle, StoryTbl.StoryID, BookContentTbl.BookID, BookContentTbl.SortOrder
      from StoryTbl
      Left Join BookContentTbl ON StoryTbl.StoryID = BookContentTbl.StoryID
      where BookContentTbl.BookID = #session.BookID#
      order by BookContentTbl.SortOrder
    </cfquery>


<body>
  <h3>Drag the story titles to the order they will appear in your book: </h3>
  <form name="StoryOrder" method="post" action="/Books/SetStoryOrder.cfm" onsubmit="return getNewOrder()">

    <div class="sortContainer">
      <cfset storycounter=1>
        <input type="hidden" name="StoryCount" value="<cfoutput>#qGetStories.RecordCount#</cfoutput>" />
        <cfloop query="qGetStories">
          <cfset storyidinput='StoryID' & #storycounter# />
          <div class="draggable" draggable="true">
            <cfoutput>#qGetStories.StoryTitle#</cfoutput>
            <input class="sortable" type="hidden" name="<cfoutput>#storyidinput#</cfoutput>"
              value="<cfoutput>#qGetStories.Storyid#</cfoutput>" />
          </div>
          <cfset storycounter=storycounter + 1 />
        </cfloop>
    </div><BR>
    <button class="btn btn-secondary btn-floating" onclick="getNewOrder()" type="submit">
      <i class="fas fa-check"></i>
    </button>
  </form>


  <BR><BR><BR><BR><BR><BR><BR>
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
    <script type="text/javascript" src="/js/s4u.js"></script>
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

              $('.mdb-select').materialSelect();

              $('.switch input[type="checkbox"]').on('change', function () {
                if (this.checked) {
                  $("#TimeCapsule").removeClass("invisible");
                  $("#tcLabel").removeClass("invisible");
                } else {
                  var str = $("#TimeCapsule").val();
                  $("#TimeCapsule").addClass("invisible");
                  $("#tcLabel").addClass("invisible");
                };
              });
              // End of document ready
            });
    </script>


</body>

</html>