<!--- delete from StoryTbl --->
<cfquery name="qDeletePage">
    delete from StoryTbl
    where StoryID = #url.storyID#
</cfquery>

<cfquery name="qDeleteFromBooks">
    delete from BookContentTbl
    where StoryID = #url.storyID#
</cfquery>

<cfset url.StoryID=0>


    END OF delete STORY
    <cflocation url="/HomePage.cfm">