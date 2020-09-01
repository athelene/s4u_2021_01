<!--- Returns the members of a given circle from the CircleMemberTbl --->
<!--- CircleID is a required argument --->
<cfcomponent>

	<cffunction name="getNewBookMembers" access="remote" returnFormat="json" output="false">
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
			(select ExcludeUser from TMPExcludeTbl
			where userID = #session.UserID#)

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
			(select ExcludeUser from TMPExcludeTbl
			where UserID = #session.UserID#)

			order by Last, First
		</cfquery>

		<cfreturn qryMembers />
	</cffunction>
</cfcomponent>