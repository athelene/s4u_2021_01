<!--- Returns the members of a given circle from the CircleMemberTbl --->
<!--- CircleID is a required argument --->
<cfcomponent>

    <cffunction name="excludeMembersBK" access="remote" returnFormat="json" output="false">
        <cfargument name="memberID" required="yes" type="numeric" default="0" />
        <cfargument name="CircleID" required="yes" type="numeric" default="0" />

        <cfquery name="qryAddExc">
            insert into BKExcludeTbl
            (ExcludeUser, BookID)
            Values
            (#memberID#, #session.BookID#)
        </Cfquery>

        <cfquery name="qryMembers">

            Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'In' AS ExcStatus,
            trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First
            FROM CircleMemberTbl
            left join CircleTbl
            on CircleMemberTbl.CircleID = CircleTbl.CircleID
            join UserTbl
            on CircleMemberTbl.MemberID = UserTbl.UserID
            where CircleTbl.CircleID = #CircleID#
            AND CircleMemberTbl.MemberID not in
            (select ExcludeUser from BKExcludeTbl
            where BookID = #session.BookID#)

            UNION

            Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'Out' AS ExcStatus,
            trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First
            FROM CircleMemberTbl
            left join CircleTbl
            on CircleMemberTbl.CircleID = CircleTbl.CircleID
            join UserTbl
            on CircleMemberTbl.MemberID = UserTbl.UserID
            where CircleTbl.CircleID = #CircleID#
            AND CircleMemberTbl.MemberID in
            (select ExcludeUser from BKExcludeTbl
            where BookID = #session.storyID#)

            Order by Last, First
        </Cfquery>

        <cfreturn qryMembers />
    </cffunction>
</cfcomponent>