<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!--- For richtext editing --->
  <meta http-equiv="X-UA-Compatible" content="IE=7">
  <!-- MDB icon -->
  <link rel="icon" href="/img/mdb-favicon.ico" type="image/x-icon">
  
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="/assets/css/bootstrap.css">
  <link rel="stylesheet" href="/assets/css/index.css">  

  <script src="https://cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
  <!--- <script src="/books/DragnDrop.js" defer></script> --->
  <title>Stories For Us - Save Interview Questions</title>
</head>

<body>


  <cfquery name="qInsertQuestion">
    insert into InterviewTbl
    (IntQuestion, IntCategory)
    Values
    ('#trim(form.InterviewQuestion)#', #form.intCategory#)
  </cfquery>

  <cfquery name="qInterviewID">
    SELECT MAX(InterviewID) AS LastID FROM InterviewTbl;
  </cfquery>

  <cfset NewIntID=qInterviewID.LastID />
  <!--- Start insert loop --->

  <cfset catarray=ListToArray(#form.Data#) />
  <cfloop from="1" to="#arrayLen(catarray)#" index="i">
    <cfset NewCatID=catarray[i] />

    <cfquery name="qInsertBookID">
      insert into InterviewCatLogTbl
      (InterviewID, InterviewCatID)
      values (
      <cfqueryparam value=#NewIntID# cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value=#NewCatID# cfsqltype="CF_SQL_INTEGER">
          )
    </cfquery>
  </cfloop>



  <BR>
  <cflocation url="/admin/AddInterviewQuestions.cfm" />

</body>
<script type="text/javascript" src="js/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="js/mdb.min.js"></script>
</body>

</html>