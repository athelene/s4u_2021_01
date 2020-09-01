<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
  <cfajaxproxy cfc="cfc.qcAnswers" jsclassname="qcAnswers" />

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

      <h4>Quick Connect Questions</h4>
      <cfoutput>

        <cfset i=0>
          <cfloop query="qQuickConnect">
            <cfset i=i + 1>
              <cfset qcListDiv='qcListDiv' & i>
                <cfset qcListDivHref='##qcListDiv' & i>
                  <div id="myAnswerDiv" class="md-form md-bg col-xs-8">
                    <span class="QCText">#qQuickConnect.Viewpointq#</span> <BR>
                     #dateformat(qQuickConnect.ViewPointDate,
                    'YYYY-MM-DD')#


                    <!--Accordion wrapper-->
                    <div class="accordion md-accordion" id="accordionEx" role="tablist" aria-multiselectable="true">

                      <!-- Accordion card -->
                      <div class="card">

                        <!-- Card header -->
                        <div class="card-header" role="tab" id="headingOne1"
                          onclick="getQCAnswers(<cfoutput>#qQuickConnect.ViewpointID#, #session.mycircleID#, #session.UserID#</cfoutput>)">
                          <a data-toggle="collapse" data-parent="##accordionEx" href="#qcListDivHref#"
                            aria-expanded="true" aria-controls="collapseOne1">
                            <h6 class="mb-0">
                              See Answers<i class="fas fa-angle-down rotate-icon"></i>
                            </h6>
                          </a>
                        </div>

                        <!-- Card body -->
                        <div id="#qcListDiv#" class="collapse" role="tabpanel" aria-labelledby="headingOne1"
                          data-parent="##accordionEx">
                          <cfset qcAnswerDiv = 'qcAnswerDiv' & i>
                          <div class="card-body" id="#qcAnswerDiv#">

                          </div>
                        </div>

                      </div>
                      <!-- Accordion card -->
                    </div>
                    <!-- Accordion wrapper -->
                  </div>
          </cfloop>
      </cfoutput>
      <BR><BR><BR><BR>
      <cfinclude template="/FooterMobile.cfm">
</body>

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
                  getQCAnswers(<cfoutput >#qQuickConnect.ViewpointID#, #session.mycircleID#, #session.UserID# </cfoutput>);
                    // End of document ready
                  });
        </script>


        </body>

</html>