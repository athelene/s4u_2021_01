<!--- Set the correct filename and directory for the mediatbl --->
<cfset MediaShortLoc=#session.shortLoc# & "/" &#setFileName# & "." & #cffile.ClientFileExt#>

    <!--- Insert Into Media Table --->

    <cfquery name="qInsertMedia">
        insert into MediaTbl
        (MediaLoc, UserID, StoryID, MediaType)
        Values
        ('#trim(MediaShortLoc)#', #session.UserID#, #session.StoryID#, #session.MediaTypeID#)
    </cfquery>

    <BR>