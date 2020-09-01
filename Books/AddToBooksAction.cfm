<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


  <title>Stories For Us</title>
</head>

<body>
  <cfset bookarray=ListToArray(#form.Data#) />

  <cfloop from="1" to="#arrayLen(bookarray)#" index="i">
    <cfset newbookID=bookarray[i] />
    <cfquery name="qGetLastSort">
      Select DISTINCT BookID, MAX(sortOrder) + 1 as sortOrder
      from BookContentTbl
      where BookID = #newBookID#
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
      <cfqueryparam value=#newbookID# cfsqltype="CF_SQL_INTEGER">,
        <cfqueryparam value=#session.StoryID# cfsqltype="CF_SQL_INTEGER">,
          <cfqueryparam value=#newSortOrder# cfsqltype="CF_SQL_INTEGER">
            )
    </cfquery>
  </cfloop>

  <cflocation url="/stories/story.cfm?storyID=#session.storyID#" />

</html>