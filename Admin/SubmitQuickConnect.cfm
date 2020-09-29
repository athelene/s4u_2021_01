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
  <cfajaxproxy cfc="cfc.cir" jsclassname="cir" />

  <!--- Start Nav --->
  <cfinclude template="/topNavSmall.cfm">

    <form action="/admin/SubmitQuickConnectAction.cfm" enctype="multipart/form-data" method="post">
      <BR>
      <div>
        <h3>If you are the first to submit a question we use for one of our Quick Connect question of the day,
          you will receive a $10 credit toward your subscription.</h3><BR>
      </div>
      <input class="s4uTextArea form-control" type="text" name="QCSuggestion"
        placeholder="Your suggested Quick Connect question."><br>
      <input type="hidden" name="QCreward" value="10">
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