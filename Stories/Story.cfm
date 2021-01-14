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
  
  </head>
    <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
    <cfajaxproxy cfc="cfc.BookContent" jsclassname="BookContent" />
    <cfajaxproxy cfc="cfc.FeatureImg" jsclassname="FeatureImg" />

    <body>
<!--- Start Nav --->
  <cfinclude template="/topNavSmall.cfm">
<cfset gallerymode = 'view'>
<cfset session.StoryID = url.StoryID>

<cfquery name="qMyStory">
                Select StoryTbl.*, UserDisplayName, UserMediaLoc
                from StoryTbl
                left join UserTbl 
                on StoryTbl.UserID = UserTbl.UserID
                where StoryTbl.StoryID = #session.Storyid#
</cfquery>
<body>

<cfoutput>
  <div class="col-md-10 offset-md-1">
<cfif len(qMyStory.Interviewee)>
  <h2>Interview of #qMystory.Interviewee#: <BR>
  #qMyStory.StoryTitle# </h2> 
  <cfelse>
  <cfif qMyStory.StoryTypeID IS 4>
  <h2>#qMyStory.StoryTitle# Tradition</h2> 
  <cfelse>
  <h2>#qMyStory.StoryTitle# </h2> 
  </cfif>
</cfif>
<h3 class="h3-responsive">
  <img src="#qMyStory.UserMediaLoc#" class="rounded-circle z-depth-0" alt="avatar image" height="40">
      By #qMyStory.UserDisplayName#
</h3>


<div class="btn-group" role="group" aria-label="Basic example">
<cfif qMyStory.UserID IS #session.UserID#>
      <a class="btn btn-secondary" href="/stories/editpage.cfm?StoryID=#qMyStory.StoryID#&gotoPage=EditStory"
      title="Edit this page">
      <i class="far fa-edit icon-align-center"></i></a>
      <a class="btn btn-secondary" href="/stories/DeleteStory.cfm?StoryID=#qMyStory.StoryID#" 
    title="Delete this page"
      name="Delete Page" onclick="return confirm('Are you sure you want to delete this item?');">
      <i class="fas fa-minus-circle icon-align-center"></i></a> <BR>
</cfif>

      <a class="btn btn-secondary" href="/books/AddToBooks.cfm?StoryID=#qMyStory.StoryID#"
      title="Add this page to a book or time capsule">
      <i class="fas fa-plus icon-align-center"></i></a><BR>
</div>
<cfset setFeatureBtn = 'OFF'>
<BR><BR>
</div>
<cfinclude template="StoryGallery.cfm">
<div class="col-md-10 offset-md-1">
<div class="s4u-StoryText">

    <cfif qMyStory.StoryTypeID is 3>
    Ingredients: <BR />
    #trim(qMyStory.StoryIngredients)#<BR>
    Directions: <BR />
    #qMyStory.StoryText#
    <BR>
    <cfelse>
    <BR />
    <p>
    #qMyStory.StoryText#
    <BR>
    </p>
    </cfif>

</div>

<div id="storyBookList" class="justify-content-md-center col-md-auto">

</div>
 Created on  (#dateformat(qMyStory.StoryDate, "mmm d yyyy")# #timeformat(qMyStory.StoryDate, "h:mmtt")#)
</cfoutput>

<br /><br /><br /><br /><br /><br />
</div>
<!---         Start Footer --->
      <cfinclude template="/FooterMobile.cfm">

</body>
<!-- JQuery -->
    <!-- SCRIPTS -->

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
    <script type="text/javascript" src="/js/bookContent.js"></script>
    <script type="text/javascript" src="/js/featureImg.js"></script>
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
          $("#mdb-lightbox-ui").load("/mdb-addons/mdb-lightbox-ui.html");
        });

        // Check Notifications
        newPages(<cfoutput>#session.userid#, '#session.LastPageView#', '#session.LastBookView#', '#session.LastTCView#'</cfoutput>);
        getStoryBooks(<cfoutput>#session.storyID#, #session.userID#</cfoutput>);
        featureMedia(<cfoutput>#session.storyID#</cfoutput>);
        // End of document ready
      });
    </script>


</body>

</html>


