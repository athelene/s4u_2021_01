<!--- Returns Books and TCs for a given page --->
<!--- Requires storyID --->
<cfcomponent>

    <cffunction name="getBookList" access="remote" returnFormat="json" output="false">
        <cfargument name="aStoryID" required="yes" type="numeric" default="0">
            <cfargument name="aUserID" required="yes" type="numeric" default="0">
                <cfquery name="qBookList">
                    Select BookContentTbl.BookID, BookContentTbl.StoryID, trim(BookTbl.BookTitle) AS BookTitle,
                    BookTbl.BookOwner, BookTbl.TimeCapsuleDate, trim(UserDisplayName) as UserDisplayName, 0 AS Owner
                    from BookContentTbl
                    left join BookTbl
                    on BookContentTbl.BookID = BookTbl.BookID
                    left join UserTbl
                    on BookTbl.BookOwner = UserTbl.UserID
                    where

                    BookContentTbl.StoryID = #arguments.aStoryID#
                    and BookTbl.BookOwner <> #arguments.aUserID#

                        UNION ALL

                        Select BookContentTbl.BookID, BookContentTbl.StoryID, trim(BookTbl.BookTitle) AS BookTitle,
                        BookTbl.BookOwner, BookTbl.TimeCapsuleDate, trim(UserDisplayName) as UserDisplayName, 1 AS Owner
                        from BookContentTbl
                        left join BookTbl
                        on BookContentTbl.BookID = BookTbl.BookID
                        left join UserTbl
                        on BookTbl.BookOwner = UserTbl.UserID
                        where

                        BookContentTbl.StoryID = #arguments.aStoryID#
                        and BookTbl.BookOwner = #arguments.aUserID#

                        order by TimeCapsuleDate, BookTitle
                </cfquery>

                <cfif qBookList.RecordCount LT 1>
                    <cfreturn " " />
                    <cfelse>
                        <cfreturn qBookList />
                </cfif>

    </cffunction>

</cfcomponent>