<!--- Returns the members of a given circle from the CircleMemberTbl --->
<!--- CircleID is a required argument --->
<cfcomponent>

	<cffunction name="restoreMembersNBK" access="remote" returnFormat="json" output="false">
		<cfargument name="memberID" required="yes" type="numeric" default="0" />
		<cfargument name="CircleID" required="yes" type="numeric" default="0" />

		<cfquery name="qryAddExc">

			delete from TMPExcludeTbl
			where ExcludeUser = #memberID# and
			UserID = #session.UserID#
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
			(select ExcludeUser from TMPExcludeTbl
			where UserID = #session.UserID#)

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

			Order by Last, First
		</Cfquery>

		<cfreturn qryMembers />
	</cffunction>
</cfcomponent>