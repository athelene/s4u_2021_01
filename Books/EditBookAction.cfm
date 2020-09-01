<!doctype html>
<html lang="en">

<head>

  <title>Stories For Us</title>
</head>

<body>

  <cfoutput>
    <cfif IsDefined("form.TimeCapsuleDate") and IsDefined("form.tcCheckbox")>

      <cfquery name="qEditBook">
        Update BookTbl
        SET BookTitle = <cfqueryparam value="#trim(form.BookTitle)#" cfsqltype="CF_SQL_VARCHAR">,
          TimeCapsuleDate = <cfqueryparam value="#form.TimeCapsuleDate#" cfsqltype="CF_SQL_DATE">
            WHERE BookID = #session.BookID#;
      </cfquery>

      <cfelse>

        <cfquery name="qEditBook">
          Update BookTbl
          SET BookTitle = <cfqueryparam value="#trim(form.BookTitle)#" cfsqltype="CF_SQL_VARCHAR">,
            TimeCapsuleDate = <cfqueryparam value="" cfsqltype="CF_SQL_DATE">
              WHERE BookID = #session.BookID#;
        </cfquery>

    </cfif>

  </cfoutput>

  <cflocation url="/books/bookreader.cfm?bookid=#session.BookID#" />




</body>

</html>