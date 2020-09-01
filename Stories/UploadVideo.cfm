<cfset setFileName=#CreateUUID()#>

    <!--- If story has media - set up the upload directories --->
    <cfif #session.Iam# EQ "dev">
        <cfset setVideoDirectory="C:\ColdFusion2018\cfusion\wwwroot\M_Video\" & tostring(session.UserID)>
            <cfelse>
                <cfset setVideoDirectory="D:\home\storiesforus.com\wwwroot\M_Video\" & tostring(session.UserID)>
    </cfif>

    <cfif session.Iam EQ "dev">
        <cfset destinationFolder="C:\ColdFusion2018\cfusion\wwwroot\UploadStage">
            <cfelse>
                <cfset destinationFolder="D:\home\storiesforus.com\wwwroot\uploadStage">
    </cfif>
    <!--- Upload the file --->


    <cftry>
        <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedVFile">
            <cfcatch type="any">
                cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
    </cftry>

    <cfif IsDefined('cffile.ClientFileName')>

        <cfif directoryExists(setVideoDirectory)>
            <cfset session.MediaLoc=setVideoDirectory>
                <cfset session.shortLoc="/M_Video/" & tostring(session.UserID)>
                    The Video directory #setVideoDirectory# exists
                    <cfelse>
                        <cfset DirectoryCreate(setVideoDirectory)>
                            <cfset session.MediaLoc=setVideoDirectory>
                                <cfset session.shortLoc="/M_Video/" & tostring(session.UserID)>
                                    I created the #setVideooDirectory#
        </cfif>

        <cfset setDestination=#session.MediaLoc# & "\" & #setFileName# & "." & #cffile.clientFileExt#>
            <cfset setSource=#destinationFolder# & '\' & #cffile.ClientFileName# & "." & #cffile.clientFileExt#>
                <BR>
                <cfoutput>
                    <BR><BR><BR>setDestination: #setDestination#<BR>
                    setSource: #setSource#<BR>
                </cfoutput>
                <cftry>
                    <cffile action="rename" destination=#setDestination# source=#setSource#>
                        <cfcatch type="any">
                            cffile rename Error: <cfoutput>#cfcatch.message#</cfoutput>
                        </cfcatch>
                </cftry>
    </cfif>