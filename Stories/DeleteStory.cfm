<!--- delete from StoryTbl --->
<cfquery name="qDeletePage">
    delete from StoryTbl
    where StoryID = #url.storyID#
</cfquery>


<cfset url.StoryID=0>


    END OF delete STORY
    <cflocation url="/library_pages.cfm">