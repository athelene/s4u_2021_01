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

  <script src="https://cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>

  <title>Stories For Us - Add Interview Questions</title>
</head>
<cfquery name="qGetInterviewQs">
  Select IntQuestion, InterviewCatTbl.IntCategory from InterviewTbl
  left Join InterviewCatTbl
  on InterviewTbl.IntCategory = InterviewCatTbl.InterviewCatID
  Order by InterviewCatTbl.IntCategory, IntQuestion
</cfquery>
<body>
  <!--- Start Nav --->
  <cfinclude template="/topNavSmall.cfm">

    <h1>Add Interview Questions</h1>

    <cfquery name="qGetCategories">
      Select * from InterviewCatTbl
      Order by IntCategory
    </cfquery>

    <form action="/admin/SaveInterviewQuestions.cfm" enctype="multipart/form-data" method="post">

      <!-- Question -->
      <input type="text" id="InterviewQuestion" class="form-control mb-4" placeholder="Enter question here"
        name="InterviewQuestion">
      <BR />
      <div>
        <select class="mdb-select md-form" multiple name="intCategory">
          <option value="" disabled selected>Choose categories</option>
          <cfloop query="qGetCategories">
            <cfoutput>
              <option value="#qGetCategories.InterviewCatID#">#qGetCategories.IntCategory#</option>
            </cfoutput>
          </cfloop>
        </select>
      </div>
      <input id="data" type="hidden" name="data" value="" />
      <button type="submit" class="btn-save btn btn-secondary btn-sm">Save Question</button>
    </form>
    <HR>
    Interview Questions:<BR>
    <cfloop query = "qGetInterviewQs">
  <cfoutput>
  #qGetInterviewQs.IntCategory# - #qGetInterviewQs.IntQuestion#<BR>
  </cfoutput>
    </cfloop>
<BR><BR><BR>
    <cfinclude template="/FooterMobile.cfm">
      <!-- jQuery -->
      <script type="text/javascript" src="../js/jquery.min.js"></script>
      <!-- Bootstrap tooltips -->
      <script type="text/javascript" src="../js/popper.min.js"></script>
      <!-- Bootstrap core JavaScript -->
      <script type="text/javascript" src="../js/bootstrap.min.js"></script>
      <!-- MDB core JavaScript -->
      <script type="text/javascript" src="../js/mdb.min.js"></script>

      <!-- Optional JavaScript -->
      <script type="text/javascript" src="/js/s4u.js"></script>
      <script type="text/javascript" src="/js/bkfilters.js"></script>
      <script type="text/javascript" src="/js/badgeUpdates.js"></script>



      <script type="text/javascript">
        $(document).ready(function () {
          $('.mdb-select').materialSelect();
        });
        $('.mdb-select').change(function () {
              var catids = $(this).val();
              console.log(catids);
              const catListInput = [...document.querySelectorAll('#data')];
              catListInput.forEach((inputel) => {
                inputel.value = catids;
              });
              newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                '#session.LastTCView#' < /cfoutput>);
              });
      </script>
</body>

</html>