<cfif len(Form["selectedFile"])>
    <cfoutput> #len(form.selectedFile)# is file length by upload media<BR></cfoutput>
    <!--- Set Destination Folder --->

    <cfif session.Iam EQ "dev">
        <cfset destinationFolder="C:\ColdFusion2018\cfusion\wwwroot\UploadStage" />
        <cfelse>
            <cfset destinationFolder="D:\home\storiesforus.com\wwwroot\uploadStage" />
    </cfif>
    <cfoutput>destinationfolder: #destinationFolder#</cfoutput>
    <!--- Upload the file --->
    <cftry>
        <cffile action="upload" destination=#destinationFolder# nameConflict="overwrite" fileField="Form.selectedFile">
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

    <cfelse>
</cfif>