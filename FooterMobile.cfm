<!-- Footer -->
<nav class="navbar fixed-bottom navbar-primary footer-s4u bg-primary">

  <!-- Footer Links -->
  <Div class="text-center footer-s4u">


    <button type="button" class="btn btn-secondary btn-responsive spanSpacer btn-responsive circleBtn"
      onclick="window.location.href='/Library_Books.cfm'" title="See all books">
      <i class="fas fa-book-open fa-lg"></i>
      <span id="BookCountSpan" class="badge badge-deep-orange ml-2"></span></button>
    <!-- Links -->
    <div class="btn-group dropup">
      <button type="button" class="btn btn-secondary btn-responsive dropdown-toggle px-3 circleBtn"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-plus icon-align-center"></i>
      </button>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="/Stories/StoryStarter.cfm" title="Create a new page">New Page</a>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="/Books/NewTimeCapsule.cfm" title="Create a new book or Time Capsule">New
          Book/Time Capsule</a>
      </div>
    </div>


    <!--- More Links --->

    <button type="button" class="btn btn-secondary btn-responsive spanSpacer circleBtn btn-responsive"
      onclick="window.location.href='/Library_qc.cfm'" title="See all Quick Connect questions">
      QC<i class="fas fa-question"></i></i>
      <span id="CirCountSpan" class="badge badge-deep-orange ml-2"></span>
    </button>

    <button type="button" class="btn btn-secondary btn-responsive spanSpacer circleBtn btn-responsive"
      onclick="window.location.href='/circles/circles.cfm'" title="Manage your circles">
      <i class="fa fa-user-circle fa-lg" aria-hidden="true"></i>
      <span id="CirCountSpan" class="badge badge-deep-orange ml-2"></span>
    </button>

  </div>
  <!-- Footer Links -->

</nav>
<!-- Footer -->