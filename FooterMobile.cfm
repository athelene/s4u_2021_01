<!-- Footer --> 
<nav class="navbar fixed-bottom navbar-primary footer">

  <!-- Footer Links -->
  <div class="w-100 footer-s4u">

    <!-- Links -->
    <div class="btn-group dropup">
      <button type="button" class="btn"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Create
      </button>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="/Stories/StoryStarter.cfm" title="Create a new page">New Page</a>
        <a class="dropdown-item pb-0" href="/Books/NewTimeCapsule.cfm" title="Create a new book or Time Capsule">New
          Book/Time Capsule</a>
      </div>
    </div>

    <button type="button" class="btn"
      onclick="window.location.href='/Library_Books.cfm'" title="See all books">
      Stories
      <span id="BookCountSpan" class="badge badge-secondary badge-pill mx-2"></span>
    </button>

    <button type="button" class="btn home-button"
      onclick="window.location.href='/HomePage.cfm'" title="See all books">
      <i class="fas fa-book-open fa-lg"></i>
    </button>


    <button type="button" class="btn"
      onclick="window.location.href='/circles/circles.cfm'" title="Manage your circles">
      Circles
      <span id="CirCountSpan" class="badge badge-deep-orange mx-2"></span>
    </button>

    <button type="button" class="btn font-italic"
      onclick="window.location.href='/Library_qc.cfm'" title="See all Quick Connect questions">
      <span class="font-weight-normal">Quick</span>Connect
      <span id="CirCountSpan" class="badge badge-deep-orange mx-2"></span>
    </button>



  </div>
  <!-- Footer Links -->

</nav>
<!-- Footer -->