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
  <cfajaxproxy cfc="cfc.cir" jsclassname="cir" />

  <cfquery name="qGetMyAnswer">
    Select VPAnswerID, VPAnswer, ViewPointID
    from VPAnswerTbl 
    where ViewPointID = #url.qcAnswerID# AND Userid = #session.userid#
  </cfquery>

    <cfquery name="qGetQuestion">
        Select ViewPointQ from ViewPointTbl 
        where ViewPointID = #url.qcAnswerID#
    </cfquery>

  <!--- Start Nav --->
  <cfinclude template="/topNavSmall.cfm">

    <form action="/EditQCAnswerAction.cfm" enctype="multipart/form-data" method="post">
      <BR>
      <div>
        <h3><cfoutput>#qGetQuestion.ViewPointQ#</cfoutput></h3><BR>
      </div>
      <cfif qGetMyAnswer.RecordCount LT 1>
      <input class="s4uTextArea form-control" type="text" name="QCAnswer" 
        placeholder="Your answer">
        <input type="hidden" name="EditInsert" value="Insert">
        <cfelse>
      <input class="s4uTextArea form-control" type="text" name="QCAnswer" value="<cfoutput>#qGetMyAnswer.VPAnswer#</cfoutput>"
        placeholder="Your answer">
      <input type="hidden" name="EditInsert" value="Edit">
      <input type="hidden" name="VPAnswerID" value="<cfoutput>#qGetMyAnswer.VPAnswerID#</cfoutput>">
        </cfif>
      <br>
      <input type="hidden" name="ViewPointID" value="<cfoutput>#url.qcAnswerID#</cfoutput>">
      </div>

      <div class="text-center">

        <button class="btn btn-secondary btn-floating" type="submit">
          <i class="fas fa-check"></i>
        </button>

      </div>
    </form>





    <!---         Start Footer --->
    <cfinclude template="/FooterMobile.cfm">



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