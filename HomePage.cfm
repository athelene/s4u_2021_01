<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="/favicon-16x16.png" type="image/png" size="16x16">
  <link rel="icon" href="/favicon-32x32.png" type="image/png" size="32x32">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="/css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

  <cfajaxproxy cfc="cfc.user" jsclassname="user" />
  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
  <cfajaxproxy cfc="cfc.StoryFilter" jsclassname="StoryFilter" />
  <cfajaxproxy cfc="cfc.qcAnswers" jsclassname="qcAnswers" />

</head>
<cfquery name="qCheckUserInfo">
  Select UserFirst, UserLast, UserDisplayName 
  from UserTbl 
  where userID = #session.userID#
</cfquery>

<cfif qCheckUserInfo.UserFirst IS ''>
<cflocation url = "/users/EditUserProfile.cfm">
</cfif>
<cfif qCheckUserInfo.UserLast IS ''>
<cflocation url = "/users/EditUserProfile.cfm">
</cfif>
<cfif qCheckUserInfo.UserDisplayName IS ''>
<cflocation url = "/users/EditUserProfile.cfm">
</cfif>
<cfquery name="qGetQCToday">
  select ViewpointID, Viewpointq
  from ViewpointTbl
  where ViewpointDate = '#dateformat(session.Todayis, "YYYY-MM-DD")#'
</cfquery>

<cfif qGetQCToday.RecordCount LT 1>
  <cfset todaysQC=1>
    <cfelse>
      <cfset todaysQC=qGetQCToday.ViewPointID>
</cfif>

<cfquery name="qSetEveryoneCircle">
  Select CircleID from CircleTbl
  where CircleOwner = #session.UserID# AND
  CircleSort = '0'
</cfquery>
<cfset session.myCircleID=qSetEveryoneCircle.CircleID>


  <body>
    <cfinclude template="/TopNavSmall.cfm">
      <cfoutput>
        <cfif todaysQC IS 1>
          <div class="VPAnswerText">
            <p id="tooltip1"><img src="/img/QC.pjg" style="width:3.5em; height:3.5em;" />
              <span>Introduction to HTML and CSS: tooltip with extra text</span></p>
            No Quick Connect question is available today. <BR>
            <a class="btn bg-primary text-white" href="/Admin/SubmitQuickConnect.cfm">
              Click here to submit your idea and a chance to win a $10 credit!</a>
          </div>
          <cfelse>
            <div class="viewpoint bg-secondary">

              <div id="myAnswerDiv" class="md-form md-bg col-xs-8 bg-secondary ">
                <div class="img__wrap">
                  <img class="img_img" src="/img/QC.jpg" />
                  <p class="img__description">Quick Connect: Stay in touch daily with your circle - it's quick and fun!</p>
                </div>

                <span class="QCText">#qGetQCToday.Viewpointq#
                </span>

                <input type="text" id="QCAnswer" class="InputQCText" placeholder="Your Answer" required
                  style="display:none">
                <button id="saveQCBtn" class="btn-sm"
                  onclick="saveMyAnswer(<cfoutput>#session.UserID#, #qGetQCToday.ViewPointID#</cfoutput>)"
                  style="display:none">
                  <i class="fas fa-check"></i>
                </button>
                <button id="editQCBtn" class="btn-sm"
                  onclick="editMyAnswer(<cfoutput>#session.UserID#, #qGetQCToday.ViewPointID#</cfoutput>)"
                  style="display:none">
                  <i class="fas fa-pen"></i>
                </button>
                <button id="saveEditQCBtn" class="btn-sm"
                  onclick="saveMyEdit(<cfoutput>#session.UserID#, #qGetQCToday.ViewPointID#</cfoutput>)"
                  style="display:none">
                  <i class="fas fa-check"></i>
                </button>


              </div>

              <!--Accordion wrapper-->
              <div class="accordion md-accordion bg-secondary" id="accordionEx" role="tablist"
                aria-multiselectable="true">

                <!-- Accordion card -->
                <div class="card">
                <cfset dispDiv = 'qcListDiv' & #qGetQCToday.ViewPointID#>
                  <!-- Card header -->
                  <div class="card-header" role="tab" id="headingOne1"
                    onclick="getQCAnswers(<cfoutput>#qGetQCToday.ViewpointID#, #session.mycircleID#, #session.UserID#</cfoutput>)">
                    <a data-toggle="collapse" data-parent="##accordionEx" href="##collapseOne1" aria-expanded="true"
                      aria-controls="collapseOne1">
                      <h6 class="mb-0">
                        See Answers<i class="fas fa-angle-down rotate-icon"></i>
                      </h6>
                    </a>
                  </div>

                  <!-- Card body -->
                  <div id="collapseOne1" class="collapse" role="tabpanel" aria-labelledby="headingOne1"
                    data-parent="##accordionEx">
                    <div class="card-body" id="#dispDiv#">

                    </div>
                  </div>

                </div>
                <!-- Accordion card -->
              </div>
              <!-- Accordion wrapper -->

            </div>
        </cfif>
      </cfoutput>
      <br />
<!--- Start Filtering section  --->

<!--Accordion wrapper-->
<div class="accordion md-accordion" id="accordionEx1" role="tablist" aria-multiselectable="true">

  <!-- Accordion card -->
  <div class="card">

    <!-- Card header -->
    <div class="card-header" role="tab" id="headingTwo1">
      <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx1" href="#collapseTwo1"
        aria-expanded="false" aria-controls="collapseTwo1">
        <h5 class="mb-0">
           <i class="fas fa-filter"></i>
        </h5>
      </a>
    </div>

    <!-- Card body -->
    <div id="collapseTwo1" class="collapse" role="tabpanel" aria-labelledby="headingTwo1"
      data-parent="#accordionEx1">
      <div class="card-body">
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
      </div>
    </div>

  </div>
  <!-- Accordion card -->
 
</div>
<!-- Accordion wrapper -->

<!--- End Filtering Section --->
<!--- Start pages list  --->

    <cfoutput>

      <div id="StoryDiv">

      </div>

    </cfoutput>
<!--- End pages List --->
      <br /><br /><br /><br /><br /><br />

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
<!---         <script type="text/javascript" src="/js/homeFeed.js"></script> --->
        <script type="text/javascript" src="/js/s4u.js"></script>
        <script type="text/javascript" src="/js/badgeUpdates.js"></script>
        <script type="text/javascript" src="/js/quickConnect.js"></script>
        <script type="text/javascript" src="/js/storyFilters.js"></script>
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
                getUserInfo(<cfoutput>#session.userid#</cfoutput>);
                newPages(<cfoutput>#session.userid#,'#session.LastBookView#'</cfoutput>);
                getMyAnswer(<cfoutput> #todaysQC#, #session.userID# </cfoutput>);
                getAllStories();
                        // End of document ready
                      });
        </script>


  </body>

</html>