// Use an asynchronous call to bring back all story media from the ColdFusion server.
var newMedia = function () {
  console.log('starting newMedia')
  let userID = localStorage.getItem('userID')
  // create an instance of the proxy. 
  var ab = new FeatureImg();
  ab.setCallbackHandler(populatePageDiv);
  ab.setErrorHandler(myErrorHandler);
  ab.newMedia(userID);

}

// CALLBACK FUNTION TO FILL IN THE pageDiV
var populatePageDiv = function (mediaList) {

  console.log('starting populatePageDiv');
  var pageDiv = document.getElementById("pageDiv");
  var itemCode = '';
  for (k = 0; k < mediaList.DATA.length; k++) {
    var mediaID = mediaList.DATA[k][0];
    var mediaLoc = mediaList.DATA[k][1];
    var mediaType = mediaList.DATA[k][2];
    var featureMedia = mediaList.DATA[k][3];
    var storyID = 0;

    if (mediaType === 1) {
      itemCode = itemCode +
        '<div class="featureMediaContainer">' +
        '<figure class="col-md-4 "' +
        'onclick="setMedia(' +
        mediaID + ', ' + storyID + ', ' + window.UserID + ')">' +
        '<video width="320" height="240">' +
        '<source src="' +
        mediaLoc +
        '"</cfoutput> preload>' +
        'Your browser does not support the video tag.' +
        '</video>' +
        '</figure>'
      console.log('featureMedia is: ', featureMedia);
      if (featureMedia === 1) {
        itemCode = itemCode +
          '<p>Featured</p>'
      }
      itemCode = itemCode +
        '<button onclick="deleteMedia(' +
        mediaID +
        ')" class="btn btn-sm">' +
        '<i class="fas fa-trash fa-lg"></i></button>'
      itemCode = itemCode +
        '</div>'

    } else if (mediaType === 2) {
      itemCode = itemCode +
        '<div class="featureMediaContainer"' +
        'onclick="setMedia(' +
        mediaID + ', ' + storyID + ', ' + window.UserID + ')">' +
        '<img src=' +
        mediaLoc +
//        ' class="img-fluid z-depth-1" height="240" width="240" ><BR>'
      'class="s4uGallery" onclick="window.open(this.src)"><BR>'
      if (featureMedia === 1) {
        itemCode = itemCode +
          '><p>Featured</p>'
      }

      itemCode = itemCode +
        '<button onclick="deleteMedia(' +
        mediaID +
        ')" class="btn btn-sm">' +
        '<i class="fas fa-trash fa-lg"></i></button>'

      itemCode = itemCode +
        '</div>'
      console.log(itemCode, storyID);
    }
  }
  pageDiv.innerHTML = itemCode;
  return;
}

// Use an asynchronous call to set feature media for a story on the ColdFusion server.
var setMedia = function (mediaID, storyID, userID) {
  console.log('starting setMedia');
  window.gStoryID = 0;
  window.gUserID = userID;
  // create an instance of the proxy. 
  var ab = new FeatureImg();
  ab.setCallbackHandler(setMediaHandler);
  ab.setErrorHandler(myErrorHandler);
  ab.setMedia(mediaID, storyID, userID);
}

var setMediaHandler = function (setMediaResult) {
  updateMedia(gUserID);
}

// Use an asynchronous call to bring back all story media from the ColdFusion server.
var updateMedia = function () {
  console.log('starting updateMedia');
  var userID = localStorage.getItem("userID")
  // create an instance of the proxy. 
  var ab = new FeatureImg();
  ab.setCallbackHandler(updateMediaList);
  ab.setErrorHandler(myErrorHandler);
  ab.newMedia(userID);
}

// CALLBACK FUNTION 
var updateMediaList = function (mediaList) {
  console.log('starting updateMediaList');
  var modalDiv = document.getElementById("modalDiv");
  var pageDiv = document.getElementById("pageDiv");
  console.log(mediaList.DATA.length);
  if (mediaList.DATA.length < 2) {
    var featureBtn = document.getElementById("featureBtn");
    featureBtn.style.display = 'block';  
  }
  // itemCode will update the mediaDiv
  var itemCode = '';
  for (k = 0; k < mediaList.DATA.length; k++) {
    var mediaID = mediaList.DATA[k][0];
    var mediaLoc = mediaList.DATA[k][1];
    var mediaType = mediaList.DATA[k][2];
    var featureMedia = mediaList.DATA[k][3];
    var mediaUser = mediaList.DATA[k][4];
    var storyID = 0;



    if (mediaType === 2) {

      if (window.UserID === mediaUser && featureMedia === 1) {
        itemCode = itemCode +
          '<p>Featured</p>'
      }

      itemCode = itemCode +
        '<div class="col" id="clickHereDiv "'

      if (window.UserID === mediaUser) {
        itemCode = itemCode +
          'onclick="setMedia(' +
          mediaID + ', ' + storyID + ', ' + window.UserID + ')"'
      }

      itemCode = itemCode +
        '>'

      itemCode = itemCode +
        '<img src="' +
        mediaLoc +
        '" class="img-fluid z-depth-1" height="150em" width="150em">' +
        '<BR>'

      itemCode = itemCode +
        '</div>'
    } else if (mediaType === 1) {
      itemCode = itemCode +
        '<div class="col" id="clickHereDiv "'
      if (window.UserID === mediaUser) {
        itemCode = itemCode +
          'onclick="setMedia(' +
          mediaID + ', ' + storyID + ', ' + window.UserID + ')"'
      }
      itemCode = itemCode +
        '>'

      if (window.UserID === mediaUser && featureMedia === 1) {
        itemCode = itemCode +
          '<p>Featured</p>'
      }

      itemCode = itemCode +
        '<div class="embed-responsive embed-responsive-4by3">' +
        '<video>' +
        '<source src="' +
        mediaLoc +
        '" preload>' +
        'Your browser does not support the video tag.' +
        '</video>' +
        '</div>' +
        '</div>'
      $('.close').click();
    }

  }

  modalDiv.innerHTML = itemCode;

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
        '<div class="col" id="clickHereDiv "'
      itemCode2 = itemCode2 +
        '>' +
        '<a href="' + mediaLoc + '" target="blank">' +
        '<img src="' +
        mediaLoc +
        '" class="img-fluid z-depth-1" height="150em" width="150em" >' +
        '</a>' +
        '<BR>'

      if (featureMedia === 1) {
        itemCode2 = itemCode2 +
          '<p>Featured</p>'
      }

      itemCode2 = itemCode2 +
        '<button onclick="deleteMedia(' +
        mediaID +
        ')" class="btn">' +
        '<i class="fas fa-trash fa-lg"></i></button>'

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
      if (featureMedia === 1) {
        itemCode2 = itemCode2 +
          '<p>Featured</p>'
      }

      itemCode2 = itemCode2 +
      '<button onclick="deleteMedia(' +
      mediaID +
      ')" class="btn">' +
      '<i class="fas fa-trash fa-lg"></i></button>'


      itemCode2 = itemCode2 +
        '</div>'
    }

  }
  console.log('updating the modalDiv');
  modalDiv.innterHTML = itemCode;

  console.log('updating the pageDiv');
  pageDiv.innerHTML = itemCode2;

  $('#cancel-btn').click();

  return;
}

// Use an asynchronous call to bring back all story media from the ColdFusion server.
var deleteMedia = function (mediaID) {
  console.log('starting deleteMedia');

  // create an instance of the proxy. 
  var ab = new FeatureImg();
  ab.setCallbackHandler(newMedia);
  ab.setErrorHandler(myErrorHandler);
  ab.deleteMedia(mediaID);

}

var postDeleteMediaList = function () {
  console.log('starting postDeleteMediaList');
  newMedia();


}

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}