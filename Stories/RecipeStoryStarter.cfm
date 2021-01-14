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
</head>

<cfajaxproxy cfc="cfc.session" jsclassname="sessionUser" />
<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
<cfajaxproxy cfc="cfc.mem" jsclassname="mem" />
<cfajaxproxy cfc="cfc.exc" jsclassname="exc" />
<cfajaxproxy cfc="cfc.add" jsclassname="add" />
<cfajaxproxy cfc="cfc.FeatureImg" jsclassname="FeatureImg" />

<cfset session.storyid = 0>
<cfset session.starter = 'recipe'>

<!--- Start Nav --->
<cfinclude template="/TopNavSmall.cfm">

  <!--- Display Media   --->
  <cfset session.StoryID=0>
    <cfset mode="start">

      <cfquery name="qGetCircles">
        Select * from CircleTbl
        where CircleOwner = #session.Userid#
        Order By CircleSort
      </cfquery>

      <body> 
        <div class="card card-body col-6 offset-3">
          <div class="mb-2">
            <ul class="nav nav-pills justify-content-center nav-primary">
              <li class="nav-item">
                <a class="nav-link pt-3" href="/stories/storystarter.cfm">
                  Memory
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link pt-3" href="/stories/InterviewStoryStarter.cfm">
                  Interview
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link active pt-3" href="/stories/recipeStoryStarter.cfm">
                  Recipe
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link pt-3" href="/stories/TraditionStoryStarter.cfm">
                  Tradition
                </a>
              </li>
            </ul>
          </div> 

          <cfif session.StoryID IS 0>
            <cfset storyUser=#session.UserID#>
              <cfelse>
                <cfset storyUser=#qMyStory.UserID#>
          </cfif>

          <cfif storyUser IS #session.UserID# AND session.storyID IS 0>
            <!-- Button trigger modal -->
            <button id="featureBtn" type="button" class="btn btn-secondary" data-toggle="modal"
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
        

        <!---     Beginning of media modal --->
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

                  <button type="submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
                    <i class="fas fa-check"></i>
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>


        <!---     Story Content --->
        <form action="/stories/StoryStarterAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
          <BR>
          <input class="s4uTextArea form-control" type="text" name="StoryTitle" placeholder="Recipe Title"><br>

          <div class="text-center">
            <a href="" class="btn btn-secondary btn-rounded mb-4" data-toggle="modal" data-target="#modalLoginForm">
              <i class="fas fa-video"></i> / <i class="fas fa-camera"></i></a>
          </div>

          <br>
          <H3>Ingredients:</h3>
          <textarea id="StoryIngredients" name="StoryIngredients" cols="100" rows="5"></textarea>
          <script>
            CKEDITOR.replace('StoryIngredients', {
              extraPlugins: 'autogrow',
              autoGrow_minHeight: 100,
              autoGrow_maxHeight: 100,
              autoGrow_bottomSpace: 00,
              removePlugins: 'resize'
            });
          </script>
          </div>

          <div>
            <H3>Directions:</h3>
            <textarea id="StoryText" name="StoryText" cols="100" rows="5"></textarea>
            <script>
              CKEDITOR.replace('StoryText', {
                extraPlugins: 'autogrow',
                autoGrow_minHeight: 100,
                autoGrow_maxHeight: 100,
                autoGrow_bottomSpace: 00,
                removePlugins: 'resize'
              });
            </script>

            <input type="hidden" name="StoryTypeID" value="3">
          </div>


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
      </div>
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
          <script type="text/javascript" src="/js/newFeatureImg.js"></script>
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

                      });
                      // End of document ready
          </script>
  </body>
</html>