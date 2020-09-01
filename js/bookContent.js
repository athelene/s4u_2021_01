// Used to get books and TCs for a page

var getStoryBooks = function (storyID, userID) {
  var storyBooks = new BookContent();
  storyBooks.setCallbackHandler(setBookList);
  storyBooks.setErrorHandler(myErrorHandler);
  storyBooks.getBookList(storyID, userID);
}

// CALLBACK FUNTION to display the books and TCs for a page
var setBookList = function (bkList) {
  var BookDiv = document.getElementById("storyBookList");
  if (bkList === " ") {
    BookDiv.innerHTML = '<div>' +
      '<h5>This page is not a part of any books or time capsules.</h5>' +
      '</Div>';
    return;
  } else {
    var itemCode = '<div class="list-group-flush">';

    for (k = 0; k < bkList.DATA.length; k++) {

      var bkID = bkList.DATA[k][0];
      var bkStoryID = bkList.DATA[k][1];
      var bkTitle = bkList.DATA[k][2];
      var bkOwner = bkList.DATA[k][3];
      var bkTCDate = bkList.DATA[k][4];
      var bkUserDisplayName = bkList.DATA[k][5];
      var bkIsOwner = bkList.DATA[k][6];

      if (bkIsOwner === 1) {

        itemCode = itemCode +
          '<div class="list-group-item col-md-auto">' +
          '<p class="mb-0">' + bkTitle +
          '<a class="btn-circle" href="/books/DeleteFromBook.cfm?StoryID=' +
          bkStoryID + '&bookID=' + bkID + '" ' +
          'title="Delete this story from ' +
          bkTitle + '" ' +
          'name="Delete Story" onclick="return confirm(\'Are you sure you want to remove this item?\');">' +
          '<i class="fas fa-minus-circle icon-align-center"></i>' +
          '</a>' +
          '</p>' +
          '</div>';
      } else {
        itemCode = 'This page is not saved in any of your books or time capsules.'
      }

    }

    if (itemCode !== 'This page is not saved in any of your books or time capsules.') {
      itemCode = '<h5>This story is saved in the following books and time capsules: </h5>' +
        itemCode
    }
    BookDiv.innerHTML = itemCode;
    BookDiv.classList.add("list-group");
    BookDiv.classList.add("s4u-FeedBlock");
    return;
  }
}

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}