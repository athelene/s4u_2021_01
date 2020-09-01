    <cffunction name="getMedia" access="remote" returnFormat="json" output="false">
        <cfargument name="astoryID" required="yes" type="numeric" default="0">

            <cfquery name="qMedia">
                Select StoryTbl.StoryID, MediaLoc, min(MediaID)
                from MediaTbl
                where StoryTbl.StoryID = #arguments.aStoryID#
                order by FeaturedMedia, MediaID
            </cfquery>
            <cfreturn qMedia />
            </cfif>
    </cffunction>