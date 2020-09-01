<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous">
  </script>
  <!--Link to Custom CSS -->
  <link rel="stylesheet" href="s4u.css">
  <title>Stories For Us</title>
</head>

<body>
  <cfset getBookID=#session.bookID# />


  <cfset storycount=LSParseNumber(#form.StoryCount#) />


  <cfoutput>#storycount#</cfoutput>

  <cfloop from="1" to="#storycount#" index="i">

    <cfset storycounter=i />
    <cfoutput>FormStoryCount = #form.StoryCount#<BR>

      #form["StoryID" & i]#</cfoutput><BR>

    <cfquery name="qDelOrder">
      Delete from BookContentTbl
      where StoryID = #form["StoryID" & i]#
    </cfquery>

    <cfquery name="qResetOrder">
      Insert into BookContentTbl
      (BookID, StoryID, SortOrder)
      values
      (#getBookID#, #form["StoryID" & i]#, #storycounter#)
    </cfquery>
  </cfloop>

  <cflocation url="/books/BookReader.cfm?BookID=#session.BookID#" />
  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
    integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous">
  </script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous">
  </script>
</body>

</html>