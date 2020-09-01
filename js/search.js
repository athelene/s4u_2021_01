// Use an asynchronous call to bring back all books from the ColdFusion server.
var getSearchPages = function (userID, searchTerm) {
  var cleanTerm = searchTerm.replace(/[&\/\\#,+()$~%.'":*?<>{}]/g, '');
  console.log('cleaned up term is: ', cleanTerm);
  // create an instance of the proxy. 
  var ab = new Search();
  ab.setCallbackHandler(populatePageList);
  ab.setErrorHandler(myErrorHandler);
  ab.searchPages(userID, cleanTerm);
}

// Use an asynchronous call to bring back all books from the ColdFusion server.
var getSearchBooks = function (userID, searchTerm) {
  var cleanTerm = searchTerm.replace(/[&\/\\#,+()$~%.'":*?<>{}]/g, '');
  console.log('cleaned up term is: ', cleanTerm);
  // create an instance of the proxy. 
  var ab = new Search();
  ab.setCallbackHandler(populateBookList);
  ab.setErrorHandler(myErrorHandler);
  ab.searchBooks(userID, cleanTerm);
}

// CALLBACK FUNTION 
var populatePageList = function (resultList) {
  var resultDiv = document.getElementById("PageDiv");

  if (resultList.DATA.length !== 0) {
    var searchPlaceholder = document.getElementById("searchPlaceholder");
    var itemCode =
      '<H2 class="h2-responsive indigo-text">Pages:</h2>' +
      '<h3 class="h3-responsive">';
    for (k = 0; k < resultList.DATA.length; k++) {
      var resultID = resultList.DATA[k][0];
      var resultTitle = resultList.DATA[k][1];
      var resultInterviewee = resultList.DATA[k][2];
      var resultStoryDate = resultList.DATA[k][5];
      var resultUserDisplayName = resultList.DATA[k][8];
      var resultStoryTypeID = resultList.DATA[k][4];

      itemCode = itemCode +
        '<a href="/Stories/Story.cfm?StoryID=' + resultID + '"' +
        ' class="list-group-item list-group-item-action">'
      if (resultStoryTypeID === 2) {
        itemCode = itemCode + 'Interview of ' + resultInterviewee + '<br>';
      }
      itemCode = itemCode +
        resultTitle + ', by ' +
        resultUserDisplayName + ' on ' +
        resultStoryDate + '</a>';

    }
    itemCode = itemCode + '</h3>';
    resultDiv.innerHTML = itemCode;
  } else {
    resultDiv.innerHTML = '<h2 class="h2-responsive indigo-text">' +
      'No pages found.</h2><br />'
  }
  return;
}

// BOOKLIST FUNTION 
var populateBookList = function (bookList) {
  var bookDiv = document.getElementById("BookDiv");

  if (bookList.DATA.length !== 0) {

    var itemCode =
      '<H2 class="h2-responsive indigo-text">Books & Time Capsules:</h2>' +
      '<h3 class="h3-responsive">';
    for (k = 0; k < bookList.DATA.length; k++) {
      var bookID = bookList.DATA[k][0];
      var bookTitle = bookList.DATA[k][1];
      var bookBookDate = bookList.DATA[k][2];
      var bookUserDisplayName = bookList.DATA[k][3];
      var bookTimeCapsuleDate = bookList.DATA[k][4];

      itemCode = itemCode +
        '<a href="/books/BookREader.cfm?BookID=' + bookID + '"' +
        ' class="list-group-item list-group-item-action">'
      console.log(bookTimeCapsuleDate);
      if (bookTimeCapsuleDate == null) {
        itemCode = itemCode + '<i class="fa fa-hourglass-start fa-lg" aria-hidden="true"></i> '
      }

      itemCode = itemCode + bookTitle + ', by ' +
        bookUserDisplayName + ' on ' +
        bookBookDate + '</a>';

    }

    itemCode = itemCode + '</h3>';
    bookDiv.innerHTML = itemCode;
  } else {
    bookDiv.innerHTML = '<h2 class="h2-responsive indigo-text">' +
      'No books found.</h2><br />'
  }

  return;
}
// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}