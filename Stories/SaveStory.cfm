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
  <cfset session.StoryTypeID=#form.StoryTypeID#>
    <cfif (isDefined("form.MediaTypeID"))>
      <cfset session.MediaTypeID=#form.MediaTypeID#>
    </cfif>
    <cfinclude template="Subroutine/InsertIntoStory.cfm">


      <!--- If story type is text only  or recipe - check for restricted --->
      <cfif #form.storyTypeID# EQ 1 OR #form.storyTypeId# EQ 2>

        <cfoutput>session.iam = #session.Iam#</cfoutput>
        <!--- If story has media - set up the upload directories --->
        <cfif #session.Iam# EQ "dev">
          <cfset setVideoDirectory="C:\ColdFusion2018\cfusion\wwwroot\M_Video\" & tostring(session.UserID)>
            <cfset setPhotoDirectory="C:\ColdFusion2018\cfusion\wwwroot\M_Photo\" & tostring(session.UserID)>
              <cfset setAudioDirectory="C:\ColdFusion2018\cfusion\wwwroot\M_Audio\" & tostring(session.UserID)>
                <cfelse>
                  <cfset setVideoDirectory="D:\home\storiesforus.com\wwwroot\M_Video\" & tostring(session.UserID)>
                    <cfset setPhotoDirectory="D:\home\storiesforus.com\wwwroot\M_Photo\" & tostring(session.UserID)>
                      <cfset setAudioDirectory="D:\home\storiesforus.com\wwwroot\M_Audio\" & tostring(session.UserID)>
        </cfif>

        <cfoutput>#form.MediaTypeID# is media type id</cfoutput>
        <cfif form.MediaTypeID EQ 1>
          <cfset session.MediaTypeID=1>
            <cfinclude template="Subroutine/PrepFileStorage.cfm">
              done file prep
              <cfinclude template="Subroutine/UploadMedia.cfm">
                media uploaded
                <cfinclude template="Subroutine/InsertIntoMedia.cfm">
                  inserted into media
        </cfif>

        <cfif form.MediaTypeID EQ 2>
          <cfset session.MediaTypeID=2>
            <cfinclude template="Subroutine/PrepFileStorage.cfm">
              done file prep
              <cfinclude template="Subroutine/UploadMedia.cfm">
                media uploaded
                <cfinclude template="Subroutine/InsertIntoMedia.cfm">
                  inserted into media
        </cfif>

        <cfif form.MediaTypeID EQ 3>
          <cfset session.MediaTypeID=3>
            Made it to savestory line 53
            <cfinclude template="Subroutine/PrepFileStorage.cfm">
              done file prep
              <cfinclude template="Subroutine/UploadMedia.cfm">
                media uploaded
                <cfinclude template="Subroutine/InsertIntoMedia.cfm">
                  inserted into media
        </cfif>
      </cfif>

      <!--- END routines for stories with media  --->




      <cflocation url="../Redirect.cfm?goToPage=#session.returnto#">
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