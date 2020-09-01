<!--- Get the user's Everyone Circle CircleID, set as session variable --->
<cfquery name="qGetEveryoneCircle">
    Select CircleID
    from CircleTbl
    where CircleOwner = #session.UserID#
    AND
    CircleSort = '0'
</cfquery>

<cfset session.MyCircleID=qGetEveryoneCircle.CircleID>

    <!--- Get the story info to display to user --->
    <cfquery name="qGetStoryInfo">
        Select StoryTitle, CircleID from
        StoryTbl
        where storyID = #session.StoryID#
    </cfquery>

    <!--- Find the names of the people already excluded from the page --->
    <cfquery name="qGetExcludes">
        Select ExcludeUser, ExcludeID, storyID, UserID, UserLast, UserFirst, UserDisplayName
        from ExcludeTbl
        join UserTbl
        on ExcludeTbl.ExcludeUser = UserTbl.UserID
        where ExcludeTbl.StoryID = #session.storyid#
    </cfquery>

    <!--- Find the names of the people not in the circle but not yet excluded --->
    <cfquery name="qExcludeFromList">
        Select UserID, UserLast, UserFirst, UserDisplayName
        from UserTbl
        where UserID in
        (select MemberID
        from CircleMemberTbl
        Where circleID = #qGetStoryInfo.CircleID#
        AND MemberID <> #session.userID#)
            AND UserID not in
            (select ExcludeUser
            from ExcludeTbl
            Where ExcludeTbl.storyID = #session.storyID#)
            order by UserLast, UserFirst
    </cfquery>

    <cfoutput>
        <div class="text-center">
            <h3>Select People to Exclude From Seeing "#qGetStoryInfo.StoryTitle#"</h3><BR>
        </div>

        <!--- Form to present a dropdown to see the names in the circle, not yet excluded --->
        <cfform action="stories/InsertIntoExcludeId.cfm" enctype="multipart/form-data">

            <select class="mdb-select md-form colorful-select dropdown-secondary" name="ExcludeID" multiple="multiple">
                <option value="None" disabled selected>No additional names selected</option>
                <cfloop query="qExcludeFromList">
                    <option value="#qExcludeFromList.UserID#">#qExcludeFromList.UserDisplayName#</option>
                </cfloop>
            </select>
            <label class="mdb-main-label">Search Names to Exclude</label>
            <button type="submit" class="btn btn-secondary" title="Exclude this person">Save & Continue</button>
        </cfform>
        <!--- Show the names already excluded --->
        <BR>
        <cfif qGetExcludes.RecordCount GT 0>
            Excluded:<BR><BR>
            <cfloop query="qGetExcludes">
                <div>
                    #qGetExcludes.UserDisplayName# <a
                        href="/stories/RemoveExclude.cfm?ExcludeID=#qGetExcludes.ExcludeID#">x</a>
                </div>
            </cfloop>
        </cfif>

    </cfoutput>