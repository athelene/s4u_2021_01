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
  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />

  <cfif session.userid IS 0>
    <cflocation url="index.cfm" />
  </cfif>
  <cfquery name="qGetAdminLevel">
    Select AdminLevel
    from UserTbl
    where #session.UserID# = UserID
  </cfquery>
  <cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

  <!--- Start Nav --->
  <cfinclude template="/TopNavSmall.cfm">

    <cfset session.storyID=url.StoryID />
    <cfquery name="qGetUserBooks">
      Select BookTbl.BookID, BookTbl.BookTitle, BookTbl.BookOwner, BookTbl.TimeCapsuleDate
      from BookTbl
      where BookTbl.BookOwner = #session.userid#
      AND BookTbl.BookID NOT IN
      (select BookID from BookContentTbl
      where StoryID = #session.storyid#)

    </cfquery>

    <cfquery name="qGetStoryName">
      Select StoryID, StoryTitle
      from StoryTbl
      where StoryID = #session.StoryID#
    </cfquery>
    <cfoutput>

      <h5>Select the books and time capsules where you want
        <strong>#qGetStoryName.StoryTitle# </strong>
        to appear:</h5><BR />
      <form name="SaveIntoBooksForm" method="post" action="/books/AddToBooksAction.cfm">
        <select class="mdb-select md-form colorful-select dropdown-primary" multiple>
          <option value="" disabled selected>Choose books and time capsules...</option>
          <cfloop query="qGetUserBooks">

            <cfif qGetUserBooks.TimecapsuleDate GT 0>
              <option value="#qGetUserBooks.BookID#">
                #qGetUserBooks.BookTitle# (Time Capsule)</option>
              <cfelse>
                <option value="#qGetUserBooks.BookID#">
                  #qGetUserBooks.BookTitle# (Book)</option>
            </cfif>
          </cfloop>

        </select>
        <button class="btn-save btn btn-primary btn-sm" type="submit">
          <i class="fas fa-check"></i>
        </button>


        <input id="data" type="hidden" name="data" value="" />
        <input id="storyID" type="hidden" name="storyID" value="#qGetStoryName.StoryID#" />
        <button class="btn btn-secondary btn-floating" type="submit">
          <i class="fas fa-check"></i>
        </button>

        </div>
      </form>

    </cfoutput>

    <cfinclude template="/FooterMobile.cfm">

      <!-- JQuery -->
      <script type="text/javascript" src="/js/jquery.min.js"></script>
      <!-- Bootstrap tooltips -->
      <script type="text/javascript" src="/js/popper.min.js"></script>
      <!-- Bootstrap core JavaScript -->
      <script type="text/javascript" src="/js/bootstrap.min.js"></script>
      <!-- MDB core JavaScript -->
      <script type="text/javascript" src="/js/mdb.min.js"></script>
      <script type="text/javascript" src="/js/badgeUpdates.js"></script>
      <!-- Optional JavaScript -->
      <script type="text/javascript" src="/js/s4u.js"></script>
      <script type="text/javascript">
        $(document).ready(function () {


              $('.mdb-select').materialSelect();

              $('.switch input[type="checkbox"]').on('change', function () {
                if (this.checked) {
                  $("#TimeCapsule").removeClass("invisible");
                  $("#tcLabel").removeClass("invisible");
                } else {
                  var str = $("#TimeCapsule").val();
                  $("#TimeCapsule").addClass("invisible");
                  $("#tcLabel").addClass("invisible");
                };
              });

              $("#anythingSearch").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#QuestionDiv *").filter(function () {
                  $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
              });

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

                // End of document ready
              });

            $('.mdb-select').change(function () {
              var bookids = $(this).val();
              console.log(bookids);
              const bookListInput = [...document.querySelectorAll('#data')];
              bookListInput.forEach((inputel) => {
                inputel.value = bookids;
              })
            });
      </script>


      </body>

</html>