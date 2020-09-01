<!--- Returns the members of a given circle from the CircleMemberTbl --->
<!--- CircleID is a required argument --->
<cfcomponent>

	<cffunction name="getMembers" access="remote" returnFormat="json" output="false">
		<cfargument name="Circleid" required="yes" type="numeric" default="0" />
		<cfif isdefined ("session.storyID")>
			<cfquery name="qryMembers">

				Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'In' AS ExcStatus,
				trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID
				FROM CircleMemberTbl
				left join CircleTbl
				on CircleMemberTbl.CircleID = CircleTbl.CircleID
				join UserTbl
				on CircleMemberTbl.MemberID = UserTbl.UserID
				where CircleTbl.CircleID = #CircleID#
				AND CircleMemberTbl.MemberID not in
				(select ExcludeUser from ExcludeTbl
				where storyID = #session.storyID#)
				and CircleMemberTbl.status = 'Accepted'

				UNION

				Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'Out' AS ExcStatus,
				trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID
				FROM CircleMemberTbl
				left join CircleTbl
				on CircleMemberTbl.CircleID = CircleTbl.CircleID
				join UserTbl
				on CircleMemberTbl.MemberID = UserTbl.UserID
				where CircleTbl.CircleID = #CircleID#
				AND CircleMemberTbl.MemberID in
				(select ExcludeUser from ExcludeTbl
				where storyID = #session.storyID#)
				and CircleMemberTbl.status = 'Accepted'

				order by Last, First
			</cfquery>
			<cfelse>
				<cfquery name="qryMembers">

					Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'In' AS
					ExcStatus,
					trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID
					FROM CircleMemberTbl
					left join CircleTbl
					on CircleMemberTbl.CircleID = CircleTbl.CircleID
					join UserTbl
					on CircleMemberTbl.MemberID = UserTbl.UserID
					where CircleTbl.CircleID = #CircleID#
					and CircleMemberTbl.status = 'Accepted'

					UNION

					Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME, 'Out' AS
					ExcStatus,
					trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID
					FROM CircleMemberTbl
					left join CircleTbl
					on CircleMemberTbl.CircleID = CircleTbl.CircleID
					join UserTbl
					on CircleMemberTbl.MemberID = UserTbl.UserID
					where CircleTbl.CircleID = #CircleID#
					and CircleMemberTbl.status = 'Accepted'

					order by Last, First
				</cfquery>
		</cfif>

		<cfreturn qryMembers />
	</cffunction>

	<cffunction name="getMemberList" access="remote" returnFormat="json" output="false">
		<cfargument name="Circleid" required="yes" type="numeric" default="0" />

		<cfquery name="qryMembers">

			Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME,
			trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID,
			CircleMemberTbl.CircleID
			FROM CircleMemberTbl
			left join CircleTbl
			on CircleMemberTbl.CircleID = CircleTbl.CircleID
			join UserTbl
			on CircleMemberTbl.MemberID = UserTbl.UserID
			where CircleTbl.CircleID = #arguments.CircleID#
			and
			(CircleMemberTbl.status = 'Accepted' or CircleMemberTbl.status = 'Added')

			order by Last, First
		</cfquery>

		<cfreturn qryMembers />
	</cffunction>

	<cffunction name="searchEveryoneList" access="remote" returnFormat="json" output="false">
		<cfargument name="Circleid" required="yes" type="numeric" default="0" />
		<cfargument name="EveryoneCircle" required="yes" type="numeric" default="0" />
		<cfargument name="searchTerm" required="yes" type="string" default="0" />
		<cfquery name="searchMembers">

			Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME,
			trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID,
			#arguments.CircleID# AS CircleID, #session.userid# as Owner
			FROM CircleMemberTbl
			left join CircleTbl
			on CircleMemberTbl.CircleID = CircleTbl.CircleID
			join UserTbl
			on CircleMemberTbl.MemberID = UserTbl.UserID
			where CircleTbl.CircleID = #arguments.EveryoneCircle#
			and CircleMemberTbl.status = 'Accepted'

			and

			CircleMemberTbl.MemberID not in
			(select CircleMemberTbl.MemberID
			from CircleMemberTbl
			where CircleID = #arguments.Circleid#)
			and
			(UserDisplayName like '%#arguments.searchTerm#%'
			OR
			UserFirst like '%#arguments.searchTerm#%'
			OR
			UserLast like '%#arguments.searchTerm#%'
			OR
			UserEmail like '%#arguments.searchTerm#%')

			order by Last, First
		</cfquery>

		<cfreturn searchMembers />
	</cffunction>

	<cffunction name="addMember" access="remote" returnFormat="json" output="false">
		<cfargument name="Circleid" required="yes" type="numeric" default="0" />
		<cfargument name="memID" required="yes" type="numeric" default="0" />
		<cfargument name="userID" required="yes" type="numeric" default="0" />

		<cfquery name="qryAddMember">
			Insert into CircleMemberTbl
			(CircleID, MemberID, InvitedBy, Status)
			Values
			(#arguments.Circleid#, #arguments.memID#, #arguments.userID#, 'Added')
		</cfquery>
		<cfquery name="qryGetCircles">
			Select CircleID from CircleTbl
			where circleID = #arguments.CircleID#
			or
			(CircleOwner = #arguments.userID#)
		</cfquery>

		<cfreturn qryGetCircles />
	</cffunction>

	<cffunction name="inviteToEveryone" access="remote" returnFormat="json" output="false">
		<cfargument name="Circleid" required="yes" type="numeric" default="0" />
		<cfargument name="memID" required="yes" type="numeric" default="0" />
		<cfargument name="userID" required="yes" type="numeric" default="0" />
		<cfquery name="qGetSenderName">
			Select UserDisplayName from UserTbl
			where UserID = #arguments.userID#
		</cfquery>
		<cfquery name="qGetReceiverEmail">
			Select UserEmail from UserTbl
			where UserID = #arguments.memID#
		</cfquery>

		<cfquery name="qryAddMember">
			Insert into CircleMemberTbl
			(CircleID, MemberID, InvitedBy, Status)
			Values
			(#arguments.Circleid#, #arguments.memID#, #arguments.userID#, 'Invited')
		</cfquery>
		<cfquery name="qryGetCircles">
			Select CircleID from CircleTbl
			where circleID = #arguments.CircleID#
			or
			(CircleOwner = #arguments.UserID# and CircleSort = '0')
		</cfquery>

		<cfquery name="qryEveryoneCircles">
			Select CircleID from CircleTbl
			where circleID = #arguments.CircleID#
		</cfquery>
		<cfset vSubject=#qGetSenderName.UserDisplayName# & ' has invited you to their circles on Stories For Us!'>

			<cfmail from="Storyteller@storiesforus.com" to="#qGetReceiverEmail.UserEmail#" subject="#vSubject#"
				type="HTML">


				<div style="color:blue; margin:1em; font-size:125%">
					<cfoutput>#qGetSenderName.userdisplayname#</cfoutput> would like to add you to their Stories For Us
					circles. Please visit your Circle page to
					accept the invitation. Once you accept, you will be able to see the pages and books they
					share.<BR><BR>
				</div>

			</cfmail>

			<cfreturn #arguments.CircleID# />
	</cffunction>

	<cffunction name="removeMember" access="remote" returnFormat="json" output="false">
		<cfargument name="remID" required="yes" type="numeric" default="0" />
		<cfargument name="circleID" required="yes" type="numeric" default="0" />
		<cfquery name="qRemoveMem">
			Delete from CircleMemberTbl
			where CircleMemID = #arguments.remID#
		</cfquery>
		<cfquery name="qGetCircleID">
			Select CircleID from CircleTbl
			where CircleID = #arguments.circleID#
		</cfquery>

		<cfreturn qGetCircleID>
	</cffunction>

	<cffunction name="searchFullMemberList" access="remote" returnFormat="json" output="false">
		<cfargument name="Everyoneid" required="yes" type="numeric" default="0" />
		<cfargument name="searchTerm" required="yes" type="string" default="0" />
		<cfargument name="userid" required="yes" type="numeric" default="0" />

		<cfquery name="qryFullMembers">
			Select distinct trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME,
			trim(UserTbl.UserLast) AS UserLast, trim(UserTbl.UserFirst) AS UserFirst,
			trim(userTbl.UserEmail) AS UserEmail,
			UserTbl.UserID, #arguments.Everyoneid# AS EveryoneID
			FROM UserTbl
			left join CircleMemberTbl
			on UserTbl.Userid = CircleMemberTbl.MemberID
			where
			UserTbl.Userid <> #arguments.userid#
				and
				(
				userID NOT IN
				(select CircleMemberTbl.MemberID
				from CircleMemberTbl
				where CircleMemberTbl.CircleID = #arguments.EveryoneID#)

				)
				and UserTbl.ValidationDate IS NOT NULL
				and
				(UserDisplayName like '%#arguments.searchTerm#%'
				OR
				UserFirst like '%#arguments.searchTerm#%'
				OR
				UserLast like '%#arguments.searchTerm#%'
				OR
				UserEmail like '%#arguments.searchTerm#%')

				order by UserLast, UserFirst

		</cfquery>

		<cfreturn qryFullMembers />
	</cffunction>

	<cffunction name="getInvitedList" access="remote" returnFormat="json" output="false">
		<cfargument name="everyoneID" required="yes" type="numeric" default="0" />

		<cfquery name="qryInvitees">

			Select CircleMemberTbl.MemberID, trim(UserTbl.UserDisplayName) AS USERDISPLAYNAME,
			trim(UserTbl.UserLast) AS Last, trim(UserTbl.UserFirst) AS First, CircleMemberTbl.CircleMemID,
			CircleMemberTbl.CircleID
			FROM CircleMemberTbl
			left join CircleTbl
			on CircleMemberTbl.CircleID = CircleTbl.CircleID
			join UserTbl
			on CircleMemberTbl.MemberID = UserTbl.UserID
			where CircleTbl.CircleID = #arguments.everyoneID#
			and CircleMemberTbl.status = 'Invited'

			order by Last, First
		</cfquery>

		<cfreturn qryInvitees />
	</cffunction>

	<cffunction name="removeInvitation" access="remote" returnFormat="json" output="false">
		<cfargument name="inviteeID" required="yes" type="numeric" default="0" />
		<cfargument name="everyoneID" required="yes" type="numeric" default="0" />

		<cfquery name="qryInvitees">
			Delete from CircleMemberTbl
			where CircleMemID = #arguments.inviteeID#
		</cfquery>
		<cfquery name="qGetCircleID">
			Select CircleID from CircleTbl
			where CircleID = #arguments.everyoneID#
		</cfquery>

		<cfreturn qGetCircleID />
	</cffunction>



</cfcomponent>