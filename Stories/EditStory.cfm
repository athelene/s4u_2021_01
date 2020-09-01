<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="/css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

  <script src="/ckeditor/ckeditor.js"></script>
</head>
<cfajaxproxy cfc="cfc.mem" jsclassname="mem" />
<cfajaxproxy cfc="cfc.exc" jsclassname="exc" />
<cfajaxproxy cfc="cfc.add" jsclassname="add" />
<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
<cfajaxproxy cfc="cfc.FeatureImg" jsclassname="FeatureImg" />

<cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

<!--- Start Nav --->
<cfinclude template="/TopNavSmall.cfm">


  <cfset session.StoryID=#url.StoryID#>
    <cfquery name="qMyStory">
      Select * from StoryTbl
      where storyID = #session.storyID# and UserID = #session.userid#
    </cfquery>

    <cfquery name="qGetCircles">
      Select * from CircleTbl
      where CircleOwner = #session.Userid#
      Order By CircleSort
    </cfquery>

    <cfinclude template="StoryGallery.cfm">

      <!--- START FORM FOR INTERVIEW --->
      <!--- __________________________________________________________________________________________ --->
      <cfif qMyStory.StoryTypeID EQ 2>
        <form action="/stories/EditStoryAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
          <div>
            Interview of: <input type="text" value="<cfoutput>#trim(qMyStory.Interviewee)#</cfoutput>"
              name="Interviewee" placeholder="Enter the name of the person interviewed"> <BR><BR>
            <textarea disabled cols="100" rows="5"
              id="StoryTitle"><cfoutput>#trim(MyStory.StoryTitle)#</cfoutput></textarea>
            <input type="hidden" name="StoryTitle" value="<cfoutput>#trim(qMyStory.StoryTitle)#</cfoutput>">
          </div>
          <H3>Additional Notes:</h3>
          <textarea name="StoryText" cols="100" rows="5"
            id="StoryText"><cfoutput>#trim(qMyStory.StoryText)#</cfoutput></textarea>
          <script>
            // Replace the <textarea id="editor1"> with a CKEditor
            // instance, using default configuration.
            CKEDITOR.replace('StoryText');
          </script>

          <input type="hidden" name="StoryTypeID" value="2">
          <input type="hidden" name="StoryID" value="<cfoutput>#qMyStory.StoryID#</cfoutput>">

          <BR>
          <div class="s4u-circle-set">
            <BR>
            <select class="mdb-select md-form colorful-select dropdown-secondary" name="CircleID"
              onChange="getMembers(this.value)">

              <cfoutput>
                <cfloop query="qGetCircles">
                  <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ qMyStory.CircleID>Selected
      </cfif>>#qGetCircles.CircleName#
      </option>
      </cfloop>
      </cfoutput>
      </select>
      <label class="mdb-main-label">Share with circle:</label>
      <div id="MemDiv">

      </div>

      <button type="Submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
        <i class="fas fa-check"></i>
      </button>

      </form>
      </div>

      <!--- END FORM FOR INTERVIEW --->
      <!--- _______________________________________________________________________________________________________________ --->
      <!--- START FORM FOR RECIPE --->
      <cfelseif qMyStory.StoryTypeID EQ 3>

        <form action="/stories/EditStoryAction.cfm" enctype="multipart/form-data" method="post" name="simpleAJAX">

          <div>
            <input class="s4uTextArea" type="text" name="StoryTitle"
              value="<cfoutput>#trim(qMyStory.StoryTitle)#</cfoutput>"><br>
            <H3>Ingredients:</h3>
            <textarea id="editor1" name="STORYINGREDIENTS" rows="4"
              cols="100"><cfoutput>#trim(qMyStory.STORYINGREDIENTS)#</cfoutput></textarea>
            <script>
              // Replace the <textarea id="editor1"> with a CKEditor
              // instance, using default configuration.
              CKEDITOR.replace('editor1');
            </script>
            <H3>Directions:</h3>
            <textarea id="editor2" name="StoryText" cols="100"
              rows="5"><cfoutput>#qMyStory.StoryText#</cfoutput></textarea>
            <script>
              // Replace the <textarea id="editor1"> with a CKEditor
              // instance, using default configuration.
              CKEDITOR.replace('editor2');
            </script>
          </div>
          <input type="hidden" name="StoryTypeID" value="3">
          <input type="hidden" name="StoryID" value="<cfoutput>#qMyStory.StoryID#</cfoutput>">


          <BR>
          <Label class="btn btn-secondary" title="Add a Video">
            <i class="fas fa-video fa-lg"></i>
            <input type="file" style="display: none;" name="selectedVFile" accept="video/*" capture="capture"
              value="Save Video" multiple="multiple" id="fileV">
          </Label>

          <Label class="btn btn-secondary" title="Add a Picture">
            <i class="fas fa-camera fa-lg"></i>
            <input type="file" style="display: none;" name="selectedIFile" accept="image/*" capture="capture"
              value="Save Images" multiple="multiple" id="fileI">
          </Label>

          <div class="s4u-circle-set">
            <BR>
            <select class="mdb-select md-form colorful-select dropdown-secondary" name="CircleID"
              onChange="getMembers(this.value)">

              <cfoutput>
                <cfloop query="qGetCircles">
                  <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ qMyStory.CircleID>Selected</cfif>
                    >#qGetCircles.CircleName#
                  </option>
                </cfloop>
              </cfoutput>
            </select>
            <label class="mdb-main-label">Share with circle:</label>
          </div>

          <div id="MemDiv">

          </div>


          <button type="Submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
            <i class="fas fa-check"></i>
          </button>

        </form>
        </div>

        <!--- END FORM FOR RECIPE --->
        <cfelse>
          <!--- __________________________________________________________________________________________________________________________ --->
          <!--- START FORM FOR ALL OTHERS --->
          <!--- Display Media   --->
          <br>

          <form action="/stories/EditStoryAction.cfm" enctype="multipart/form-data" method="post" name="simpleAJAX">
            <!-- Default input -->

            <div>
              <input class="s4uTextArea form-control" type="text" name="StoryTitle"
                value="<cfoutput>#trim(qMyStory.StoryTitle)#</cfoutput>"><br>

              <H4>Story Text:</h4>
              <textarea name="StoryText" cols="100" rows="5"
                id="StoryText"><cfoutput>#trim(qMyStory.StoryText)#</cfoutput></textarea>
              <script>
                // Replace the <textarea id="editor1"> with a CKEditor
                // instance, using default configuration.
                CKEDITOR.replace('StoryText');
              </script>


              <input type="hidden" name="StoryTypeID" value="1">
              <input type="hidden" name="StoryID" value="<cfoutput>#qMyStory.StoryID#</cfoutput>">
              <Label class="btn btn-secondary">
                <i class="fas fa-video fa-lg"></i> Add Video
                <input type="file" style="display: none;" name="selectedVFile" accept="video/*" capture="capture"
                  value="Save Video" id="fileV">
              </Label>

              <Label class="btn btn-secondary">
                <i class="fas fa-camera fa-lg"></i> Add Pictures
                <input type="file" style="display: none;" name="selectedIFile" accept="image/*" capture="capture"
                  value="Save Images" id="fileI">
              </Label>

              <div class="s4u-circle-set">
                <BR>
                <select class="mdb-select md-form colorful-select dropdown-secondary" name="CircleID"
                  onChange="getMembers(this.value)">

                  <cfoutput>
                    <cfloop query="qGetCircles">
                      <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ qMyStory.CircleID>Selected
                        </cfif>>#qGetCircles.CircleName#
                      </option>
                    </cfloop>
                  </cfoutput>
                </select>
                <label class="mdb-main-label">Select a circle to share this page with:</label>

                <div id="MemDiv">

                </div>


                <button type="Submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
                  <i class="fas fa-check"></i>
                </button>

              </div>

          </form>

          </CFIF>

          <cfinclude template="/footer.cfm" />

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


                  // Check Notifications
                  newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                    '#session.LastTCView#' < /cfoutput>);
                    getMedia( < cfoutput > #session.StoryID#, #session.UserID# < /cfoutput>);
                      // updateMedia(<cfoutput>#session.storyID#, #session.userID#</cfoutput>);

                      // Set up MDB Select
                      $('.mdb-select').materialSelect();


                      // End of document ready
                    });
          </script>


          </body>

</html>