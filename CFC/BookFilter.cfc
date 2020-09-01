<!--- Returns all of a users circles with their ID and name --->
<!--- Requires Session.UserID --->
<cfcomponent>

    <cffunction name="getMyBooks" access="remote" returnFormat="json" output="false">
        <cfargument name="aUserID" required="yes" type="numeric" default="0">
            <cfargument name="aBooks" required="yes" type="string" default="0">
                <cfargument name="aTCs" required="yes" type="string" default="0">

                    <cfquery name="qGetUserName">
                        Select UserDisplayName from UserTbl
                        where #arguments.aUserID# = UserID
                    </cfquery>

                    <cfquery name="qMyBooks">
                        Select BookTbl.BookID, trim(BookTbl.BookTitle) AS BookTitle, BookTbl.BookOwner,
                        BookTbl.TimeCapsuleDate,
                        BookTbl.BookCreateDate, BookTbl.ContentType, BookTbl.CircleID,
                        '#trim(qGetUserName.UserDisplayName)#' as UserDisplayName
                        from BookTbl
                        where BookOwner = #session.UserID#
                        <cfif arguments.aBooks IS "on" AND arguments.aTCs IS "off">
                            and timecapsuledate IS NULL
                            <cfelseif arguments.aBooks is "off" AND arguments.aTCs IS "on">
                                and timecapsuledate IS NOT NULL
                                <cfelseif arguments.aBooks is "off" AND arguments.aTCs IS "off">
                                    and bookID IS NULL
                                    <cfelse>
                                        and bookID > 0
                        </cfif>
                        order by BookCreateDate Desc, BookTitle
                    </cfquery>
                    <cfif qMyBooks.RecordCount IS 0>
                        <cfreturn "You haven't created any yet." />
                        <cfelse>
                            <cfreturn qMyBooks />
                    </cfif>
    </cffunction>

    <cffunction name="getOtherBooks" access="remote" returnFormat="json" output="false">
        <cfargument name="aUserID" required="yes" type="numeric" default="0">
            <cfargument name="aBooks" required="yes" type="string" default="0">
                <cfargument name="aTCs" required="yes" type="string" default="0">

                    <cfquery name="qGetUserName">
                        Select UserDisplayName from UserTbl
                        where #arguments.aUserID# = UserID
                    </cfquery>

                    <cfquery name="qOtherBooks">
                        Select BookTbl.BookID, trim(BookTbl.BookTitle) AS BookTitle, BookTbl.BookOwner,
                        BookTbl.TimeCapsuleDate,
                        BookTbl.BookCreateDate, BookTbl.ContentType, BookTbl.CircleID, UserTbl.UserDisplayName
                        from BookTbl
                        left join UserTbl
                        on BookTbl.BookOwner = usertbl.Userid
                        where

                        (

                        BookOwner <> #arguments.aUserID# AND

                            ( timecapsuledate <= '#session.todayis#' or timecapsuledate IS NULL) AND <cfif
                                arguments.aBooks IS "on" AND arguments.aTCs IS "off">
                                timecapsuledate IS NULL and
                                <cfelseif arguments.aBooks is "off" AND arguments.aTCs IS "on">
                                    timecapsuledate <= '#session.todayis#' and <cfelseif arguments.aBooks is "off" AND
                                        arguments.aTCs IS "off">
                                        bookID IS NULL and
                                        <cfelse>
                                            ( timecapsuledate <= '#session.todayis#' or timecapsuledate IS NULL) and
                                                </cfif> ( (CircleID in (select CircleID from CircleMemberTbl where
                                                MemberID=#session.UserID#) AND ( BookID not in (Select BookID from
                                                BkExcludeTbl where ExcludeUser=#session.UserID#) ) ) ) ) order by
                                                BookCreateDate desc </cfquery> <cfif qOtherBooks.RecordCount IS 0>
                                                <cfreturn "No books found." />
                                                <cfelse>
                                                    <cfreturn qOtherBooks />
                                                    </cfif>
    </cffunction>

    <cffunction name="getAllBooks" access="remote" returnFormat="json" output="false">
        <cfargument name="aUserID" required="yes" type="numeric" default="0">
            <cfargument name="aBooks" required="yes" type="string" default="0">
                <cfargument name="aTCs" required="yes" type="string" default="0">

                    <cfquery name="qAllBooks">
                        Select BookTbl.BookID, trim(BookTbl.BookTitle) AS BookTitle, BookTbl.BookOwner,
                        BookTbl.TimeCapsuleDate,
                        BookTbl.BookCreateDate, BookTbl.ContentType, BookTbl.CircleID, UserTbl.UserDisplayName
                        from BookTbl
                        left join UserTbl
                        on BookTbl.BookOwner = usertbl.Userid
                        where

                        (Booktbl.BookOwner = #session.UserID#

                        AND

                        <cfif arguments.aBooks IS "on" AND arguments.aTCs IS "off">
                            timecapsuledate IS NULL
                            <cfelseif arguments.aBooks is "off" AND arguments.aTCs IS "on">
                                timecapsuledate IS NOT NULL
                                <cfelseif arguments.aBooks is "off" AND arguments.aTCs IS "off">
                                    bookID IS NULL
                                    <cfelse>
                                        bookID > 0
                        </cfif>

                        )

                        OR

                        ( BookOwner <> #arguments.aUserID# AND

                            ( timecapsuledate <= '#session.todayis#' or timecapsuledate IS NULL) AND ( <cfif
                                arguments.aBooks IS "on" AND arguments.aTCs IS "off">
                                timecapsuledate IS NULL
                                <cfelseif arguments.aBooks is "off" AND arguments.aTCs IS "on">
                                    timecapsuledate <= '#session.todayis#' <cfelseif arguments.aBooks is "off" AND
                                        arguments.aTCs IS "off">
                                        bookID IS NULL
                                        <cfelse>
                                            bookID > 0
                                            </cfif>

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
                                            )

                                            order by BookCreateDate desc
                    </cfquery>
                    <cfif qAllBooks.RecordCount IS 0>
                        <cfreturn "You haven't created any yet." />
                        <cfelse>
                            <cfreturn qAllBooks />
                    </cfif>
    </cffunction>
</cfcomponent>