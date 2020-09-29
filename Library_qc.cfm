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
    <cfajaxproxy cfc="cfc.qcAnswers" jsclassname="qcAnswers" />

  </head>

  <!--- Get everyone Circle --->
  <cfquery name="qSetEveryoneCircle">
    Select CircleID from CircleTbl
    where CircleOwner = #session.UserID# AND
    CircleSort = '0'
  </cfquery>
  <cfset session.myCircleID=qSetEveryoneCircle.CircleID>

  <!--- Get Quick Connect Questions --->
  <cfquery name="qQuickConnect">
    Select ViewPointID, ViewPointQ, ViewPointDate
    from ViewPointTbl
    where ViewPointDate <= '#session.todayis#' and ViewPointID <> 1
      order by ViewPointDate DESC
  </cfquery>

  <body>
    <!--- Start Nav --->
    <cfinclude template="/topNavSmall.cfm">

    <div class="col-md-10 offset-md-1">
      <div class="card card-body">

        <h4 class="mb-3">Quick Connect Questions</h4>

        <cfoutput>
            <cfloop query="qQuickConnect">
                <cfset qcListDiv='qcListDiv' & #qQuickConnect.ViewPointID#>
                  <cfset qcListDivHref='##qcListDiv' & #qQuickConnect.ViewPointID#>

                  <!--Accordion wrapper-->
                  <div class="accordion md-accordion" id="accordionEx1" role="tablist" aria-multiselectable="true">

                    <!-- Accordion card -->
                    <div class="card">

                      <!-- Card header -->
                      <div class="card-header" role="tab" id="headingTwo1" 
                      onclick="getQCAnswers(<cfoutput >#qQuickConnect.ViewpointID#, #session.mycircleID#, #session.UserID#</cfoutput>);">
                        <a class="collapsed" data-toggle="collapse" data-parent="##accordionEx1" href="#qcListDivHref#"
                          aria-expanded="false" aria-controls="collapseTwo1">
                          <h5 class="mb-0">
                            #qQuickConnect.ViewPointQ# <i class="fas fa-angle-down rotate-icon"></i>
                          </h5>
                        </a>
                      </div>

                      <!-- Card body -->
                      <div id="#qcListDiv#" class="collapse" role="tabpanel" aria-labelledby="headingTwo1"
                        data-parent="##accordionEx1">
                        <div class="card-body" id="#qcListDiv#"></div>
                      </div>
                    </div>
                  </div>
              </cfloop>
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
      <script type="text/javascript" src="/js/quickConnect.js"></script>
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
            // getQCAnswers(<cfoutput >#qQuickConnect.ViewpointID#, #session.mycircleID#, #session.UserID# </cfoutput>);
              // End of document ready
            });
      </script>
  </body>
</html>