<cfset session.setFileName=#CreateUUID()#>

    <!--- If story has media - set up the upload directories --->
    <cfif #session.Iam# EQ "dev">
        <cfset setPhotoDirectory="C:\ColdFusion2018\cfusion\wwwroot\M_Profile\" & tostring(session.UserID) />
        <cfset session.MediaLoc="C:\ColdFusion2018\cfusion\wwwroot\M_Profile" />
        <cfelse>
            <cfset setPhotoDirectory="D:\home\storiesforus.com\wwwroot\M_Profile\" & tostring(session.UserID) />
            <cfset session.MediaLoc="D:\home\storiesforus.com\wwwroot\M_Profile" />
    </cfif>

    <cfif session.Iam EQ "dev">
        <cfset destinationFolder="C:\ColdFusion2018\cfusion\wwwroot\UploadStage">
            <cfelse>
                <cfset destinationFolder="D:\home\storiesforus.com\wwwroot\uploadStage">
    </cfif>
    <!--- Upload the file --->


    <cftry>
        <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.fileI">
            <cfcatch type="any">
                cffile upload Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
    </cftry>

    <cfif IsDefined('cffile.ClientFileName')>

        <cfif directoryExists(setPhotoDirectory)>
            <cfset session.MediaLoc=setPhotoDirectory>
                <cfset session.shortLoc="/M_Profile/" & tostring(session.UserID)>
                    The Photo directory #setPhotoDirectory# exists
                    <cfelse>
                        <cfset DirectoryCreate(setPhotoDirectory)>
                            <cfset session.MediaLoc=setPhotoDirectory>
                                <cfset session.shortLoc="/M_Profile/" & tostring(session.UserID)>
                                    I created the #setPhotooDirectory#
        </cfif>

        <cfset setDestination=#session.MediaLoc# & "\" & #session.setFileName# & "." & #cffile.clientFileExt#>
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