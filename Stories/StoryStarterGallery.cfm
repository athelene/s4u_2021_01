<cfajaxproxy cfc="cfc.FeatureImg" jsclassname="FeatureImg" />


<!--- Start media list --->
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

<script type="text/javascript" src="/js/newFeatureImg.js"></script>

          <script type="text/javascript">
            $(document).ready(function () {

                  updateMedia( 0,<cfoutput>#session.UserID#</cfoutput>);
                      // End of document ready
          </script>