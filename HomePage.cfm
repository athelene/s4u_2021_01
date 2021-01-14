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
    <link rel="stylesheet" href="/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/assets/css/index.css">  
    <!--<link href="/css/mdb.min.css" rel="stylesheet">-->

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
    <cfquery name="qGetQCToday">
      select ViewpointID, Viewpointq
      from ViewpointTbl
      where ViewpointID = 1
    </cfquery>
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
      <div class="container-fluid">
        <div class="row">
          <cfif todaysQC IS 1>
            <!-- No Quick Connect -->
            <div class="col-12 text-primary ml-4">
              No Quick Connect question is available today. <BR>
            </div>

          <cfelse>
            <!-- Quick Connect -->
            <div class="col-12 col-md-6 offset-md-3 col-xl-4 offset-xl-4">
              <div class="viewpoint card card-body" style="position: relative; z-index: 1">

                <div id="myAnswerDiv" class="md-form md-bg col-xs-8">
                  <div class="img__wrap">
                    <h4 class="text-text-primary font-italic mb-3">QUICK<span class="text-secondary font-weight-bold">CONNECT</span></h4>
                  </div>
  
                  <span class="text-dark font-weight-bold">#qGetQCToday.Viewpointq#</span>

                  <input type="text" id="QCAnswer" class="form-control" required
                    style="display:none">
                </div>

                <div class="row mt-2 text-right">
                  <div class="col-12">
                    <button id="saveQCBtn" class="btn btn-primary font-weight-bold"
                      onclick="saveMyAnswer(<cfoutput>#session.UserID#, #qGetQCToday.ViewPointID#</cfoutput>)"
                      style="display:none">
                      ANSWER
                    </button>
    
                    <button id="editQCBtn" class="btn"
                      onclick="editMyAnswer(<cfoutput>#session.UserID#, #qGetQCToday.ViewPointID#</cfoutput>)"
                      style="display:none">
                      <i class="fas fa-pen"></i>
                    </button>

                    <button id="saveEditQCBtn" class="btn"
                      onclick="saveMyEdit(<cfoutput>#session.UserID#, #qGetQCToday.ViewPointID#</cfoutput>)"
                      style="display:none">
                      <i class="fas fa-check"></i>
                    </button>
                  </div>
                </div>
              
                <div class="accordion md-accordion" id="accordionEx" role="tablist"
                  aria-multiselectable="true">
  
                  <cfset dispDiv = 'qcListDiv' & #qGetQCToday.ViewPointID#>
                    <div role="tab" id="headingOne1"
                      onclick="getQCAnswers(<cfoutput>#qGetQCToday.ViewpointID#, #session.mycircleID#, #session.UserID#</cfoutput>)">
                      <a data-toggle="collapse" data-parent="##accordionEx" href="##collapseOne1" aria-expanded="true"
                        aria-controls="collapseOne1">
                        <h6 class="text-muted mb-0 small">See Answers</h6>
                      </a>
                    </div>
  
                    <div id="collapseOne1" class="collapse" role="tabpanel" aria-labelledby="headingOne1"
                      data-parent="##accordionEx">
                      <div class="card-body" id="#dispDiv#"></div>
                    </div>
                </div>
              </div>
            </div>
          </cfif>
        </div>
<!--  START OF FILTER -->

        <div class="row my-2">  
          <div class="col-6 offset-3">
            <div class="card" class="accordion md-accordion" id="accordionEx1" role="tablist" aria-multiselectable="true">
              <div class="card-header pb-1" role="tab" id="headingTwo1">
                <a class="collapsed text-decoration-none" data-toggle="collapse" data-parent="##accordionEx1" href="##collapseTwo1" aria-expanded="false" aria-controls="collapseTwo1">
                  <h5 class="text-text-secondary text-center">
                    <i class="fas fa-filter"></i>
                  </h5>
                </a>
              </div>

              <div id="collapseTwo1" class="collapse" role="tabpanel" aria-labelledby="headingTwo1"
                data-parent="##accordionEx1">
<!-- OLD FILTER TOP BUTTONS
                <div class="text-center mt-2">
                  <ul class="nav nav-pills justify-content-center nav-primary pt-2">
                    <li class="nav-item">  
                      <label class="btn btn-outline-text-primary form-check-label active">
                        <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked
                          onClick="getAllStories(<cfoutput>#session.Userid#</cfoutput>)">
                        All
                      </label>
                    </li>
                    <li class="nav-item">
                      <label class="btn btn-outline-text-primary form-check-label">
                        <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off"
                          onClick="getMyStories(<cfoutput>#session.Userid#</cfoutput>)"> Mine
                      </label>
                    </li>
                    <li class="nav-item">
                      <label class="btn btn-outline-text-primary form-check-label">
                        <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off"
                          onClick="getOtherStories(<cfoutput>#session.Userid#</cfoutput>)"> Others
                      </label>
                    </li>
                  </ul>
                -->
                
                <!--NEW FILTER BUTTONS -->

                          <div class="row">
          <div class="col-12">               
            <div class="btn-group bg-light" data-toggle="buttons">
              <label class="btn btn-outline-text-primary btn-rounded form-check-label active">
                <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked
                  onClick="getAllStories(<cfoutput>#session.Userid#</cfoutput>)">All
              </label>
              <label class="btn btn-outline-text-primary btn-rounded form-check-label">
                <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off"
                  onClick="getMyStories(<cfoutput>#session.Userid#</cfoutput>)">Mine
              </label>
              <label class="btn btn-outline-text-primary btn-rounded form-check-label">
                <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off"
                  onClick="getOtherStories(<cfoutput>#session.Userid#</cfoutput>)">Others
              </label>
            </div>
          </div>
        </div>


                  <!-- Checkboxes -->
                  <div class="form-check form-check-inline mt-2">
                    <input class="form-check-input" type="checkbox" id="showStories" value="on" checked>
                    <label class="form-check-label" for="showStories">Memories</label>
                  </div>

                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" id="showInterviews" value="on" checked>
                    <label class="form-check-label" for="showInterviews">Interviews</label>
                  </div>

                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" id="showRecipes" value="on" checked>
                    <label class="form-check-label" for="showRecipes">Recipes</label>
                  </div>

                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" id="showTraditions" value="on" checked>
                    <label class="form-check-label" for="showTraditions">Traditions</label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <hr >

        <div class="row">
          <div class="container-fluid px-4">
            <div id="StoryDiv" class="row"></div>
          </div>
        </div>
<br><br><br><br><br><br><br>    
<cfinclude template="/FooterMobile.cfm">

      </div>
    </cfoutput>

    <!-- JQuery -->
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="/js/mdb.min.js"></script>
    <!--- <script type="text/javascript" src="/js/homeFeed.js"></script> --->
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
      // Check Notifications
        newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#'< /cfoutput>);
        getMyAnswer(<cfoutput> #todaysQC#, #session.userID# </cfoutput>);
        getAllStories();
                // End of document ready
              });
    </script>
  </body>
</html>