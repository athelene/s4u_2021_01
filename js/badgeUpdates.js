// Function to find the index in an array of the first entry 
// with a specific value. 
// It is used to get the index of a column in the column list. 
Array.prototype.findIdx = function (value) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] == value) {
      return i;
    }
  }
}

// Used to get counts of new pages, books and tcs

var newPages = function (userID, LastBookView) {
  var notifyUpdates = new Notify();
  var bv = notifyUpdates.getBookView(userID, LastBookView);
  var cir = notifyUpdates.getCircleView(userID);
  notifyUpdates.setCallbackHandler(setBadge(bv, cir));
  notifyUpdates.setErrorHandler(myErrorHandler);
}


// Callback function to update Pages badge from results of 
// the newPages function. 
var setBadge = function (bv, cir) {
  var setBookCount = bv.DATA[0][bv.COLUMNS.findIdx('ITEMCOUNT')];
  var bookSpan = document.getElementById("BookCountSpan");
  var setCirCount = cir.DATA[0][cir.COLUMNS.findIdx('ITEMCOUNT')];
  var cirSpan = document.getElementById("CirCountSpan");
  var invSpan = document.getElementById("newInvitations");

  console.log(setCirCount);

  if (setBookCount > 0) {
    bookSpan.textContent = setBookCount;
    bookSpan.classList.remove("btn-secondary");
    bookSpan.classList.add("btn-deep-orange");
  } else {
    bookSpan.textContent = "";
    bookSpan.classList.remove("btn-deep-orange");
    bookSpan.classList.add("btn-secondary");
  }

  if (setCirCount > 0) {
    cirSpan.textContent = setCirCount;
    cirSpan.classList.remove("btn-secondary");
    cirSpan.classList.add("btn-deep-orange");


  } else {
    cirSpan.textContent = "";
    cirSpan.classList.remove("btn-deep-orange");
    cirSpan.classList.add("btn-secondary");
  }

  if (document.body.contains(invSpan) && setCirCount !== 0) {
    console.log("value is true");
    invSpan.classList.remove("HiddenStoryStarter");
    invSpan.style.visibility = "visible";
  }


}


// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}