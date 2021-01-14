<!-- Footer --> 
<nav class="navbar fixed-bottom navbar-primary footer">

  <!-- Footer Links -->
  <div class="w-100 footer-s4u">

    <!-- Links -->
    <div class="btn-group dropup">
      <button type="button" class="btn dropdown-toggle"
      data-toggle="collapse" data-target="#dropdownMenu">
        Create
      </button>
      <div class="dropdown-menu text-uppercase" id="dropdownMenu">
        <a class="dropdown-item font-weight-bold pt-2" href="/Stories/StoryStarter.cfm" title="Create a new page">Memory</a>
        <a class="dropdown-item small ml-3" href="/Stories/InterviewStoryStarter.cfm" title="Create a new page">Interview</a>
        <a class="dropdown-item small ml-3" href="/Stories/RecipeStoryStarter.cfm" title="Create a new page">Recipe</a>
        <a class="dropdown-item small ml-3" href="/Stories/TraditionStoryStarter.cfm" title="Create a new page">Tradition</a>
        <hr class="my-2">
        <a class="dropdown-item font-weight-bold pb-0" href="/Books/NewTimeCapsule.cfm" title="Create a new book or Time Capsule">Story</a>
      </div>
    </div>

    <button type="button" class="btn"
      onclick="window.location.href='/Library_Books.cfm'" title="See all Stories">
      Storybooks
      <span id="BookCountSpan" class="badge badge-secondary badge-pill mx-2"></span>
    </button>

    <button type="button" class="btn home-button"
      onclick="window.location.href='/HomePage.cfm'" title="See all memories">
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