<!doctype html>
<html lang="en">

<head>
</head>

See StoryStarter Info
<cfset destinationFolder="C:\ColdFusion2018\cfusion\wwwroot\UploadStage">

  <cfoutput>destinationfolder: #destinationFolder#</cfoutput>
  <!--- Upload the file --->


  <cftry>
    <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedVFile">
      <cfcatch type="any">
        cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
      </cfcatch>
  </cftry>

  <cfif IsDefined('cffile.ClientFileName')>
    <cfoutput>
      <cfset videoFile=#cffile.ClientFileName# & "." & #cffile.clientFileExt#>

        video file is: #videoFile#
    </cfoutput>

  </cfif>


  <!--- Upload the file --->

  <cftry>
    <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedIFile">
      <cfcatch type="any">
        cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
      </cfcatch>
  </cftry>
  <cfif IsDefined('cffile.ClientFileName')>
    <cfoutput>
      <cfset imageFile=#cffile.ClientFileName# & "." & #cffile.clientFileExt#>


        image file is: #imageFile#
    </cfoutput>
  </cfif>

  <!--- Upload the file --->

  <cftry>
    <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedAFile">
      <cfcatch type="any">
        cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
      </cfcatch>
  </cftry>
  <cfif IsDefined('cffile.ClientFileName')>
    <cfoutput>
      <cfset imageFile=#cffile.ClientFileName# & "." & #cffile.clientFileExt#>


        audio file is: #imageFile#
    </cfoutput>
  </cfif>









</html>