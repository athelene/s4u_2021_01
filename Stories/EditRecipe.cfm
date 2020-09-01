<!--- START FORM FOR Other pages --->
<!--- Display Media   --->
<br>
<cfinclude template="StoryGallery.cfm">

    <form action="/stories/EditMediaAction.cfm" enctype="multipart/form-data" method="post">
        <div>
            <div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header text-center">
                            <h4 class="modal-title w-100 font-weight-bold">Add Media</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"
                                title="Add Media">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-footer d-flex justify-content-center">

                            <Label class="btn btn-sm btn-secondary" title="Add a Video">
                                <i class="fas fa-video fa-lg"></i>
                                <input type="file" style="display: none;" name="selectedVFile" accept="video/*"
                                    capture="capture" value="Save Video" multiple="multiple" id="fileV">
                            </Label>

                            <Label class="btn btn-sm btn-secondary" title="Add a Picture">
                                <i class="fas fa-camera fa-lg"></i>
                                <input type="file" style="display: none;" name="selectedIFile" accept="image/*"
                                    capture="capture" value="Save Images" multiple="multiple" id="fileI">
                            </Label>

                            <button type="Submit" Name="SaveFile" value="Save Changes" class="btn btn-sm btn-secondary">
                                <i class="fas fa-check"></i>
                            </button>

                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <a href="" class="btn btn-default btn-rounded mb-4" data-toggle="modal" data-target="#modalLoginForm">
                    <i class="fas fa-video"></i> / <i class="fas fa-camera"></i></a>
    </form>

    <form action="/stories/EditStoryAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
        <!---     Story Content --->
        <h4>Recipe page title:</h4><BR>
        <input class="s4uTextArea form-control" type="text" name="StoryTitle"
            value="<cfoutput>#trim(qMyStory.StoryTitle)#</cfoutput>" placeholder="Page Title"><br>


        <H3>Ingredients:</h3>
        <textarea id="recipe" name="STORYINGREDIENTS"><cfoutput>#trim(qMyStory.STORYINGREDIENTS)#</cfoutput></textarea>
        <script>
            CKEDITOR.replace('recipe', {
                extraPlugins: 'autogrow',
                autoGrow_minHeight: 100,
                autoGrow_maxHeight: 100,
                autoGrow_bottomSpace: 00,
                removePlugins: 'resize'
            });
        </script>
        <H3>Directions:</h3>
        <textarea id="editor2" name="StoryText"><cfoutput>#trim(qMyStory.StoryText)#</cfoutput></textarea>
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
        <input type="hidden" name="StoryID" value="<cfoutput>#qMyStory.StoryID#</cfoutput>">

        <div>
            <BR>
            <h4>Share with: </h4>
            <select class="mdb-select md-form colorful-select dropdown-secondary" name="CircleID" id="CircleID">
                <cfoutput>
                    <cfloop query="qGetCircles">
                        <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ qMyStory.CircleID>Selected
                            </cfif>>
                            #qGetCircles.CircleName#
                        </option>
                    </cfloop>
                </cfoutput>
            </select>

            <cfinclude template="/circles/CircleExceptions.cfm">

        </div>


        <button class="btn btn-secondary btn-floating" type="submit">
            <i class="fas fa-check"></i>
        </button>

        </div>
    </form>
    <BR><BR><BR><BR><BR><BR><BR>
    <cfinclude template="/FooterMobile.cfm">

        </nav>
        </footer>
        </form>