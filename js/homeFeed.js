// Use an asynchronous call to bring back all books from the ColdFusion server.
var getHomeFeed = function (userID) {

  // var pageOptions = 'getAllStories(' + userID + ')';
  var aStories = 'on';
  var aInterviews = 'on';
  var aRecipes = 'on';


  // create an instance of the proxy. 
  var ab = new StoryFilter();
  ab.setCallbackHandler(populateHomeFeed);
  ab.setErrorHandler(myErrorHandler);
  ab.getAllStories(userID, aStories, aInterviews, aRecipes);

}

// Populate Home Feed

// JavaScript
var populateHomeFeed = function (rawData) {

  // Read the data from ColdFusion and create the HTML for the feed
  var dataLength = rawData.DATA.length - 1;
  var data = '';
  for (k = 0; k < rawData.DATA.length; k++) {
    console.log('k11 is: ', rawData.DATA[k][11]);
    data = data +
      // Set up title area
      '<div id="titleDiv">' +

      //   Set link to go to the page for this storyid
      '<a href="/Stories/Story.cfm?StoryID=' + rawData.DATA[k][0] + '" ' +
      'class="btn btn-information btn-lg btn-block text-left">' +
      '<h4 class="h4-responsive">'

    //   Add in interviewee if storytype is 2
    if (rawData.DATA[k][4] === 2) {
      data = data +
        'Interview of ' + rawData.DATA[k][6] + ': '
    }

    // Add story title to the title link
    data = data + rawData.DATA[k][1]

    // Is this a tradition?
    if (rawData.DATA[k][4] === 4) {
      data = data + ' Tradition'
    }

    data = data +
      '</h4>' +
      '</a>' +
      '</div>' +

      '<div id="outlineDiv" >' +

      '<div class="row bg-light">'

    //   Create the beginning of the post with data
    data = data +
      '<div id="postTextDiv" class="HomePostDiv bg-light">' +
      '<p class="HomePagePara">'

    //   Include ingredients if a recipe
    if (rawData.DATA[k][4] === 3) {
      data = data +
        '<h4>Ingredients:</h4> <br />' +
        rawData.DATA[k][9] +
        '<br /><H4>Directions: </h4>'
    }

    // Finish post with storytext
    data = data + rawData.DATA[k][2] +
      '</p>' +
      '</div>'

    // Format a standard Page
    //  if (rawData.DATA[k][4] === 1) {

    data = data +
      '<div id="mediaDiv" class="HomeMediaDiv bg-light">'

    if (rawData.DATA[k][11] !== null && rawData.DATA[k][14] === 2) {
      data = data + '<br />' + '<img src="' +
        rawData.DATA[k][11] +
        '" class="rounded s4u-gallery-img img-fluid" alt="...">' +
        '</img>'
    };

    if (rawData.DATA[k][11] !== null && rawData.DATA[k][14] === 1) {
      data = data + '<br />' +
        '<video class="video-Sizer" controls />' +
        '<source src="' +
        rawData.DATA[k][11] +
        '" preload />' +
        'Your browser does not support the video tag.' +
        '</video>'

    };

    data = data +

      '</div>' +

      '</div>' +
      // Author image & info

      '<div class="HomeAuthorDiv bg-light">' +
      '<br />' +
      '<img src="' +
      rawData.DATA[k][10] +
      '" class="rounded-circle z-depth-0 btn-circle-sm"' +
      'alt="avatar image" Title="Created by">' +
      'by ' +
      rawData.DATA[k][8] + ', ' +
      rawData.DATA[k][5] +
      '</div>' +

      '</div>'

    console.log(k);
  }

  var FeedDiv = document.getElementById("scrollArea");
  FeedDiv.innerHTML = data;

}


// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}