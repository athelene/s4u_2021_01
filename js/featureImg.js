// Use an asynchronous call to bring back all story media from the ColdFusion server.
var featureMedia = function (storyID) {
  console.log('starting featureMedia')
  window.gStoryID = storyID;
  // create an instance of the proxy. 
  var ab = new FeatureImg();
  ab.setCallbackHandler(updateMediaList);
  ab.setErrorHandler(myErrorHandler);
  ab.featureMedia(storyID);
}

// CALLBACK FUNTION 
var updateMediaList = function (mediaList) {
  var modalDiv = document.getElementById("modalDiv");
  var pageDiv = document.getElementById("pageDiv");

  // itemCode will update the mediaDiv
  var itemCode = '';
  for (k = 0; k < mediaList.DATA.length; k++) {
    var mediaID = mediaList.DATA[k][0];
    var mediaLoc = mediaList.DATA[k][1];
    var mediaType = mediaList.DATA[k][2];
    var featureMedia = mediaList.DATA[k][3];
    var mediaUser = mediaList.DATA[k][4];

    
    // itemCode2 will update the pageDiv

    var itemCode2 = '';
    for (k = 0; k < mediaList.DATA.length; k++) {
      var mediaID = mediaList.DATA[k][0];
      var mediaLoc = mediaList.DATA[k][1];
      var mediaType = mediaList.DATA[k][2];
      var featureMedia = mediaList.DATA[k][3];
      var mediaUser = mediaList.DATA[k][4];

      if (mediaType === 2) {
        itemCode2 = itemCode2 +
          '<div class="col s4u-gallery-div" id="clickHereDiv"'
        itemCode2 = itemCode2 +
          '>' +
          '<a href="' + mediaLoc + '" target="blank">' +
          '<img src="' +
          mediaLoc +
          '" class="s4u-gallery-img z-depth-1" height="150em" width="150em" >' +
          '</a>' +
          '<BR>'

        itemCode2 = itemCode2 +
          '</div>'
      } else if (mediaType === 1) {
        itemCode2 = itemCode2 +
          '<div class="col" id="clickHereDiv "'
        itemCode2 = itemCode2 +
          '>' +
          '<div class="embed-responsive embed-responsive-4by3">' +
          '<video controls>' +
          '<source src="' +
          mediaLoc +
          '" preload>' +
          'Your browser does not support the video tag.' +
          '</video>' +
          '</div>'

        itemCode2 = itemCode2 +
          '</div>'
      }

    }

    console.log('updating the pageDiv');
    pageDiv.innerHTML = itemCode2;

  }
  return;
}

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}