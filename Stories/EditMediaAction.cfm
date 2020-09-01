<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=7">

    <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />

    <cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

    <!--- Check for a new video file, if yes: upload the video and add to mediatbl --->
    <cfif len(Form["selectedVFile"])>
        <cfset session.MediaTypeID=1>
            <cfinclude template="UploadVideo.cfm">
                <cfinclude template="InsertIntoMedia.cfm">
    </cfif>

    <!--- Check for a new photo file, if yes: upload the photo and add to mediatbl --->
    <cfif len(Form["selectedIFile"])>
        <cfset session.MediaTypeID=2>
            <cfinclude template="UploadPhoto.cfm">
                <cfinclude template="InsertIntoMedia.cfm">
    </cfif>

    <cflocation url="/stories/editPage.cfm?StoryID=#session.storyid#">