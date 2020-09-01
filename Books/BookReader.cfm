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

  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />


  <!--- Start Nav --->
  <cfinclude template="/TopNavSmall.cfm">
    <cfset session.BookID=url.BookID>
      <!--- Get book info  --->

      <cfquery name="qBookBasics">
        Select BookTbl.*, UserDisplayName from BookTbl
        left join UserTbl
        on BookTbl.BookOwner = UserTbl.UserID
        where bookid = #url.bookID#
      </cfquery>

      <cfquery name="qBookTblInfo">
        Select distinct BookContentTbl.BookID, BookContentTbl.SortOrder, StoryTbl.StoryID, StoryTbl.StoryTitle,
        StoryTbl.UserID, StoryTbl.StoryTypeID, StoryTbl.StoryDate, StoryTbl.StoryIngredients,
        StoryTbl.StoryText, StoryTbl.InterviewID, StoryTbl.Interviewee, StoryTbl.CircleID,
        UserTbl.UserDisplayName

        from BookContentTbl
        left join StoryTbl
        on BookContentTbl.StoryID = StoryTbl.StoryID
        left join UserTbl
        on StoryTbl.UserID = UserTbl.UserID
        where

        StoryTbl.UserID = #session.userid# AND BookContentTbl.BookID = #session.bookid#

        OR
        ( BookContentTbl.BookID = #session.bookid# AND
        (CircleID in
        (select CircleID from CircleMemberTbl
        where MemberID = #session.userid#) )

        AND ( StoryTbl.StoryID not in
        (Select StoryID from ExcludeTbl
        where ExcludeUser = #session.userid#)
        )
        )
        order by BookContentTbl.SortOrder
      </cfquery>

      <cfif qBookBasics.RecordCount IS 0>
        <div>

          <cfoutput>

            <h3 class="mb-0">
              #qBookBasics.BookTitle#
            </h3>

            <cfif qBookBasics.BookOwner IS #session.UserID#>
              <br>
              <div class="btn-group bg-light" data-toggle="buttons">

                <button type="button" class="btn btn-secondary btn-rounded"
                  onClick="location.href='/books/EditBook.cfm?BookID=#session.BookID#'">Edit</button>
                <button type="button" class="btn btn-secondary btn-rounded"
                  onClick="location.href='/stories/AddStoriesToBook.cfm?BookID=#url.BookID#'">Add Pages</button>
                <button type="button" class="btn btn-secondary btn-rounded"
                  onClick="location.href='/books/ReorderStories.cfm?BookID=#session.BookID#'">Reorder Pages</button>
              </div>
              <cfelse>


            </cfif>

          </cfoutput>
          <BR />
          No pages have been added.
        </div>
        <cfelse>
          <cfset headinglbl='heading' />
          <cfif qBookBasics.BookOwner IS #session.UserID#>
            <BR>
            <div class="btn-group" data-toggle="buttons">

              <button type="button" class="btn btn-secondary"
                onClick="location.href='/books/EditBook.cfm?BookID=#session.BookID#'">Edit</button>
              <button type="button" class="btn btn-secondary"
                onClick="location.href='/stories/AddStoriesToBook.cfm?BookID=#url.BookID#'">Add Pages</button>
              <button type="button" class="btn btn-secondary"
                onClick="location.href='/books/ReorderStories.cfm?BookID=#session.BookID#'">Reorder Pages</button>
            </div>
            <cfelse>


          </cfif>
          <!--- Start the page --->
          <!-- Accordion wrapper -->
          <div class="accordion md-accordion" id="accordionEx1" role="tablist" aria-multiselectable="true">

            <cfoutput>

              <h3 class="mb-0">
                #qBookBasics.BookTitle#, created by #qBookBasics.UserDisplayName#
              </h3>
            </cfoutput>

            <cfset i=1 />
            <cfloop query="qBookTblInfo">

              <cfset bookList=#ValueList(qBookTblInfo.StoryID)# />

              <cfif #qBookTblInfo.recordcount# LT 1>
                No pages have been added.
                <cfelse>

                  <cfset headerid='heading' & i />
                  <cfset cardid='collapse' & i />
                  <cfset cardidhref='##collapse' & i />
                  <cfset accordionexhref='##accordionEx1' />
                  <cfset accordionex='accordionEx1' />

                  <cfset expanded='false' />
                  <cfset expclass='collapse' />
                  <cfoutput>

                    <cfquery name="qGetMedia">
                      Select * from MediaTbl
                      where StoryID = #qBookTblInfo.storyid#
                    </cfquery>

                    <!-- Accordion card -->
                    <div class="card">
                      <!-- Card header -->
                      <div class="card-header" role="tab" id="#headerid#">
                        <h5 class="mb-0">
                          <a class="collapsed" data-toggle="collapse" data-parent="##accordionEx1" href="#cardidhref#"
                            aria-expanded="#expanded#" aria-controls="#cardid#">
                            #trim(qBookTblInfo.StoryTitle)# by #trim(qBookTblInfo.UserDisplayName)# -
                            #dateFormat(qBookTblInfo.StoryDate,"mmmm d, yyyy")#

                            <i class="fas fa-angle-down rotate-icon"></i>

                          </a>

                          <a class="btn-rounded btn-lg"
                            href="/stories/RemoveStoriesFromBookAction.cfm?StoryID=#qBookTblInfo.StoryID#"
                            title="Remove this page"><i class="far fa-trash-alt"></i></a>
                        </h5>

                      </div>
                      <!---card header --->

                      <!-- Card body -->
                      <div id="#cardid#" class="#expclass#" role="tabpanel" aria-labelledby="#headerid#"
                        data-parent="#accordionEx#">

                        <div class="card-body">

                          <cfif qGetMedia.recordcount IS NOT 0 and qGetMedia.MediaType IS 2>
                            <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
                              <div class="carousel-inner">

                                <cfloop query="qGetMedia">
                                  <div class="carousel-item active">
                                    <img class="w-25 d-block" src="#qGetMedia.MediaLoc#">
                                  </div>
                                </cfloop>
                              </div>
                            </div>
                          </cfif>

                          <cfif qGetMedia.recordcount is NOT 0 and qGetMedia.MediaType is 1>
                            <video class="video-fluid z-depth-1" autoplay loop controls muted>
                              <source src="#qGetMedia.MediaLoc#" type="video/mp4" />
                            </video>
                          </cfif>

                          <cfif qGetMedia.recordcount is NOT 0 and qGetMedia.MediaType is 3>
                            <div class="embed-responsive embed-responsive-16by9" style="max-height:1.5em">
                              <audio class="embed-responsive-item" controls src=<cfoutput>"#qGetMedia.MediaLoc#"
                  </cfoutput>
                  Your browser does not support the
                  <code>audio</code> element.
                  </audio>
          </div>
      </cfif>

      <BR />
      <cfif qBookTblInfo.StoryTypeID EQ 3>
        <h4>Ingredients:</h4>
        <div class="container">
          <cfoutput>#qBookTblInfo.StoryIngredients#</cfoutput>
        </div>
        <h4>Directions:</h4>
      </cfif><BR />

      #trim(qBookTblInfo.StoryText)#<BR />

      <cfif qBookTblInfo.UserID IS #session.UserID#>
        <a class="btn btn-primary" href="/stories/editpage.cfm?StoryID=#qBookTblInfo.StoryID#" title="Edit this page">
          <i class="far fa-edit icon-align-center"></i></a>
      </cfif>
      </div>
      <!--- end of text --->
      </div>
      <!---end of card body first div --->


      </div>
      <!--- card --->


      </cfoutput>
      <cfset i=i + 1 />



      </cfif>
      </cfloop>
      <!-- End of Accordion card -->
      </div>

      </cfif>


      <cfinclude template="/FooterMobile.cfm">
        <!-- Accordion wrapper -->

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
        <script type="text/javascript">
          $(document).ready(function () {

                $(function () {
                  $(".sticky").sticky({
                    topSpacing: 90,
                    zIndex: 2,
                    stopper: "#YourStopperId"
                  });
                });

                // Tooltips Initialization
                $(function () {
                  $('[data-toggle="tooltip"]').tooltip()
                })


                // Check Notifications
                newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                  '#session.LastTCView#' < /cfoutput>);

                  // End of document ready
                });
        </script>


        </body>

</html>