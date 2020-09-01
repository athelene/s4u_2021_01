<!--- Delete from BookSecTbl --->
<cfquery name="qDeleteBookSec">
    delete from CircleMemberTbl
    where CircleID = #url.CircleID#
</cfquery>

<!--- Delete from Books --->
<cfquery name="qDeleteBook">
    delete from CircleTbl
    where CircleID = #url.CircleID#
</cfquery>

<cflocation url="/circles/Circles.cfm" />