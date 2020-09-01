<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="/css/mdb.min.css" rel="stylesheet">
  <link href="/s4u.css" rel="stylesheet">
  <link href="/main.css" rel="stylesheet">

  <title>Stories For Us</title>
</head>

<body>
  <!--- Reset session.storyID to be sure you editing correct story --->
  <cfset session.StoryID=#form.StoryID#>


    <!--- Update the storytbl if the page is a recipe --->
    <cfif form.StoryTypeID EQ 3>
      <cfquery name="qUpdateRecipe">
        UPDATE storyTbl
        SET StoryTitle = '#trim(Form.StoryTitle)#',
        StoryText = '#trim(Form.StoryText)#',
        StoryIngredients = '#trim(Form.StoryIngredients)#',
        CircleID = #Form.CircleID#
        WHERE StoryID = '#Form.StoryID#'
      </cfquery>

      <cfelseif form.StoryTypeID EQ 2>

        <!--- Update the storytbl if the page is an interview --->
        <cfquery name="qUpdateInterview">
          UPDATE storyTbl
          SET StoryTitle = '#trim(Form.StoryTitle)#',
          StoryText = '#trim(Form.StoryText)#',
          Interviewee = '#trim(Form.Interviewee)#',
          CircleID = #Form.CircleID#
          WHERE StoryID = '#Form.StoryID#'
        </cfquery>

        <!--- Update the storytbl if any other type of page --->
        <cfelse>
          <cfquery name="qUpdateStory">
            UPDATE storyTbl
            SET StoryTitle = '#trim(Form.StoryTitle)#',
            StoryText = '#trim(Form.StoryText)#',
            CircleID = #Form.CircleID#
            WHERE StoryID = '#Form.StoryID#'
          </cfquery>
    </cfif>





    <!--- Once all the above is done, go back to the edit page --->
    <cflocation url="/stories/Story.cfm?&storyID=#session.storyid#">


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