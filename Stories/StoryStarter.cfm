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
<cfset session.starter = 'story'>
<!--- Start Nav --->
<cfinclude template="/TopNavSmall.cfm">



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
            <a class="nav-link active pt-3" href="/stories/storystarter.cfm">
              Memory
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link pt-3" href="/stories/InterviewStoryStarter.cfm">
              Interview
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link pt-3" href="/stories/recipeStoryStarter.cfm">
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

      <hr>


      <cfif session.StoryID IS 0>
        <cfset storyUser=#session.UserID#>
          <cfelse>
            <cfset storyUser=#qMyStory.UserID#>
      </cfif>
  
      <cfif storyUser IS #session.UserID# AND session.storyID IS 0>
        <!-- Button trigger modal -->
        <button id="featureBtn" type="button" class="btn btn-primary d-none" data-toggle="modal"
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
              <div class="modal-body" id="modalDiv"></div>
            </div>
          </div>
        </div>
      </cfif>
  
      <!--- Beginning of media modal --->
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
  
                <Label class="btn btn-sm btn-primary" title="Add a Video">
                  <i class="fas fa-video fa-lg"></i>
                  <input type="file" style="display: none;" name="selectedVFile" accept="video/*" capture="capture"
                    value="Save Video" multiple="multiple" id="fileV">
                </Label>
  
                <Label class="btn btn-sm btn-primary" title="Add a Picture">
                  <i class="fas fa-camera fa-lg"></i>
                  <input type="file" style="display: none;" name="selectedIFile" accept="image/*" capture="capture"
                    value="Save Images" multiple="multiple" id="fileI">
                </Label>
  
                <button type="submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-primary">
                  <i class="fas fa-check"></i>
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
                <!--- Start Gallery --->
                <div class="container">
                  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4" id="pageDiv">
                
                  </div>
                </div>
              
          <div class="row mt-2">
            <div class="col-12">
              <buton class="btn btn-secondary font-weight-bold" data-toggle="modal" data-target="#modalLoginForm" id="mediaBtn">
                ADD PICTURE / VIDEO
              </button>
            </div>
          </div>
      <!--- Story Content --->
      <form action="/stories/StoryStarterAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
  
        <div class="row">
          <div class="col-6">
            <label>Title</label>
            <input class="s4uTextArea form-control" type="text" name="StoryTitle">
          </div>
    
          <div class="col-6">
            <label>Share with: </label>
            <select class="form-control" name="CircleID" id="CircleID">
              <cfoutput>
                <cfloop query="qGetCircles">
                  <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ session.MyCircleID>Selected</cfif>>
                    #qGetCircles.CircleName#
                  </option>
                </cfloop>
              </cfoutput>
            </select>
            <cfinclude template="/circles/CircleExceptions.cfm">
          </div>
        </div>
  
        <label class="mt-2">Memory</label>
        <textarea name="StoryText" id="StoryText"></textarea>
  
        <script>
          CKEDITOR.replace('StoryText', {
            extraPlugins: 'autogrow',
            autoGrow_minHeight: 250,
            autoGrow_maxHeight: 80,
            autoGrow_bottomSpace: 00,
            removePlugins: 'resize'
          });
        </script>
                <BR>  



        <hr>

        <div class="row mt-2">
          <div class="col-12 text-right">               
            <button class="btn btn-primary font-weight-bold" type="submit">
              Create
            </button>
            <a href="/HomePage.cfm" class="btn btn-alert">
              Cancel
            </a>
          </div>
        </div>
  
        <input type="hidden" name="StoryTypeID" value="1">
  
      </form>
    </div>


    <br><br><br><br><br><br>

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
    </script>
  </body>
</html>