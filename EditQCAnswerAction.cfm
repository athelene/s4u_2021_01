<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">
  <link rel="icon" href="/img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="/assets/css/bootstrap.css">
  <link rel="stylesheet" href="/assets/css/index.css">  

    <cfif form.EditInsert IS 'Edit'>
    <cfquery name="qUpdateAnswer">
    Update VPAnswerTbl 
    set VPAnswer = <cfqueryparam value="#trim(form.QCAnswer)#" cfsqltype="CF_SQL_VARCHAR">
    where VPAnswerID = #form.VPAnswerID#
    </cfquery>
    <cfelse>
    <cfquery name="qAddAnswer">
        INSERT INTO VPAnswerTbl 
        (VPAnswer, UserID, ViewPointID)
        VALUES (
            <cfqueryparam value="#form.QCAnswer#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#session.Userid#" cfsqltype="CF_SQL_INTEGER">, 
            <cfqueryparam value="#form.ViewPointID#" cfsqltype="CF_SQL_INTEGER">
        )
    </cfquery>
    </cfif>



  <cflocation url="/Library_qc.cfm">
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