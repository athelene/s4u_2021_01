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

    <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
    <cfajaxproxy cfc="cfc.BookFilter" jsclassname="BookFilter" />
  </head>

  <!--- Update LastPage Field --->
  <cfquery name="qSetLastBookView">
    Update Usertbl
    SET LastBookView = GetDate()
    WHERE userid = #session.userID#
  </cfquery>

  <body>
    <!--- Start Nav --->
    <cfinclude template="/topNavSmall.cfm">

    <div class="col-md-10 offset-md-1">
      <div class="card card-body">
        <h2>Stories</h2>

        <div class="row">
          <div class="col-12">               
            <div class="btn-group bg-light" data-toggle="buttons">
              <label class="btn btn-outline-text-primary btn-rounded form-check-label active">
                <input class="form-check-input" type="radio" name="options" id="option1" autocomplete="off" checked
                  onClick="getAllBooks(<cfoutput>#session.userid#</cfoutput>)">All Books
              </label>
              <label class="btn btn-outline-text-primary btn-rounded form-check-label">
                <input class="form-check-input" type="radio" name="options" id="option2" autocomplete="off"
                  onClick="getMyBooks(<cfoutput>#session.userid#</cfoutput>)">Mine
              </label>
              <label class="btn btn-outline-text-primary btn-rounded form-check-label">
                <input class="form-check-input" type="radio" name="options" id="option3" autocomplete="off"
                  onClick="getOtherBooks(<cfoutput>#session.userid#</cfoutput>)">Others
              </label>
            </div>
          </div>
        </div>
        
        <!-- Checkboxes -->
        <div class="form-check form-check-inline mt-2">
          <input class="form-check-input" type="checkbox" id="showBooks" value="on" checked>
          <label class="form-check-label" for="showBooks">Stories</label>
        </div>

        <!-- Checkboxes -->
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" id="showTCs" value="on" checked>
          <label class="form-check-label" for="showTCs">Time Capsules</label>
        </div>

        <hr>
    
        <!-- Books-->
        <cfoutput>
          <div id="BookDiv" class="my-3"></div>
        </cfoutput>
      </div>
    </div>
      
    <cfinclude template="/FooterMobile.cfm">

    <!-- JQuery -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="js/mdb.min.js"></script>
    <!-- Optional JavaScript -->
    <script type="text/javascript" src="/js/s4u.js"></script>
    <script type="text/javascript" src="/js/bkfilters.js"></script>
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

        // MDB Lightbox Init
        $(function () {
          $("#mdb-lightbox-ui").load("mdb-addons/mdb-lightbox-ui.html");
        });

        // Check Notifications
        newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
          '#session.LastTCView#' < /cfoutput>);
          getAllBooks( < cfoutput > #session.userid# < /cfoutput>);
            // End of document ready
          });
    </script>
  </body>
</html>