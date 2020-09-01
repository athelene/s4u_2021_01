<!doctype html>
<html lang="en">

<head>

  <title>Stories For Us</title>
</head>

<body>
  <cfset getNow=now() />

  <cfoutput>
    <cfif IsDefined("form.TimeCapsuleDate")>

      <cfquery name="qAddBook" result="qBookID">
        Insert into BookTbl
        (BookTitle, BookOwner, TimeCapsuleDate, BookCreateDate, CircleID, ContentType)
        values
        (<cfqueryparam value="#form.BookTitle#" cfsqltype="CF_SQL_VARCHAR">,
          <cfqueryparam value="#Session.Userid#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#form.TimeCapsuleDate#" cfsqltype="CF_SQL_DATE">,
              <cfqueryparam value="#getNow#" cfsqltype="CF_SQL_TIMESTAMP">,
                <cfqueryparam value="#form.CircleID#" cfsqltype="CF_SQL_INTEGER">,
                  <cfqueryparam value="#form.ContentType#" cfsqltype="CF_SQL_INTEGER">)
      </cfquery>

      <cfelse>

        <cfquery name="qAddBook" result="qBookID">
          Insert into BookTbl
          (BookTitle, BookOwner, BookCreateDate, CircleID, ContentType)
          Values
          (<cfqueryparam value="#form.BookTitle#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#Session.Userid#" cfsqltype="CF_SQL_INTEGER">,
              <cfqueryparam value="#GetNow#" cfsqltype="CF_SQL_TIMESTAMP">,
                <cfqueryparam value="#form.CircleID#" cfsqltype="CF_SQL_INTEGER">,
                  <cfqueryparam value="#form.ContentType#" cfsqltype="CF_SQL_INTEGER">)
        </cfquery>

    </cfif>

  </cfoutput>


  <!--- Create New StoryID --->
  <cfset session.BookID=qBookID.generatedkey />

  <cfquery name="qGetTmpExclude">
    Select * from TMPExcludeTbl
    Where UserID = #session.Userid#
  </cfquery>

  <cfloop query="qGetTmpExclude">
    <cfquery name="qInsertExcludes">
      Insert into BkExcludeTbl
      (ExcludeUser, BookID)
      VALUES
      (#qGetTmpExclude.ExcludeUser#, #qBookID.generatedkey#)
    </cfquery>
  </cfloop>

  <cfquery name="qClearTmpExclude">
    Delete from TMPExcludeTbl
    where UserID = #session.userid#
  </cfquery>


  <cflocation url="/books/BookReader.cfm?bookid=#qBookID.generatedkey#" />
</body>

</html>