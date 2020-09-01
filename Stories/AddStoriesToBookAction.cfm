<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


  <title>Stories For Us</title>
</head>

<body>
  <cfset Storyarray=ListToArray(#form.Data#) />
  <cfloop from="1" to="#arrayLen(Storyarray)#" index="i">
    <cfset newStoryID=Storyarray[i] />
    <cfquery name="qGetLastSort">
      Select DISTINCT BookID, MAX(sortOrder) + 1 as sortOrder
      from BookContentTbl
      where BookID = #session.BookID#
      group by BookID
    </cfquery>
    <cfif qGetLastSort.recordcount IS 0>
      <cfset newSortOrder=1 />
      <cfelse>
        <cfset newSortOrder=qGetLastSort.sortOrder />
    </cfif>

    <cfquery name="qInsertBookID">
      insert into BookContentTbl
      (BookID, StoryID, SortOrder)
      values (
      <cfqueryparam value=#session.bookID# cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value=#newStoryID# cfsqltype="CF_SQL_INTEGER">,
          <cfqueryparam value=#newSortOrder# cfsqltype="CF_SQL_INTEGER">
            )
    </cfquery>
  </cfloop>

  <cflocation url="/books/BookReader.cfm?bookid=#session.bookid#" />
</body>

</html>