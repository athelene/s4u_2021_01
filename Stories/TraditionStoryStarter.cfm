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

  <script src="/ckeditor/ckeditor.js"></script>

</head>

<cfajaxproxy cfc="cfc.session" jsclassname="sessionUser" />
<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
<cfajaxproxy cfc="cfc.cir" jsclassname="cir" />
<cfajaxproxy cfc="cfc.mem" jsclassname="mem" />
<cfajaxproxy cfc="cfc.exc" jsclassname="exc" />
<cfajaxproxy cfc="cfc.add" jsclassname="add" />
<cfajaxproxy cfc="cfc.tradition" jsclassname="tradition" />
<cfajaxproxy cfc="cfc.FeatureImg" jsclassname="FeatureImg" />

<cfset session.storyid = 0>
<cfset session.starter = 'tradition'>

<body>
<!--- Start Nav --->
<cfinclude template="/TopNavSmall.cfm">

  <cfquery name="qGetCircles">
    Select * from CircleTbl
    where CircleOwner = #session.Userid#
    Order By CircleSort
  </cfquery>

  <div class="HomeOutlineDiv">
    <ul class="nav nav-pills nav-fill">
      <li class="nav-item">
        <a class="nav-link" href="/stories/storystarter.cfm">
          Story
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/stories/InterviewStoryStarter.cfm">
          Interview
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/stories/recipeStoryStarter.cfm">
          Recipe
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="/stories/TraditionStoryStarter.cfm">
          Tradition
        </a>
      </li>
    </ul>
  </div>

<!--- Start Gallery --->
<div class="container">
  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4" id="pageDiv">

  </div>
</div>

<cfif session.StoryID IS 0>
  <cfset storyUser=#session.UserID#>
    <cfelse>
      <cfset storyUser=#qMyStory.UserID#>
</cfif>

<cfif storyUser IS #session.UserID# AND session.storyID IS 0>
  <!-- Button trigger modal -->
  <BR><BR><BR><button id="featureBtn" type="button" class="btn btn-secondary" data-toggle="modal"
    data-target="#featureModal" onclick="updateMedia(<cfoutput>#session.UserID#</cfoutput>)">
    Select Feature Media
  </button>

  <!-- Modal -->
  <div class="modal fade" id="featureModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Click to Select Featured Media</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <div class="modal-body" id="modalDiv">

        </div>

      </div>

    </div>
  </div>
</cfif>


</div>

<!--- End Gallery --->

    <!--- Beginning of media Modal --->
    <div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">Add Media</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" title="Add Media">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>


          <form action="/stories/saveMedia.cfm" name="saveMedia" enctype="multipart/form-data" method="post">
            <div class="modal-footer d-flex justify-content-center">

              <Label class="btn btn-sm btn-secondary" title="Add a Video">
                <i class="fas fa-video fa-lg"></i>
                <input type="file" style="display: none;" name="selectedVFile" accept="video/*" capture="capture"
                  value="Save Video" multiple="multiple" id="fileV">
              </Label>

              <Label class="btn btn-sm btn-secondary" title="Add a Picture">
                <i class="fas fa-camera fa-lg"></i>
                <input type="file" style="display: none;" name="selectedIFile" accept="image/*" capture="capture"
                  value="Save Images" multiple="multiple" id="fileI">
              </Label>

              <button type="Submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
                <i class="fas fa-check"></i>
              </button>

            </div>
          </form>
        </div>
      </div>
    </div>


    <!---     end of media modal --->

    <form action="/stories/StoryStarterAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
      <div>

        <!--- Beginning of media Modal --->
        <div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
          aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header text-center">
                <h4 class="modal-title w-100 font-weight-bold">Add Media</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" title="Add Media">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>

              <div class="modal-footer d-flex justify-content-center">

                <Label class="btn btn-sm btn-secondary" title="Add a Video">
                  <i class="fas fa-video fa-lg"></i>
                  <input type="file" style="display: none;" name="selectedVFile" accept="video/*" capture="capture"
                    value="Save Video" multiple="multiple" id="fileV">
                </Label>

                <Label class="btn btn-sm btn-secondary" title="Add a Picture">
                  <i class="fas fa-camera fa-lg"></i>
                  <input type="file" style="display: none;" name="selectedIFile" accept="image/*" capture="capture"
                    value="Save Images" multiple="multiple" id="fileI">
                </Label>

                <button type="Submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
                  <i class="fas fa-check"></i>
                </button>

              </div>
            </div>
          </div>
        </div>


        <!---     end of media modal --->

        <!--- Start tradition question modal --->
        <form action="/stories/StoryStarterAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">

          <!-- Full Height Modal Right -->
          <div class="modal fade right" id="fullHeightModalRight" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">

            <!-- Add class .modal-full-height and then add class .modal-right (or other classes from list above) to set a position to the modal -->
            <div class="modal-dialog modal-full-height modal-right" role="document">


              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title w-100" id="myModalLabel">Tradition Suggestions</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="getTradition()">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body" id="traditionDiv">
                  Traditions not available
                </div>
                <div class="modal-footer justify-content-center">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
          <!-- End Tradition Modal -->

          <BR>
          <div class="md-form input-group mb-3">
            <div class="input-group-prepend">
              <button type="button" class="btn btn-md btn-secondary m-0 px-3" title="Tradition suggestions"
                data-toggle="modal" data-target="#fullHeightModalRight">
                <i class="far fa-lightbulb"></i>
              </button>

            </div>
            <input type="text" class="form-control" id="StoryTitle" name="StoryTitle" placeholder="Tradition"
              aria-label="Tradition" aria-describedby="MaterialButton-addon1">
          </div>

          <div class="text-center">
            <a href="" class="btn btn-secondary btn-rounded mb-4" data-toggle="modal" data-target="#modalLoginForm">
              <i class="fas fa-video"></i> / <i class="fas fa-camera"></i></a>
          </div>

          <H4>Text:</h4>
          <textarea id="StoryText" name="StoryText" cols="100" rows="3"></textarea><BR>
          <script>
            CKEDITOR.replace('StoryText', {
              extraPlugins: 'autogrow',
              autoGrow_minHeight: 100,
              autoGrow_maxHeight: 100,
              autoGrow_bottomSpace: 00,
              removePlugins: 'resize'
            });
          </script>

          <input type="hidden" name="StoryTypeID" value="4">


          <div>
            <BR>
            <h4>Share with: </h4>
            <select class="mdb-select md-form colorful-select dropdown-secondary" name="CircleID" id="CircleID">
              <cfoutput>
                <cfloop query="qGetCircles">
                  <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ session.MyCircleID>Selected
                    </cfif>>
                    #qGetCircles.CircleName#
                  </option>
                </cfloop>
              </cfoutput>
            </select>

            <cfinclude template="/circles/CircleExceptions.cfm">

          </div>


          <div class="text-center">

            <button class="btn btn-secondary btn-floating" type="submit">
              <i class="fas fa-check"></i>
            </button>

          </div>
        </form>
        <BR><BR><BR><BR><BR><BR><BR>
        <cfinclude template="/FooterMobile.cfm">
  </body>
          <!-- JQuery -->
          <script type="text/javascript" src="/js/jquery.min.js"></script>
          <!-- Bootstrap tooltips -->
          <script type="text/javascript" src="/js/popper.min.js"></script>
          <!-- Bootstrap core JavaScript -->
          <script type="text/javascript" src="/js/bootstrap.min.js"></script>
          <!-- MDB core JavaScript -->
          <script type="text/javascript" src="/js/mdb.min.js"></script>

          <script type="text/javascript" src="/js/s4u.js"></script>
          <script type="text/javascript" src="/js/badgeUpdates.js"></script>
          <script type="text/javascript" src="/js/newFeatureImg.js"></script>
          <script type="text/javascript" src="/js/traditionList.js"></script>
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

                  updateMedia( <cfoutput>#session.UserID#</cfoutput>);

                      $('.mdb-select').materialSelect();
                  getTradition();
                      });
                      // End of document ready
          </script>

          </body>

</html>