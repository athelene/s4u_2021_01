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
  <cfajaxproxy cfc="cfc.memNewBook" jsclassname="memNewBook" />
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
  <cfinclude template="/topNavSmall.cfm">


    <cfquery name="qClearTmpExclude">
      Delete from TMPExcludeTbl
      where UserID = #session.userid#
    </cfquery>

    <cfquery name="qGetCircles">
      Select * from CircleTbl
      where CircleOwner = #session.Userid#
      Order By CircleSort
    </cfquery>

<form action="/books/NewBookAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post">
  <h4 class="modal-title w-100 font-weight-bold">New Book</h4>
  <!--- CLOSE MODAL FORM BUTTON --->
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
  <!--- BOOK TITLE FIELD --->
  <div class="md-form mb-5">
    <input type="text" id="BookTitle" class="form-control" name="BookTitle"
      placeholder="Type your title here" />
    <input type="hidden" name="ContentType" value="2" />
    </div>

    <!--- Switch  --->
    <!---         TC Div --->
    <div class="switch">
            <label>
                Is this a time capsule?
                <input type="checkbox" name="tcCheckbox" />
                <span class="lever"></span>
            </label>
            <!--- TC Date  --->
            <div class="md-form ml-0 mr-0">
                <label id="tcLabel" class="ml-0 invisible">Enter The date you want to release this time capsule.
                    <input type="date" id="TimeCapsule" name="TimeCapsuleDate" value=""
                        class="form-control form-control-sm validate ml-0 invisible" />
                </label>
            </div>
            <!---  end of TC Date --->
            <BR><BR>
    </div>
    <!---         end of TC Div --->

  <BR><BR>

  <h4>Share with: </h4>
  <select class="mdb-select md-form colorful-select dropdown-primary" name="CircleID" id="CircleID">
    <cfoutput>
      <cfloop query="qGetCircles">
        <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ session.MyCircleID>Selected</cfif>>
          #qGetCircles.CircleName#
        </option>
      </cfloop>
    </cfoutput>
  </select>
  <!--- Circle Exceptions --->
  <!-- Button trigger circle modal-->
  <button type="button" class="btn btn-sm btn-secondary" data-toggle="modal" onClick="getNewBookMembers()"
    data-target="#modalCircle">Except</button>

  <!-- Modal: modalCircle -->
  <div class="modal fade" id="modalCircle" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <!--Header-->
        <div class="modal-header">
          <h4 class="modal-title" id="myCircleLabel">Choose who can see this book:</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <!---           <span aria-hidden="true">×</span> --->
          </button>
        </div>
        <!--Body-->
        <div class="modal-body" ID="MemDiv">

          <!--- List of people in selected circle goes in this modal --->

        </div>
      <!--Footer-->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
  <!-- Modal: modalCircle -->
        <!---     MemDiv for ajax to insert list of books--->
      <div id="MemDiv">

      </div>


        <div class="text-center">

        <button class="btn btn-secondary btn-floating" 
        type="submit">
          <i class="fas fa-check"></i>          
        </button>

      </div>
      <!---     end of MemDiv --->
<cfinclude template="/FooterMobile.cfm">
      <!-- JQuery -->
      <!-- SCRIPTS -->

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
      <script type="text/javascript">
        $(document).ready(function () {

              $(function () {
                $(".sticky").sticky({
                  topSpacing: 90,
                  zIndex: 2,
                  stopper: "#YourStopperId"
                });
              });

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

              // MDB Lightbox Init
              $(function () {
                $("#mdb-lightbox-ui").load("mdb-addons/mdb-lightbox-ui.html");
              });

              // Check Notifications
              newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                '#session.LastTCView#' < /cfoutput>);

                // End of document ready
              });
      </script>


      </body>

</html>