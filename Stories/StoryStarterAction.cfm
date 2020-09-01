<!--- Set Story Date --->
<cfset StoryDate=datetimeformat(now(), "YYYY-MM-DD HH:nn:ss" )>

    <!--- Check for title  --->
    <cfif #form.StoryTitle# EQ "">
        <cfset form.StoryTitle=StoryDate>
    </cfif>

    <cfif form.StoryTypeID IS 2>

        <cfquery name="qInsertStory" result="resStoryID">
            insert into StoryTbl
            (StoryTitle, StoryText, Interviewee, UserID, StoryTypeID, StoryDate, CircleID)
            Values
            ('#TRIM(form.storyTitle)#', '#TRIM(form.storyText)#', '#TRIM(form.Interviewee)#', #session.userid#,
            #form.StoryTypeID#, '#storydate#',
            #form.CircleID#)
        </cfquery>

        <cfelseif form.StoryTypeID IS 3>
            <cfquery name="qInsertStory" result="resStoryID">
                insert into StoryTbl
                (StoryTitle, StoryText, StoryIngredients, UserID, StoryTypeID, StoryDate, CircleID)
                Values
                ('#TRIM(form.storyTitle)#', '#TRIM(form.storyText)#', '#TRIM(form.storyIngredients)#', #session.userid#,
                #form.StoryTypeID#, '#storydate#',
                #form.CircleID#)
            </cfquery>

            <cfelse>
                <cfquery name="qInsertStory" result="resStoryID">
                    insert into StoryTbl
                    (StoryTitle, StoryText, UserID, StoryTypeID, StoryDate, CircleID)
                    Values
                    ('#TRIM(form.storyTitle)#', '#TRIM(form.storyText)#', #session.userid#, #form.StoryTypeID#,
                    '#storydate#',
                    #form.CircleID#)
                </cfquery>
    </cfif>



    <!--- Create New StoryID --->
    <cfset NewStoryID=#resStoryID.generatedkey#>

        <cfset session.StoryID=NewStoryID>

            <cfquery name="qGetMedia">
                Select * from MediaTbl
                where StoryID = 0
                AND userID = #session.UserID#
                order by featureMedia desc
            </cfquery>
            <cfset mediaIndex=1>
                <cfloop query="qGetMedia">
                    <cfif mediaIndex IS 1>
                        <cfquery name="qUpdateMediaTbl">
                            Update MediaTbl
                            SET StoryID = <cfqueryparam value="#session.StoryID#" cfsqltype="CF_SQL_INTEGER">,
                                featureMedia = <cfqueryparam value=1 cfsqltype="CF_SQL_INTEGER">
                                    WHERE mediaID = #qGetMedia.MediaID#
                        </cfquery>
                        <cfelse>
                            <cfquery name="qUpdateMediaTbl">
                                Update MediaTbl
                                SET StoryID = <cfqueryparam value="#session.StoryID#" cfsqltype="CF_SQL_INTEGER">,
                                    featureMedia = <cfqueryparam value=2 cfsqltype="CF_SQL_INTEGER">
                                        WHERE mediaID = #qGetMedia.MediaID#
                            </cfquery>
                    </cfif>
                    <cfset mediaIndex=mediaIndex + 1>
                </cfloop>



                <cflocation url="/stories/story.cfm?StoryID=#session.StoryID#">