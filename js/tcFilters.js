// Use an asynchronous call to bring back all books from the ColdFusion server.
var getAllBooks = function () {
  // create an instance of the proxy. 
  var ab = new BookFilter();
  // Setting a callback handler for the proxy automatically makes 
  // the proxy's calls asynchronous. 
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  // The proxy getCircle function represents the CFC 
  // getCircle function. 
  ab.getAllBooks();
}

// Use an asynchronous call to filter only my books from the ColdFusion server.
var getMyBooks = function () {
  // create an instance of the proxy. 
  var ab = new BookFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyBooks();

}

var getOtherBooks = function () {

  var ab = new BookFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getOtherBooks();

}

// TIMECAPSULE FILTERS

// Use an asynchronous call to bring back all books from the ColdFusion server.
var getAllTCs = function () {
  var ab = new TCFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getAllTCs();

}

// Use an asynchronous call to filter only my books from the ColdFusion server.
var getMyTCs = function () {
  var ab = new TCFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyTCs();

}

var getOtherTCs = function () {
  var ab = new TCFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getOtherTCs();

}

// CALLBACK FUNTION 
var populateBookList = function (bkList) {
  var BookDiv = document.getElementById("BookDiv");
  if (bkList === "You haven't created any yet.") {

    BookDiv.innerHTML = "You haven't created any yet.";
    return;
  } else {
    var itemCode = '';
    for (k = 0; k < bkList.DATA.length; k++) {
      var bkID = bkList.DATA[k][0];
      var bkTitle = bkList.DATA[k][1];
      var bkOwner = bkList.DATA[k][2];
      var bkTCDate = bkList.DATA[k][3];
      var bkCreateDate = bkList.DATA[k][4];
      var bkContentType = bkList.DATA[k][5];
      var bkCircleID = bkList.DATA[k][6];
      var bkUserDisplayName = bkList.DATA[k][7];

      itemCode = itemCode +
        '<div class="list-group QCText ">' +
        '<a href="/Books/BookReader.cfm?BookID=' + bkID + '"' +
        ' class="list-group-item list-group-item-action">' +
        bkTitle + ', ' + bkCreateDate +
        '</a>' + '</div>'
    }
    BookDiv.innerHTML = itemCode
    return;

  }
}

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}