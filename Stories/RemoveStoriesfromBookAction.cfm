<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


  <title>Stories For Us</title>
</head>

<body>



  <cfquery name="qRemoveStory">
    Delete from BookContentTbl
    where BookID = #session.BookID#
    and StoryID = #url.storyID#
  </cfquery>

  <cflocation url="/Redirect.cfm?goToPage=BookReader&BookID=#session.bookid#">
</body>

</html>