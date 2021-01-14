// Use an asynchronous call to bring back all books from the ColdFusion server.
var getAllStories = function () {
  var userID = localStorage.getItem("userID");
  console.log('getAllStories userID is: ', userID)
  var pageOptions = 'getAllStories(' + userID + ')';

  document.getElementById('showStories').setAttribute("onClick", pageOptions);
  document.getElementById('showInterviews').setAttribute("onClick", pageOptions);
  document.getElementById('showRecipes').setAttribute("onClick", pageOptions);
  document.getElementById('showTraditions').setAttribute("onClick", pageOptions);

  if (document.getElementById('showStories').checked) {
    var aStories = document.getElementById("showStories").value;
  } else {
    var aStories = 'off';
  }
  if (document.getElementById('showInterviews').checked) {
    var aInterviews = document.getElementById("showInterviews").value;
  } else {
    var aInterviews = 'off';
  }
  if (document.getElementById('showRecipes').checked) {
    var aRecipes = document.getElementById("showRecipes").value;
  } else {
    var aRecipes = 'off';
  }
  if (document.getElementById('showTraditions').checked) {
    var aTraditions = document.getElementById("showTraditions").value;
  } else {
    var aTraditions = 'off';
  }
  var primaryCircle = localStorage.getItem("primaryCircle");
  var aPrimaryCircle = Number(primaryCircle);
  // create an instance of the proxy. 
  var ab = new StoryFilter();
  ab.setCallbackHandler(populateHomeFeed);
  ab.setErrorHandler(myErrorHandler);
  ab.getAllStories(userID, aPrimaryCircle, aStories, aInterviews, aRecipes, aTraditions);

}


// Use an asynchronous call to filter only my books from the ColdFusion server.
var getMyStories = function (userID) {
  var pageOptions = 'getMyStories(' + userID + ')';

  document.getElementById('showStories').setAttribute("onClick", pageOptions);
  document.getElementById('showInterviews').setAttribute("onClick", pageOptions);
  document.getElementById('showRecipes').setAttribute("onClick", pageOptions);
  document.getElementById('showTraditions').setAttribute("onClick", pageOptions);
  if (document.getElementById('showStories').checked) {
    var aStories = document.getElementById("showStories").value;
  } else {
    var aStories = 'off';
  }
  if (document.getElementById('showInterviews').checked) {
    var aInterviews = document.getElementById("showInterviews").value;
  } else {
    var aInterviews = 'off';
  }
  if (document.getElementById('showRecipes').checked) {
    var aRecipes = document.getElementById("showRecipes").value;
  } else {
    var aRecipes = 'off';
  }
  if (document.getElementById('showTraditions').checked) {
    var aTraditions = document.getElementById("showTraditions").value;
  } else {
    var aTraditions = 'off';
  }
  var primaryCircle = localStorage.getItem("primaryCircle");
  var aPrimaryCircle = Number(primaryCircle);
  // create an instance of the proxy. 
  var ab = new StoryFilter();
  ab.setCallbackHandler(populateHomeFeed);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyStories(userID, aPrimaryCircle, aStories, aInterviews, aRecipes, aTraditions);

}

var getOtherStories = function (userID) {
  var pageOptions = 'getOtherStories(' + userID + ')';

  document.getElementById('showStories').setAttribute("onClick", pageOptions);
  document.getElementById('showInterviews').setAttribute("onClick", pageOptions);
  document.getElementById('showRecipes').setAttribute("onClick", pageOptions);
  document.getElementById('showTraditions').setAttribute("onClick", pageOptions);

  if (document.getElementById('showStories').checked) {
    var aStories = document.getElementById("showStories").value;
  } else {
    var aStories = 'off';
  }
  if (document.getElementById('showInterviews').checked) {
    var aInterviews = document.getElementById("showInterviews").value;
  } else {
    var aInterviews = 'off';
  }
  if (document.getElementById('showRecipes').checked) {
    var aRecipes = document.getElementById("showRecipes").value;
  } else {
    var aRecipes = 'off';
  }
  if (document.getElementById('showTraditions').checked) {
    var aTraditions = document.getElementById("showTraditions").value;
  } else {
    var aTraditions = 'off';
  }

  var primaryCircle = localStorage.getItem("primaryCircle");
  var aPrimaryCircle = Number(primaryCircle);

  // create an instance of the proxy. 
  var ab = new StoryFilter();
  ab.setCallbackHandler(populateHomeFeed);
  ab.setErrorHandler(myErrorHandler);
  ab.getOtherStories(userID, aPrimaryCircle, aStories, aInterviews, aRecipes, aTraditions);

}

// CALLBACK FUNTION 
var populateStoryList = function (stList) {
  var StoryDiv = document.getElementById("StoryDiv");
  if (stList === "No pages fit your selection.") {
    console.log('populateStoryList(stList) says: ', stList);
    StoryDiv.innerHTML = "No pages fit your selection."
    console.log('storyDiv.innerHTML says: ', StoryDiv.innerHTML);
    return;
  } else {
    var itemCode = '';
    for (k = 0; k < stList.DATA.length; k++) {
      var stID = stList.DATA[k][0];
      var stTitle = stList.DATA[k][1];
      var stStoryText = stList.DATA[k][2];
      var stUserID = stList.DATA[k][3];
      var stStoryTypeID = stList.DATA[k][4];
      var stStoryDate = stList.DATA[k][5];
      var stInterviewee = stList.DATA[k][6];
      var stCircleID = stList.DATA[k][7];
      var stUserDisplayName = stList.DATA[k][8];
      var stMediaLoc = stList.DATA[k][11];

      if (stStoryTypeID === 2) {
        var stTitleIntervieweeText = stTitle + ' - Interview of ' + stInterviewee
      } else if (stStoryTypeID === 4) {
        var stTitleIntervieweeText = stTitle + ' Tradition'
      } else {
        var stTitleIntervieweeText = stTitle + ' '
      }

      itemCode = itemCode +
        '<div class="list-group QCText ">' +
        '<a href="/Stories/Story.cfm?StoryID=' + stID + '"' +
        ' class="list-group-item list-group-item-action">' +
        stTitleIntervieweeText + ' - ' +
        ' by ' + stUserDisplayName + ' on ' +
        stStoryDate +
        '</a>' + '</div>'
    }
  }
  StoryDiv.innerHTML = itemCode
  return;

}

var populateHomeFeed = function (rawData) {
  var StoryDiv = document.getElementById("StoryDiv");
  console.log('running populateHomeFeed in storyFilters');
  // Read the data from ColdFusion and create the HTML for the feed
  if (rawData === "No pages fit your selection.") {
    console.log('populateStoryList(rawData) says: ', rawData);
    StoryDiv.innerHTML = "No pages fit your selection."
    console.log('storyDiv.innerHTML says: ', StoryDiv.innerHTML);
    return;
  }
  var dataLength = rawData.DATA.length - 1;
  var data = '';
  for (k = 0; k < rawData.DATA.length; k++) {
    console.log('k11 is: ', rawData.DATA[k][11]);
    data = data +

      // Main Story Wrapper
      '<div class="story col-12 col-md-6 col-lg-4 col-xl-3 card-group">' +

      // Card
      '<div class="card">' +

      // Set up title area
      '<div id="titleDiv" class="card-body pb-2">' +

      //   Set link to go to the page for this storyid
      '<a href="/Stories/Story.cfm?StoryID=' + rawData.DATA[k][0] + '" ' +
      'class="text-text-primary">' +
      '<h5>'

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
      '</h5>' +
      '</a>' +
      '</div>' +

      '<div id="outlineDiv">' +

      '<div class="s4u-div-inline">';

    // Format a standard Page
    //  if (rawData.DATA[k][4] === 1) {

    data = data +
    '<a href="/Stories/Story.cfm?StoryID=' + rawData.DATA[k][0] + '" ' +
    '<div id="mediaDiv" class="HomeMediaDiv">';

    if (rawData.DATA[k][11] !== null && rawData.DATA[k][14] === 2) {
      data = data + 

      '<img src="' +
        rawData.DATA[k][11] +
        '" class="img-responsive w-100 img-fluid" style="max-height: 15rem;" alt="...">' +
        '</img>' + 
        '</div>' 
    };

    if (rawData.DATA[k][11] !== null && rawData.DATA[k][14] === 1) {
      data = data + '<br />' +
        '<video class="video-Sizer" controls />' +
        '<source src="' +
        rawData.DATA[k][11] +
        '" preload />' +
        'Your browser does not support the video tag.' +
        '</video>' + 
        '</div>' + '</a>' 
    };

    //   Create the beginning of the post with data
    data = data +
      '<div id="postTextDiv" class="card-body pb-0 postText">' +
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


    data = data +

      '</div>' +
      // Author image & info

      '<hr />' +

      '<div class="card-body pt-0">' +
      '<img src="' +
      rawData.DATA[k][10] +
      '" class="rounded-circle z-depth-0 btn-circle-sm mr-2"' +
      'alt="avatar image" style="max-width: 2.5rem; max-height: 2.5rem"  Title="Created by">' +
      'by ' +
      rawData.DATA[k][8] + '<br> ' +
      rawData.DATA[k][5] +
      '</div>' +
      '</div>' +
      '</div>' +
      '</div>' +
      '</div>'

    console.log(k);
  }

  var FeedDiv = document.getElementById("StoryDiv");
  StoryDiv.innerHTML = data;

}


// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}