<!--- Set the correct filename and directory for the mediatbl --->
<cfset MediaShortLoc=#session.shortLoc# & "/" &#setFileName# & "." & #cffile.ClientFileExt#>

    <!--- Insert Into Media Table --->

    <cfquery name="qInsertMedia" result="mediaResult">
        insert into MediaTbl
        (MediaLoc, UserID, StoryID, MediaType, MediaDate, UploadUUID, FeatureMedia)
        Values
        ('#trim(MediaShortLoc)#', #session.UserID#, 0, #session.MediaTypeID#, '#session.TodayIs#', '#setFileName#', 2)
    </cfquery>

<cfif session.starter IS 'story'>
    <cflocation url="/stories/storystarter.cfm">
</cfif>
<cfif session.starter IS 'recipe'>
    <cflocation url="/stories/recipestorystarter.cfm">
</cfif>
<cfif session.starter IS 'interview'>
    <cflocation url="/stories/interviewstorystarter.cfm">
</cfif>
<cfif session.starter IS 'tradition'>
    <cflocation url="/stories/traditionstorystarter.cfm">
</cfif>