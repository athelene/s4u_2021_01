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

<cfquery name="qGetTraditions">
    Select * from TraditionTypeTbl
    Order by traditionName
</cfquery>
  <body>
<!--- Start Nav --->
<cfinclude template="/TopNavSmall.cfm">

<cfoutput>


<!-- Default form subscription -->
<form method="post" class="text-center border border-light p-5" action="TraditionAction.cfm">

    <p class="h4 mb-4">Add a Tradition</p>


    <!-- QC Question -->
    <input type="text" id="tradition" class="form-control mb-4" placeholder="Tradition" name="Tradition">

    <BR>
    <button class="btn btn-secondary btn-block" type="submit">Save</button>


</form>

<cfloop query="qGetTraditions">
  #qGetTraditions.TraditionName# <BR>
</cfloop>
</cfoutput>
<!-- Default form subscription -->
<BR><BR><BR>

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

                  // Check Notifications
                  sessionUserid(<cfoutput>#session.userid#</cfoutput>);
                  newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                    '#session.LastTCView#' < /cfoutput>);

                      $('.mdb-select').materialSelect();

                      });

                      // End of document ready
          </script>
  </body>
  </html>