<!--- Set Story Date --->
<cfset StoryDate=datetimeformat(now(), "YYYY-MM-DD HH:nn:ss" ) />

<!--- Check for title  --->
<cfif #form.StoryTitle# EQ "">
    <cfset form.StoryTitle=StoryDate />
</cfif>


<cfif #form.StoryTypeID# EQ 3>
    <!--- Save to StoryTbl RECIPE--->
    <cfquery name="qInsertStory" result="storyIDResult">
        insert into StoryTbl
        (StoryTitle, StoryIngredients, StoryText, UserID, StoryTypeID, StoryDate, CircleID)
        Values
        ('#TRIM(form.storyTitle)#', '#TRIM(form.storyIngredients)#', '#TRIM(form.storyText)#', #session.userid#,
        #form.storytypeid#, '#storydate#', #form.circleid#)
    </cfquery>

    <!--- Save to StoryTbl Interview --->
    <cfelseif #form.StoryTypeID# EQ 2>

        <!--- <cfset session.InterviewID = #form.InterviewID#> --->
        <cfif len(#form.StoryText#) EQ 0>
            <cfquery name="qInsertStory" result="storyIDResult">
                insert into StoryTbl
                (StoryTitle, UserID, StoryTypeID, StoryDate, circleID, InterviewID, Interviewee)
                Values
                ('#TRIM(form.storyTitle)#', #session.userid#, #form.storytypeid#, '#storydate#', #form.circleid#,
                #session.InterviewID#, '#trim(form.Interviewee)#')
            </cfquery>

            <cfelse>
                <cfquery name="qInsertStory">
                    insert into StoryTbl
                    (StoryTitle, UserID, StoryTypeID, StoryText, StoryDate, circleID, InterviewID, Interviewee)
                    Values
                    ('#TRIM(form.storyTitle)#', #session.userid#, #form.storytypeid#, '#form.storytext#', '#storydate#',
                    #form.circleid#, #session.InterviewID#, '#trim(form.Interviewee)#')
                </cfquery>
        </cfif>

        <cfelse>
            <!--- Save to StoryTbl NON RECIPE / NON INTERVIEW --->

            <cfquery name="qInsertStory" result="storyIDResult">
                insert into StoryTbl
                (StoryTitle, StoryText, UserID, StoryTypeID, StoryDate, circleID)
                Values
                ('#TRIM(form.storyTitle)#', '#TRIM(form.storyText)#', #session.userid#, #form.storytypeid#,
                '#storydate#', #form.circleid#)
            </cfquery>
</cfif>


<!--- Get the new storyID --->

<!--- Create New StoryID --->
<cfset NewStoryID=#storyIDResult.generatedkey# />
<cfset session.StoryID=NewStoryID />

<!--- END OF INSERT INTO STORY --->

<!--- Update MediaTbl with storyID --->
<cfloop array="#session.uploadResults#">
    <cfquery name=qUpdateMediaTbl>
        Update MediaTbl
        SET storyID = <cfqueryparam value="#session.StoryID#" cfsqltype="CF_SQL_VARCHAR">
            WHERE UserID = #session.UserID#
            AND UploadUUID = '#setFileName#'
    </cfquery>
</cfloop>