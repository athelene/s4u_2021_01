<!--- Returns all of a users circles with their ID and name --->
<!--- Requires Session.UserID --->
<cfcomponent>

    <cffunction name="getMyTCs" access="remote" returnFormat="json" output="false">
        <cfargument name="aUserID" required="yes" type="numeric" default="0">
            <cfquery name="qMyBooks">
                Select BookTbl.*
                from BookTbl
                where BookOwner = #session.userid#
                and timecapsuledate IS NOT NULL
                order by BookCreateDate Desc, BookTitle
            </cfquery>
            <cfif qMyBooks.RecordCount IS 0>
                <cfreturn "You haven't created any yet." />
                <cfelse>
                    <cfreturn qMyBooks />
            </cfif>
    </cffunction>

    <cffunction name="getOtherTCs" access="remote" returnFormat="json" output="false">
        <cfargument name="aUserID" required="yes" type="numeric" default="0">
            <cfquery name="qOtherBooks">
                Select BookTbl.BookID, trim(BookTbl.BookTitle) AS BookTitle, BookTbl.BookOwner, BookTbl.TimeCapsuleDate,
                BookTbl.BookCreateDate, BookTbl.ContentType, BookTbl.CircleID, UserTbl.UserDisplayName
                from BookTbl
                left join UserTbl
                on BookTbl.BookOwner = usertbl.Userid
                where

                (timecapsuledate <= '#session.todayis#' AND ( (CircleID in (select CircleID from CircleMemberTbl where
                    MemberID=#session.UserID#) AND ( BookID not in (Select BookID from BkExcludeTbl where
                    ExcludeUser=#session.UserID#) ) ) ) ) order by BookCreateDate desc </cfquery> <cfif
                    qOtherBooks.RecordCount IS 0>
                    <cfreturn "You haven't created any yet." />
                    <cfelse>
                        <cfreturn qOtherBooks />
                        </cfif>
    </cffunction>

    <cffunction name="getAllTCs" access="remote" returnFormat="json" output="false">
        <cfargument name="aUserID" required="yes" type="numeric" default="0">
            <cfquery name="qAllBooks">
                Select BookTbl.BookID, trim(BookTbl.BookTitle) AS BookTitle, BookTbl.BookOwner, BookTbl.TimeCapsuleDate,
                BookTbl.BookCreateDate, BookTbl.ContentType, BookTbl.CircleID, UserTbl.UserDisplayName
                from BookTbl
                left join UserTbl
                on BookTbl.BookOwner = usertbl.Userid
                where

                (Booktbl.BookOwner = #session.userid#

                AND

                timecapsuledate IS NOT NULL)

                OR

                (timecapsuledate IS NOT NULL

                AND
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
            </cfquery>
            <cfif qAllBooks.RecordCount IS 0>
                <cfreturn "You haven't created any yet." />
                <cfelse>
                    <cfreturn qAllBooks />
            </cfif>
    </cffunction>
</cfcomponent>