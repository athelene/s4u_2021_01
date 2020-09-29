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


<cfif #session.Iam# EQ "dev">
<cfset setVideoDirectory = "C:\ColdFusion2018\cfusion\wwwroot\M_Video\" & tostring(session.UserID)>
<cfset setPhotoDirectory = "C:\ColdFusion2018\cfusion\wwwroot\M_Photo\" & tostring(session.UserID)>
<cfset setAudioDirectory = "C:\ColdFusion2018\cfusion\wwwroot\M_Audio\" & tostring(session.UserID)>
<cfelse>
<cfset setVideoDirectory = "D:\home\storiesforus.com\wwwroot\M_Video\" & tostring(session.UserID)>
<cfset setPhotoDirectory = "D:\home\storiesforus.com\wwwroot\M_Photo\" & tostring(session.UserID)>
<cfset setAudioDirectory = "D:\home\storiesforus.com\wwwroot\M_Audio\" & tostring(session.UserID)>
</cfif>

<cfset session.uploadResults = []>
  <!--- PREP STORAGE --->
<cfif len(Form["selectedVFile"])>
  <cfset setFileName=#CreateUUID()# />

    <cfif directoryExists(setVideoDirectory)>
       <cfoutput> directory exists </cfoutput>
    </cfif>

    <cfif directoryExists(setVideoDirectory)>
        <cfset Session.MediaLoc=setVideoDirectory />
        <cfset session.shortLoc="/M_Video/" & tostring(session.UserID) />
          <cfoutput>The video directory #setVideoDirectory# exists  </cfoutput>
        <cfelse>
        <cfset DirectoryCreate(setVideoDirectory) />
          <cfoutput>I created the #setVideoDirectory#  </cfoutput>
        <cfset session.MediaLoc=setVideoDirectory />
        <cfset session.shortLoc="/M_Video/" & tostring(session.UserID) />
    </cfif>

<!---     Start uploading the Video file now  --->

   <cfoutput> #len(form.selectedVFile)# is file length by upload media<BR></cfoutput>
    <!--- Set Destination Folder --->

    <cfif session.Iam EQ "dev">
        <cfset destinationFolder="C:\ColdFusion2018\cfusion\wwwroot\UploadStage" />
        <cfelse>
            <cfset destinationFolder="D:\home\storiesforus.com\wwwroot\uploadStage" />
    </cfif>
    <cfoutput>destinationfolder: #destinationFolder#</cfoutput>
    <!--- Upload the file --->
    <cftry>
        <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedVFile">
            <cfcatch type="any">
                cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
    </cftry>

    <cfoutput>#cffile.ClientFileExt#</cfoutput>
    <!--- Get server File Info --->

    <cfset setDestination=#session.MediaLoc# & "\" & #setFileName# & "." & #cffile.clientFileExt# />
    <cfset setSource=#destinationFolder# & '\' & #cffile.ClientFileName# & "." & #cffile.clientFileExt# />
    <BR />
    <cfoutput>
        <BR /><BR /><BR />setDestination: #setDestination#<BR />
        setSource: #setSource#<BR />
    </cfoutput>

    <!--- Rename the file using UUID --->
    <cftry>
        <cffile action="rename" destination=#setDestination# source=#setSource#>
            <cfcatch type="any">
                cffile rename Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
    </cftry>
    <cfset session.MediaTypeID = 1>

 <cfinclude  template="/stories/TempIntoMedia.cfm"> 
<!---     End upload of video file --->
</cfif>

<cfif len(Form["selectedIFile"])>
  <cfset setFileName=#CreateUUID()# />

        <cfif directoryExists(setPhotoDirectory)>
          <cfset session.MediaLoc=setPhotoDirectory />
          <cfset session.shortLoc="/M_Photo/" & tostring(session.UserID) />
            <cfoutput>The photo directory #setPhotoDirectory# exists  </cfoutput>
          <cfelse>
            <cfset DirectoryCreate(setPhotoDirectory)>
              <cfset session.MediaLoc=setPhotoDirectory />
              <cfset session.shortLoc="/M_Photo/" & tostring(session.UserID) />
                <cfoutput>I created the #setPhotoDirectory#  </cfoutput>
        </cfif>
       <cfoutput> #len(form.selectedVFile)# is file length by upload media<BR></cfoutput>
    <!--- Set Destination Folder --->

    <cfif session.Iam EQ "dev">
        <cfset destinationFolder="C:\ColdFusion2018\cfusion\wwwroot\UploadStage" />
        <cfelse>
            <cfset destinationFolder="D:\home\storiesforus.com\wwwroot\uploadStage" />
    </cfif>
    <cfoutput>destinationfolder: #destinationFolder#</cfoutput>
    <!--- Upload the file --->
    <cftry>
        <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedIFile">
            <cfcatch type="any">
                cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
    </cftry>

<!---     Upload Photo File --->
    <cfoutput>#cffile.ClientFileExt#</cfoutput>
    <!--- Get server File Info --->

    <cfset setDestination=#session.MediaLoc# & "\" & #setFileName# & "." & #cffile.clientFileExt# />
    <cfset setSource=#destinationFolder# & '\' & #cffile.ClientFileName# & "." & #cffile.clientFileExt# />
    <BR />
    <cfoutput>
        <BR /><BR /><BR />setDestination: #setDestination#<BR />
        setSource: #setSource#<BR />
    </cfoutput>

    <!--- Rename the file using UUID --->
    <cftry>
        <cffile action="rename" destination=#setDestination# source=#setSource#>
            <cfcatch type="any">
                cffile rename Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
    </cftry>
    <cfset session.MediaTypeID = 2>
     <cfinclude  template="/stories/TempIntoMedia.cfm"> 
<!---     End upload of photo file --->
</cfif>



  </body>

</html>