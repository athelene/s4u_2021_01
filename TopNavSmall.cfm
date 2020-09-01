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

  <!--Large Navbar -->
    <cfoutput>
  <div id="largeNav">
    <input type="hidden" id="sessionUserid" value="#session.Userid#">
        <nav class="mb-1 navbar sticky-top navbar-light bg-primary">

        <a class="navbar-brand newSaltUser" href="/homepage.cfm">
          <h2><i class="fas fa-home"></i>Stories For Us</h2>
        </a>
        <a class="btn btn-secondary btn-rounded btn-sm " href="/circles/InviteNewMember.cfm">Invite a New Member</a>

        <form class="form-inline my-2 my-lg-0 ml-auto" action="/SearchResults.cfm" name="simpleAJAX"
          enctype="multipart/form-data" method="post">
          <input class="form-control" type="search" placeholder="Search" aria-label="Search" name="searchTerm">
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
            <a class="dropdown-item" href="/Admin/TraditionAdd.cfm">Add Traditions</a>
            <a class="dropdown-item" href="/Admin/QuickConnectQuestionAdd.cfm">Add Quick Connect Questions</a>
          </cfif>
        </div>
      </nav>
  </div>

  <div id="mobileNav">
        <a class="navbar-brand newSaltUser" href="/homepage.cfm">
          <p class="TopNavText"><i class="fas fa-home"></i>Stories For Us</p>
        </a>
  <button class="btn bg-primary hamburgerMenu" type="button" data-toggle="collapse" data-target="##collapseExample" aria-expanded="false" aria-controls="collapseExample">
    <i class="fas fa-bars"></i>
  </button>
<div class="collapse" id="collapseExample">
  <div class="card card-body">
    <a class="dropdown-item" href="/circles/InviteNewMember.cfm">Invite a New Member</a>
    <a class="dropdown-item" href="/users/EditUserProfile.cfm">Edit Your Profile</a>
    <a class="dropdown-item" href="/Users/EditUserPic.cfm">Edit Your Picture</a>
    <a class="dropdown-item" href="/Admin/SubmitQuickConnect.cfm">Submit a Quick Connect question</a>
    <div class="input-group input-group-sm mb-3">
    <form class="form-inline my-2 my-lg-0 " action="/SearchResults.cfm" name="simpleAJAX"
      enctype="multipart/form-data" method="post">
      <input class="form-control" type="search" placeholder="Search" aria-label="Search" name="searchTerm"
        id="searchPlaceholder">
      <button class="btn bg-primary btn-sm my-2 my-sm-0 ml-3" type="submit">Search</button>
    </form>
    </div>
  <cfif #GetUserInfo.AdminLevel# GT 99>
    <a class="dropdown-item" href="/Admin/AddInterviewQuestions.cfm">Add Interview Questions</a>
  </cfif>
  </div>
</div>
  </div>
    </cfoutput>

