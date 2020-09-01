<!--- Returns the members of a given circle from the CircleMemberTbl --->
<!--- CircleID is a required argument --->
<cfcomponent>

	<cffunction name="getBookMembers" access="remote" returnFormat="json" output="false">
		<cfargument name="Circleid" required="yes" type="numeric" default="0" />

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
			where BookID = #session.bookID#)

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
			where bookID = #session.BookID#)

			order by Last, First
		</cfquery>

		<cfreturn qryMembers />
	</cffunction>
</cfcomponent>