<!--- Returns the members of a given circle from the CircleMemberTbl --->
<!--- CircleID is a required argument --->
<cfcomponent>

    <cffunction name="excludeMembers" access="remote" returnFormat="json" output="false">
        <cfargument name="memberID" required="yes" type="numeric" default="0" />
        <cfargument name="CircleID" required="yes" type="numeric" default="0" />

        <cfquery name="qryAddExc">
            insert into ExcludeTbl
            (ExcludeUser, StoryID)
            Values
            (#memberID#, #session.storyID#)
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
            AND CircleMemberTbl.Status <> 'Invited'
            AND CircleMemberTbl.MemberID not in
            (select ExcludeUser from ExcludeTbl
            where storyID = #session.storyID#)

            UNION

            Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'Out' AS ExcStatus,
            trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First
            FROM CircleMemberTbl
            left join CircleTbl
            on CircleMemberTbl.CircleID = CircleTbl.CircleID
            join UserTbl
            on CircleMemberTbl.MemberID = UserTbl.UserID
            where CircleTbl.CircleID = #CircleID#
            AND CircleMemberTbl.Status <> 'Invited'
            AND CircleMemberTbl.MemberID in
            (select ExcludeUser from ExcludeTbl
            where storyID = #session.storyID#)

            Order by Last, First
        </cfquery>

        <cfreturn qryMembers />
    </cffunction>
</cfcomponent>