<cfcomponent>

    <cffunction name="getPageView" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfargument name="LastPageView" required="yes" type="string" default="0" />
        <cfquery name="qPageViews">

            Select count(StoryTbl.StoryID) AS itemCount
            from StoryTbl
            left join UserTbl
            on StoryTbl.UserID = UserTbl.UserID
            where

            StoryTbl.StoryDate >= '#arguments.LastPageView#'

            AND

            (

            StoryTbl.UserID = #arguments.Userid#

            OR
            (
            (CircleID in
            (select CircleID from CircleMemberTbl
            where MemberID = #arguments.Userid#) )

            AND ( StoryID not in
            (Select StoryID from ExcludeTbl
            where ExcludeUser = #arguments.Userid#)
            )
            )
            )

        </cfquery>
        <cfreturn qPageViews>

            <!---         <cfreturn qPageViews /> --->
    </cffunction>

    <cffunction name="getBookView" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfargument name="LastTCView" required="yes" type="string" default="0" />
        <cfquery name="qBookViews">

            Select count(BookTbl.BookID) AS itemCount
            from BookTbl
            where

            (Booktbl.BookOwner = #arguments.Userid#

            AND

            BookTbl.BookCreateDate > '#arguments.LastTCView#'

            )

            OR

            (timecapsuledate IS NOT NULL

            AND

            BookTbl.BookCreateDate > '#arguments.LastTCView#'

            AND
            (
            (CircleID in
            (select CircleID from CircleMemberTbl
            where MemberID = #arguments.Userid#)

            AND ( BookID not in
            (Select BookID from BkExcludeTbl
            where ExcludeUser = #arguments.Userid#)
            )
            ) ) )


        </cfquery>

        <cfreturn qBookViews />
    </cffunction>

    <cffunction name="getTCView" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfargument name="LastTCView" required="yes" type="string" default="0" />
        <cfquery name="qTCViews">

            Select count(BookTbl.BookID) AS itemCount
            from BookTbl
            where

            (Booktbl.BookOwner = #arguments.Userid#

            AND

            BookTbl.BookCreateDate > '#arguments.LastTCView#'

            AND

            timecapsuledate IS NOT NULL)

            OR

            (timecapsuledate IS NOT NULL

            AND

            BookTbl.BookCreateDate > '#arguments.LastTCView#'

            AND
            (
            (CircleID in
            (select CircleID from CircleMemberTbl
            where MemberID = #arguments.Userid#)

            AND ( BookID not in
            (Select BookID from BkExcludeTbl
            where ExcludeUser = #arguments.Userid#)
            )
            ) ) )

        </cfquery>

        <cfreturn qTCViews />
    </cffunction>

    <cffunction name="getCircleView" access="remote" returnFormat="json" output="false">
        <cfargument name="Userid" required="yes" type="numeric" default="0" />
        <cfquery name="qCircleView">
            Select count(CircleMemberTbl.CircleMemID) AS itemCount
            from CircleMemberTbl
            where MemberID = #session.userid#
            AND status = 'Invited'
        </cfquery>

        <cfreturn qCircleView />
    </cffunction>
</cfcomponent>