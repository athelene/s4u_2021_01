// Use an asynchronous call to bring back all story media from the ColdFusion server.
var findUserImg = function (userID) {
  // create an instance of the proxy. 
  console.log('starting userImg js function')
  var ab = new userImg();
  ab.setCallbackHandler(populateUserImgDiv);
  ab.setErrorHandler(myErrorHandler);
  ab.editUserImg(userID);
}

// CALLBACK FUNTION TO FILL IN THE userImgDiV
var populateUserImgDiv = function (userMediaLoc) {
  console.log('starting populateUserImgDiv');
  var userImgDiv = document.getElementById("userImgDiv");
  var userID = 1;
  var itemCode = '';
  var mediaID = userMediaLoc.DATA[0][0];
  if (mediaID !== null) {
    itemCode =
      '<label class="btn btn-sm waves-effect waves-light" title="Edit Picture">' +
      '<img src="' + mediaID + '" class="rounded-circle img-fluid s4u-gallery-img"' +
      'alt="avatar image" Title="Edit Picture"> <BR />' +
      '<i class="far fa-edit icon-align-center"></i>' +
      '<input id="userImgInput" type="file" style="display: none;" name="fileI" accept="image/*"' +
      'capture="capture" value="Save Images" multiple="multiple" id="fileI" onchange="submitNewImg()">' +
      '</label>'
  } else {
    itemCode =
      '<label class="btn btn-secondary" title="Add a Picture">' +
      '<i class="fas fa-camera"></i>' +
      '<input id="userImgInput" type="file" style="display: none;" name="fileI" accept="image/*"' +
      'capture="capture" value="Save Images" multiple="multiple" id="fileI" onchange="submitNewImg()">' +
      '</label>'
  }
  userImgDiv.innerHTML = itemCode;
  return;
}

// Submit the form to update the picture.
var lightUpUpdateProfileBtn = function () {
  document.getElementById("updateProfileBtn").style.display = 'block';

}

// Hide the Update button on user profile edit.
var hideUpdateProfileBtn = function () {
  document.getElementById("updateProfileBtn").style.display = 'none';

}

// Submit the form to update the picture.
var submitNewImg = function () {
  document.userPicForm.submit();

}

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}