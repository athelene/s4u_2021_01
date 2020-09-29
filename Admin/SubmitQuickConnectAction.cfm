<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">
  <link rel="icon" href="/img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">

  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="/assets/css/bootstrap.css">
  <link rel="stylesheet" href="/assets/css/index.css">  

  <cfquery name="qAddQCSuggestion">

    Insert into QCSuggestionTbl
    (QCUser, QCSuggestion, QCDate, QCreward)
    values
    (#session.userID#,
    <cfqueryparam value="#trim(form.QCSuggestion)#" cfsqltype="CF_SQL_VARCHAR">,
      <cfqueryparam value="#session.todayis#" cfsqltype="CF_SQL_DATE">,
        <cfqueryparam value="#form.QCreward#" cfsqltype="CF_SQL_NUMERIC">
          )
  </cfquery>

  <cflocation url="/homepage.cfm">
    <!-- JQuery -->
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="/js/mdb.min.js"></script>

    <!-- Optional JavaScript -->



    <script type="text/javascript">
      $(document).ready(function () {

        $(function () {
          $(".sticky").sticky({
            topSpacing: 90,
            zIndex: 2,
            stopper: "#YourStopperId"
          });
        });



        // End of document ready
      });
    </script>

    </body>

</html>