<!--- Delete from MediaTbl --->
<cfquery name="qDeleteMedia">
    delete from MediaTbl
    where MediaID = #url.DeleteMediaRec#
</cfquery>

<cflocation url="EditPage.cfm?EditStory&StoryID=#session.storyID#">