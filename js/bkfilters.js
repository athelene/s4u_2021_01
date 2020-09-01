// Use an asynchronous call to bring back all books from the ColdFusion server.
var getAllBooks = function (userID) {
  var pageOptions = 'getAllBooks(' + userID + ')';

  document.getElementById('showBooks').setAttribute("onClick", pageOptions);
  document.getElementById('showTCs').setAttribute("onClick", pageOptions);

  if (document.getElementById('showBooks').checked) {
    var aBooks = document.getElementById("showBooks").value;
  } else {
    var aBooks = 'off';
  }

  if (document.getElementById('showTCs').checked) {
    var aTCs = document.getElementById("showTCs").value;
  } else {
    var aTCs = 'off';
  }

  // create an instance of the proxy. 
  var ab = new BookFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getAllBooks(userID, aBooks, aTCs);
}

// Use an asynchronous call to filter only my books from the ColdFusion server.
var getMyBooks = function (userID) {

  var pageOptions = 'getMyBooks(' + userID + ')';

  document.getElementById('showBooks').setAttribute("onClick", pageOptions);
  document.getElementById('showTCs').setAttribute("onClick", pageOptions);

  if (document.getElementById('showBooks').checked) {
    var aBooks = document.getElementById("showBooks").value;
  } else {
    var aBooks = 'off';
  }

  if (document.getElementById('showTCs').checked) {
    var aTCs = document.getElementById("showTCs").value;
  } else {
    var aTCs = 'off';
  }

  // create an instance of the proxy. 
  var ab = new BookFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyBooks(userID, aBooks, aTCs);
}

var getOtherBooks = function (userID) {

  var pageOptions = 'getOtherBooks(' + userID + ')';

  document.getElementById('showBooks').setAttribute("onClick", pageOptions);
  document.getElementById('showTCs').setAttribute("onClick", pageOptions);

  if (document.getElementById('showBooks').checked) {
    var aBooks = document.getElementById("showBooks").value;
  } else {
    var aBooks = 'off';
  }

  if (document.getElementById('showTCs').checked) {
    var aTCs = document.getElementById("showTCs").value;
  } else {
    var aTCs = 'off';
  }
  // create an instance of the proxy. 
  var ab = new BookFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getOtherBooks(userID, aBooks, aTCs);
}

// TIMECAPSULE FILTERS

// Use an asynchronous call to bring back all books from the ColdFusion server.
var getAllTCs = function () {
  // create an instance of the proxy. 
  var ab = new TCFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getAllTCs();
}

// Use an asynchronous call to filter only my books from the ColdFusion server.
var getMyTCs = function () {
  // create an instance of the proxy. 
  var ab = new TCFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyTCs();
}

var getOtherTCs = function () {
  // create an instance of the proxy. 
  var ab = new TCFilter();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.getOtherTCs();
}

// CALLBACK FUNTION 
var populateBookList = function (bkList) {
  var BookDiv = document.getElementById("BookDiv");
  if (bkList === "No books found.") {
    BookDiv.innerHTML = "No books or time capsules found."
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
        '<div class="list-group QCText">' +
        '<a href="/Books/BookReader.cfm?BookID=' + bkID + '"' +
        ' class="list-group-item list-group-item-action">'
      if (bkTCDate != null) {
        itemCode = itemCode + '<i class="fa fa-hourglass-start fa-lg" aria-hidden="true"></i> ';
      }
      itemCode = itemCode +
        bkTitle + ', ' + bkCreateDate +
        '</a>' +
        '</div>'
      console.log(itemCode);
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