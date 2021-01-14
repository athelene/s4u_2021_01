<cfcomponent>
    <!--- Display all story Media for selection --->
    <cffunction name="featureMedia" access="remote" returnFormat="json" output="false">
        <cfargument name="storyID" required="yes" type="numeric" default="0" />
        <cfquery name="qGetMedia">
            Select MediaID, MediaLoc, MediaType, FeatureMedia, UserID from MediaTbl
            where StoryID = #session.storyID#
            order by FeatureMedia, MediaID
        </cfquery>
        <cfreturn qGetMedia>
    </cffunction>

    <cffunction name="setMedia" access="remote" returnFormat="json" output="false">
        <cfargument name="mediaID" required="yes" type="numeric" default="0" />
        <cfargument name="storyID" required="yes" type="numeric" default="0" />
        <cfargument name="userID" required="yes" type="numeric" default="0" />

        <cfquery name="qUnsetFeature">
            update MediaTbl
            set FeatureMedia = 2
            where storyID = #arguments.storyID# and UserID = #arguments.userID#
        </cfquery>

        <cfquery name="qSetFeature">
            update MediaTbl
            set FeatureMedia = 1
            where MediaID = #arguments.MediaID# and UserID = #arguments.userID#
        </cfquery>
        <cfquery name="qSetMedia">
            Select MediaID, storyID, userID from MediaTbl
            where mediaID = #arguments.mediaID#
        </cfquery>

        <cfreturn qSetMedia>
    </cffunction>

    <cffunction name="newMedia" access="remote" returnFormat="json" output="false">
        <cfargument name="userID" required="yes" type="numeric" default="0" />
        <cfquery name="qNewMedia">
            Select MediaID, MediaLoc, MediaType, FeatureMedia, UserID from MediaTbl
            where StoryID = 0 AND userID = #arguments.userID#
            order by FeatureMedia, MediaID
        </cfquery>
        <cfreturn qNewMedia>
    </cffunction>
    
    <cffunction name="deleteMedia" access="remote" returnFormat="json" output="false">
        <cfargument name="mediaID" required="yes" type="numeric" default="0" />
        <cfquery name="qDeleteMedia">
            delete from MediaTbl
            where MediaID = #arguments.mediaID#
        </cfquery>
        <cfreturn>
    </cffunction>
</cfcomponent>