<cfcomponent>
    <!--- Search Pages --->
    <cffunction name="searchPages" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfargument name="SearchTerm" required="yes" type="String" default="0" />
        <cfquery name="qSearchPages">
            DROP TABLE IF EXISTS ##pageTemp

            Select StoryTbl.StoryID, trim(StoryTbl.StoryTitle) as StoryTitle, trim(Storytbl.StoryText) as StoryText,
            StoryTbl.Userid, StoryTbl.StoryTypeID, Storytbl.StoryDate,
            trim(StoryTbl.Interviewee) as Interviewee, StoryTbl.CircleID, trim(UserTbl.UserDisplayName) as
            UserDisplayName, StoryTbl.StoryIngredients, UserTbl.UserMediaLoc
            into ##pageTemp
            from StoryTbl
            left join UserTbl
            on StoryTbl.UserID = UserTbl.UserID
            where

            StoryTbl.storyid > 0

            AND StoryTypeID >= 1

            OR (


            StoryTypeID >= 1

            AND
            (
            (CircleID in
            (select CircleID from CircleMemberTbl
            where MemberID = #session.UserID#) )

            AND ( StoryID not in
            (Select StoryID from ExcludeTbl
            where ExcludeUser = #session.UserID#)
            )
            ) )

            order by StoryDate Desc, StoryTitle

            Select StoryID, trim(StoryTitle) as StoryTitle, trim(StoryText) as StoryText, Userid, StoryTypeID,
            StoryDate,
            trim(Interviewee) as Interviewee, CircleID, trim(UserDisplayName) as UserDisplayName, StoryIngredients,
            UserMediaLoc
            from ##pageTemp
            where
            (StoryTitle like '%#arguments.SearchTerm#%' or StoryText like '%#arguments.SearchTerm#%' or StoryIngredients
            like '%#arguments.SearchTerm#%')

        </cfquery>
        <cfreturn qSearchPages>
    </cffunction>

    <cffunction name="searchBooks" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfargument name="SearchTerm" required="yes" type="String" default="0" />
        <cfquery name="qSearchBooks">
            DROP TABLE IF EXISTS ##bookTemp

            Select BookTbl.BookID, trim(BookTbl.BookTitle) AS BookTitle, BookTbl.BookOwner, BookTbl.TimeCapsuleDate,
            BookTbl.BookCreateDate, BookTbl.ContentType, BookTbl.CircleID, UserTbl.UserDisplayName
            into ##bookTemp
            from BookTbl
            left join UserTbl
            on BookTbl.BookOwner = usertbl.Userid
            where

            (Booktbl.BookOwner = #session.userid#

            )

            OR

            (
            (
            (CircleID in
            (select CircleID from CircleMemberTbl
            where MemberID = #session.Userid#)

            AND ( BookID not in
            (Select BookID from BkExcludeTbl
            where ExcludeUser = #session.userid#)
            )
            ) ) )

            order by BookCreateDate desc


            Select BookID, BookTitle, BookCreateDate, UserDisplayName, TimeCapsuleDate
            from ##bookTemp
            where
            (BookTitle like '%#arguments.SearchTerm#%')

        </cfquery>
        <cfreturn qSearchBooks>
    </cffunction>

</cfcomponent>