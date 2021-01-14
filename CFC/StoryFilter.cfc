<!--- Returns all of a users circles with their ID and name --->
<!--- Requires Session.UserID --->
<cfcomponent>

     <cffunction name="getMyStories" access="remote" returnFormat="json" output="false">
          <cfargument name="aUserID" required="yes" type="numeric" default="0">
          <cfargument name="aPrimaryCircle" required="yes" type="numeric" default="0">
          <cfargument name="aStories" required="yes" type="string" default="0">
          <cfargument name="aInterviews" required="yes" type="string" default="0">
          <cfargument name="aRecipes" required="yes" type="string" default="0">
          <cfargument name="aTraditions" required="yes" type="string" default="0">

          <cfset wClause=''>

          <cfif aStories IS 'on'>
               <cfset wClause='(StoryTypeID = 1 '>
          </cfif>

          <cfif arguments.aInterviews IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 2 '>
                    <cfelseif (arguments.aInterviews IS 'on' and len(wClause) LT 1)>
                         <cfset wClause=wClause & '(StoryTypeID = 2 '>
                              <cfelseif arguments.aInterviews IS 'off'>

          </cfif>

          <cfif arguments.aRecipes IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 3 '>
                    <cfelseif arguments.aRecipes IS 'on' and len(wClause) LT 1>
                         <cfset wClause=wClause & '(StoryTypeID = 3 '>
                              <cfelseif arguments.aRecipes IS 'off'>
          </cfif>

          <cfif arguments.aTraditions IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 4 '>
                    <cfelseif arguments.aTraditions IS 'on' and len(wClause) LT 1>
                         <cfset wClause=wClause & '(StoryTypeID = 4 '>
                              <cfelseif arguments.aTraditions IS 'off' AND len(wClause) LT
                                   1>
                                   <cfset wClause='(StoryTypeID = -1'>
          </cfif>
          
          <cfif len(wClause) GT 0>
               <cfset wClause=wClause & ')'>
          </cfif>

          <cfquery name="qMyStories">

               Select StoryTbl.StoryID, trim(StoryTbl.StoryTitle) as StoryTitle,
               trim(Storytbl.StoryText) as StoryText, StoryTbl.Userid,
               StoryTbl.StoryTypeID, FORMAT (Storytbl.StoryDate, 'MMM dd, yyyy') as date,
               trim(StoryTbl.Interviewee) as Interviewee, StoryTbl.CircleID,
               trim(UserTbl.UserDisplayName) as UserDisplayName,
               StoryTbl.StoryIngredients, UserTbl.UserMediaLoc,
               MediaTbl.MediaLoc, MediaTbl.MediaID, mediaTbl.FeatureMedia,
               mediaTbl.mediaType
               from StoryTbl
               left join UserTbl
               on StoryTbl.UserID = UserTbl.UserID
               left join MediaTbl
               on (StoryTbl.StoryID = MediaTbl.StoryID AND MediaTbl.FeatureMedia = 1)

               where StoryTbl.UserID = #session.Userid# AND
               #wClause#
               order by StoryDate Desc, StoryTitle
          </cfquery>
          <cfif qMyStories.RecordCount IS 0>
               <cfreturn "No pages fit your selection." />
               <cfelse>
                    <cfset results=arguments.aStories & ', ' & arguments.aInterviews
                         & ', ' & arguments.aRecipes>

                         <cfreturn qMyStories />
          </cfif>
     </cffunction>

     <cffunction name="getOtherStories" access="remote" returnFormat="json" output="false">
          <cfargument name="aUserID" required="yes" type="numeric" default="0">
          <cfargument name="aPrimaryCircle" required="yes" type="numeric" default="0">
          <cfargument name="aStories" required="yes" type="string" default="0">
          <cfargument name="aInterviews" required="yes" type="string" default="0">
          <cfargument name="aRecipes" required="yes" type="string" default="0">
          <cfargument name="aTraditions" required="yes" type="string" default="0">

          <cfset wClause=''>

          <cfif aStories IS 'on'>
               <cfset wClause='(StoryTypeID = 1 '>
          </cfif>

          <cfif arguments.aInterviews IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 2 '>
                    <cfelseif (arguments.aInterviews IS 'on' and len(wClause) LT 1)>
                         <cfset wClause=wClause & '(StoryTypeID = 2 '>
                              <cfelseif arguments.aInterviews IS 'off'>

          </cfif>

          <cfif arguments.aRecipes IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 3 '>
                    <cfelseif arguments.aRecipes IS 'on' and len(wClause) LT 1>
                         <cfset wClause=wClause & '(StoryTypeID = 3 '>
                              <cfelseif arguments.aRecipes IS 'off'>
          </cfif>

          <cfif arguments.aTraditions IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 4 '>
                    <cfelseif arguments.aTraditions IS 'on' and len(wClause) LT 1>
                         <cfset wClause=wClause & '(StoryTypeID = 4 '>
                              <cfelseif arguments.aTraditions IS 'off' AND len(wClause) LT
                                   1>
                                   <cfset wClause='(StoryTypeID = -1'>
          </cfif>

          <cfif len(wClause) GT 0>
               <cfset wClause=wClause & ')'>
          </cfif>

          <cfquery name="qOtherStories">
               Select StoryTbl.StoryID, trim(StoryTbl.StoryTitle) as StoryTitle,
               trim(Storytbl.StoryText) as StoryText, StoryTbl.Userid,
               StoryTbl.StoryTypeID, FORMAT (Storytbl.StoryDate, 'MMM dd, yyyy') as date,
               trim(StoryTbl.Interviewee) as Interviewee, StoryTbl.CircleID,
               trim(UserTbl.UserDisplayName) as UserDisplayName,
               StoryTbl.StoryIngredients, UserTbl.UserMediaLoc,
               MediaTbl.MediaLoc, MediaTbl.MediaID, mediaTbl.FeatureMedia,
               mediaTbl.mediaType
               from StoryTbl
               left join UserTbl
               on StoryTbl.UserID = UserTbl.UserID
               left join MediaTbl
               on (StoryTbl.StoryID = MediaTbl.StoryID AND MediaTbl.FeatureMedia = 1)

               where 
  
               (#wClause# 
               AND StoryTbl.CircleID = #arguments.aPrimaryCircle# 
               AND StoryTbl.UserID <> #arguments.aUserID#
               )

                    OR (

                    #wClause#
                    AND
                    (
                    (CircleID in
                    (select CircleID from CircleMemberTbl
                    where MemberID = #session.UserID#) )

                    AND ( StoryTbl.StoryID not in
                    (Select StoryID from ExcludeTbl
                    where ExcludeUser = #session.UserID#)
                    )
                    ) 
                    
                    )

                    order by StoryDate Desc, StoryTitle
          </cfquery>
          <cfif qOtherStories.RecordCount IS 0>
               <cfreturn "No pages fit your selection." />
               <cfelse>
                    <cfreturn qOtherStories />
          </cfif>
     </cffunction>

     <cffunction name="getAllStories" access="remote" returnFormat="json" output="false">
          <cfargument name="aUserID" required="yes" type="numeric" default="0">
          <cfargument name="aPrimaryCircle" required="yes" type="numeric" default="0">
          <cfargument name="aStories" required="yes" type="string" default="0">
          <cfargument name="aInterviews" required="yes" type="string" default="0">
          <cfargument name="aRecipes" required="yes" type="string" default="0">
          <cfargument name="aTraditions" required="yes" type="string" default="0">

          <cfset wClause=''>

          <cfif aStories IS 'on'>
               <cfset wClause='(StoryTypeID = 1 '>
          </cfif>

          <cfif arguments.aInterviews IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 2 '>
                    <cfelseif (arguments.aInterviews IS 'on' and len(wClause) LT 1)>
                         <cfset wClause=wClause & '(StoryTypeID = 2 '>
                              <cfelseif arguments.aInterviews IS 'off'>

          </cfif>

          <cfif arguments.aRecipes IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 3 '>
                    <cfelseif arguments.aRecipes IS 'on' and len(wClause) LT 1>
                         <cfset wClause=wClause & '(StoryTypeID = 3 '>
                              <cfelseif arguments.aRecipes IS 'off'>
          </cfif>

          <cfif arguments.aTraditions IS 'on' and len(wClause) GT 0>
               <cfset wClause=wClause & 'or StoryTypeID = 4 '>
                    <cfelseif arguments.aTraditions IS 'on' and len(wClause) LT 1>
                         <cfset wClause=wClause & '(StoryTypeID = 4 '>
                              <cfelseif arguments.aTraditions IS 'off' AND len(wClause) LT
                                   1>
                                   <cfset wClause='(StoryTypeID = -1'>
          </cfif>

          <cfif len(wClause) GT 0>
               <cfset wClause=wClause & ')'>
          </cfif>

          <cfquery name="qAllStories">
               Select StoryTbl.StoryID, trim(StoryTbl.StoryTitle) as StoryTitle,
               trim(Storytbl.StoryText) as StoryText, StoryTbl.Userid,
               StoryTbl.StoryTypeID, FORMAT (Storytbl.StoryDate, 'MMM dd, yyyy') as date,
               trim(StoryTbl.Interviewee) as Interviewee, StoryTbl.CircleID,
               trim(UserTbl.UserDisplayName) as UserDisplayName,
               StoryTbl.StoryIngredients, UserTbl.UserMediaLoc,
               MediaTbl.MediaLoc, MediaTbl.MediaID, mediaTbl.FeatureMedia,
               mediaTbl.mediaType
               from StoryTbl
               left join UserTbl
               on StoryTbl.UserID = UserTbl.UserID
               left join MediaTbl
               on (StoryTbl.StoryID = MediaTbl.StoryID AND MediaTbl.FeatureMedia = 1)

               where 
  
               (#wClause# 
               AND StoryTbl.CircleID = #arguments.aPrimaryCircle# 
               )

                    OR (

                    #wClause#
                    AND
                    (
                    (CircleID in
                    (select CircleID from CircleMemberTbl
                    where MemberID = #session.UserID#) )

                    AND ( StoryTbl.StoryID not in
                    (Select StoryID from ExcludeTbl
                    where ExcludeUser = #session.UserID#)
                    )
                    )
                    
                    OR storyTbl.UserID = #session.UserID# AND #wClause#)

                    order by StoryDate Desc, StoryTitle
          </cfquery>
          <cfif qAllStories.RecordCount IS 0>
               <cfreturn "No pages fit your selection." />
               <cfelse>
                    <cfreturn qAllStories />
          </cfif>
     </cffunction>
</cfcomponent>