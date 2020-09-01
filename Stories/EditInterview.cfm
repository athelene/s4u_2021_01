<!--- START FORM FOR INTERVIEW --->
<!--- Display Media   --->
<BR>
<cfinclude template="StoryGallery.cfm">

    <div>
        <form action="/stories/EditMediaAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
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
            </div>
        </form>

        <form action="/stories/EditStoryAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">

            <!---     Story Content --->
            <div class="form-group col-md-6">
                <label for=StoryTitle>
                    <h4>Interview Question:</H4>
                </label>
                <input type="text" class="s4uTextArea form-control"
                    value="<cfoutput>#trim(qMyStory.StoryTitle)#</cfoutput>" name="StoryTitle" id="Storytitle">
            </div>

            <div class="form-group col-md-6">
                <label for="Interviewee">
                    <h4>Name of the person interviewed:</h4>
                </label>
                <input type="text" class="s4uTextArea form-control"
                    value="<cfoutput>#trim(qMyStory.Interviewee)#</cfoutput>" name="Interviewee" id="Interviewee">
            </div>

            <H4>Interview Text:</h4>
            <textarea name="StoryText" id="StoryText"><cfoutput>#trim(qMyStory.StoryText)#</cfoutput></textarea>

            <script>
                CKEDITOR.replace('StoryText', {
                    extraPlugins: 'autogrow',
                    autoGrow_minHeight: 100,
                    autoGrow_maxHeight: 100,
                    autoGrow_bottomSpace: 00,
                    removePlugins: 'resize'
                });
            </script>

            <input type="hidden" name="StoryTypeID" value="2">
            <input type="hidden" name="StoryID" value="<cfoutput>#qMyStory.StoryID#</cfoutput>">

            <div>
                <BR>
                <h4>Share with: </h4>
                <select class="mdb-select md-form colorful-select dropdown-secondary" name="CircleID" id="CircleID"
                    onChange="getMembers(this.value)">
                    <cfoutput>
                        <cfloop query="qGetCircles">
                            <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ qMyStory.CircleID>
                                Selected</cfif>>
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