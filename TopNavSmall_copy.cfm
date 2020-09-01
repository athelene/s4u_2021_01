<cfif session.userid IS 0>
  <cflocation url="index.cfm" />
</cfif>
<cfquery name="qGetAdminLevel">
  Select AdminLevel
  from UserTbl
  where #session.UserID# = UserID
</cfquery>
<cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

<!--Navbar -->
<cfquery name="GetUserInfo">
  Select * from UserTbl
  where userid = #session.userid#
</cfquery>

<cfquery name="qGetInvitations">
  Select * from CircleMemberTbl
  where MemberID = #session.userid#
  AND status = 'Invited'
</cfquery>

<cfquery name=qGetLastViews>
  Select LastPageView, LastBookView, LastFeedView, LastTCView
  from UserTbl
  where userid = #session.userid#
</cfquery>
<cfset session.LastPageView=qGetLastViews.LastPageView />
<cfset session.LastBookView=qGetLastViews.LastBookView />
<cfset session.LastTCView=qGetLastViews.LastTCView />
<cfset session.LastFeedView=qGetLastViews.LastFeedView />


<cfif session.userid IS 0>
  <cflocation url="index.cfm" />
</cfif>
<cfquery name="qGetAdminLevel">
  Select AdminLevel
  from UserTbl
  where #session.UserID# = UserID
</cfquery>
<cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

<body class="fixed-sn mdb-skin">
  <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
  <!--Navbar -->

  <body>
    <cfoutput>
      <!--Navbar -->

      <nav class="sticky-top bg-primary" id="largeNav">

        <a class="navbar-brand newSaltUser" href="/homepage.cfm">
          <h2><i class="fas fa-home"></i>Stories For Us</h2>
        </a>
        <a class="btn btn-secondary btn-rounded" href="/circles/InviteNewMember.cfm">Invite a New Member</a>

        <form class="form-inline my-2 my-lg-0 ml-auto" action="/SearchResults.cfm" name="simpleAJAX"
          enctype="multipart/form-data" method="post">
          <input class="form-control" type="search" placeholder="Search" aria-label="Search" name="searchTerm"
            id="searchPlaceholder">
          <button class="btn btn-outline-white btn-md my-2 my-sm-0 ml-3" type="submit">Search</button>
        </form>

        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown" aria-haspopup="true"
          aria-expanded="false">
          <img src="#GetUserInfo.UserMediaLoc#" class="rounded-circle z-depth-0" alt="avatar image" height="40">
        </a>
        <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="navbarDropdownMenuLink-333">
          <a class="dropdown-item" href="/users/EditUserProfile.cfm">Edit Your Profile</a>
          <a class="dropdown-item" href="/Users/EditUserPic.cfm">Edit Your Picture</a>
          <a class="dropdown-item" href="/Admin/SubmitQuickConnect.cfm">Submit a Quick Connect question suggestion</a>
          <cfif #GetUserInfo.AdminLevel# GT 99>
            <a class="dropdown-item" href="/Admin/AddInterviewQuestions.cfm">Add Interview Questions</a>
          </cfif>
        </div>
      </nav>
      <!--/.Large Navbar -->

<!---       Mobile Navbar --->


    </cfoutput>