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
  <link href="css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">
</head>
  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
  <cfajaxproxy cfc="cfc.StoryFilter" jsclassname="StoryFilter" />

    <!--- Update LastPage Field --->
    <cfquery name="qSetLastBookView">
      Update Usertbl
      SET LastPageView = GetDate()
      WHERE userid = #session.userID#
    </cfquery>

<body>
  <!--- Start Nav --->

    <div class="btn-group bg-light" data-toggle="buttons">
      <label class="btn btn-secondary btn-rounded form-check-label active">
        <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked
          onClick="getAllStories(<cfoutput>#session.Userid#</cfoutput>)">
        All Pages
      </label>
      <label class="btn btn-secondary btn-rounded form-check-label">
        <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off"
          onClick="getMyStories(<cfoutput>#session.Userid#</cfoutput>)"> Only My Pages
      </label>
      <label class="btn btn-secondary btn-rounded form-check-label">
        <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off"
          onClick="getOtherStories(<cfoutput>#session.Userid#</cfoutput>)"> Other People's Pages
      </label>
    </div>
    <!-- Material checked -->
    <div class="switch sortContainer">
      <span class="sortContainer">
        Stories <label>
          <input type="checkbox" checked id="showStories" value="on" class="bg-primary">
          <span class="lever"></span>
        </label>
      </span>
      <span class="sortContainer">
        <label>
          Interviews
          <input type="checkbox" checked id="showInterviews" value="on">
          <span class="lever"></span>
        </label>
      </span>
      <span class="sortContainer">
        <label>
          Recipes
          <input type="checkbox" checked id="showRecipes" value="on">
          <span class="lever"></span>
        </label>
      </span>
      <span class="sortContainer">
        <label>
          Traditions
          <input type="checkbox" checked id="showTraditions" value="on">
          <span class="lever"></span>
        </label>
      </span>
    </div>

    <!--- <div class="list-group s4u-FeedBlock "> --->

    <cfoutput>
      <div id="StoryDiv">

      </div>

    </cfoutput>

    <BR><BR><BR><BR>


      <!-- Optional JavaScript -->
      <script type="text/javascript" src="/js/s4u.js"></script>
      <script type="text/javascript" src="/js/storyFilters.js"></script>
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

              // Check Notifications
              newPages(<cfoutput>#session.userid#,'#session.LastPageView#','#session.LastBookView#',
                '#session.LastTCView#'</cfoutput>);
              getAllStories(<cfoutput>#session.userid#</cfoutput>);
                  // End of document ready
                });
      </script>


</body>

</html>