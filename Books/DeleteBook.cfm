<!--- Delete from BookSecTbl --->
<cfquery name="qDeleteBookSec">
    delete from BookSecTbl
    where ContentID = #session.DeleteBookID#
</cfquery>

<!--- Delete from Books --->
<cfquery name="qDeleteBook">
    delete from BookTbl
    where BookID = #session.DeleteBookID#
</cfquery>



<!--- Create New StoryID --->
<cfset session.DeleteBookID=0 />


END OF delete BOOK
<cflocation url="/Redirect.cfm?goToPage=#session.returnto#" />