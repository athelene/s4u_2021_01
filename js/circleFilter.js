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

// Use an asynchronous call to get the circles for the 
// drop-down circle list from the ColdFusion server. 
var getCircles = function (userID) {
  var e = new cir();
  e.setCallbackHandler(populateCircles);
  e.setErrorHandler(myErrorHandler);
  e.getCircle(userID);
}

var populateCircles = function (cirList) {
  var CircleDiv = document.getElementById("CircleDiv");
  if (cirList === "You have no circles.") {
    CircleDiv.innerHTML = "No pages fit your selection."
    return;
  } else {
    var itemCode = '';
    for (k = 0; k < cirList.DATA.length; k++) {
      var cirID = cirList.DATA[k][0];
      var cirCircleName = cirList.DATA[k][1];
      var cirCircleSort = cirList.DATA[k][2];

      itemCode = itemCode +
        '<div class="s4u-LibraryBlock s4u-delete-circle-btn">' 
        if (cirCircleSort !== "0") {
          itemCode = itemCode + 
          '<button class="btn btn-sm btn-secondary s4u-content-inline" onclick="deleteCircle(' +
          cirID + ')"' + '>' +
          '<i class="fa fa-minus-circle">' + 
          '</i>' + 
          '</button>';
        }
        itemCode = itemCode + 
        '<a href="/circles/editcircle.cfm?CircleID=' + cirID + '"' +
        ' class="list-group-item list-group-item-action">' +
        cirCircleName +
        '</a>' +
        '</div>';
      if (cirCircleSort === "0") {
        itemCode = itemCode + '<br />' + '<br />';
      }
    }

  }
  CircleDiv.innerHTML = itemCode
  return;

}

// GET MEMBER LIST FOR Exclude  
var getCircleMembers = function (CircleID) {
  console.log('getting new mem using getMemberList');
  var m = new mem();
  console.log('mem created should have new list of group 5 members');
  m.setCallbackHandler(populateCircleMembers);
  m.setErrorHandler(myErrorHandler);
  m.getMemberList(CircleID);
}

// Callback function to display the results of the getCircleMembers 
// function (for editing Circles). 
var populateCircleMembers = function (member) {
  console.log('starting populateCircleMembers');
  var CircleDiv = document.getElementById("CircleDiv");
  if (member.DATA.length === 0) {
    CircleDiv.innerHTML = "There are no members in this circle."
    return;
  } else {
    var itemCode = '';
    for (k = 0; k < member.DATA.length; k++) {
      var memRemID = member.DATA[k][4];
      var memUserDisplayName = member.DATA[k][1];
      var memCircleID = member.DATA[k][5];

      itemCode = itemCode +
        '<div class="list-group s4u-LibraryBlock">' +


        '<span class="newSaltUser">' +
        '<h4>' +
        '<button class="btn-sm btn btn-secondary" onclick="removeFromCircle(' +
        memRemID + ', ' + memCircleID + ')' +
        '">' +
        '<i class="fa fa-minus-circle"></i>' +
        '</button>' +
        memUserDisplayName +
        '</h4>' +
        '</span>' +
        '</div>'
    }
  }
  CircleDiv.innerHTML = itemCode
  return;

}

// GET MEMBER LIST FOR Editing Circle 
var getMemberList = function (CircleID) {
  console.log('starting getMemberList');
  var m = new mem(CircleID);
  m.setCallbackHandler(populateCircleMembers);
  m.setErrorHandler(myErrorHandler);
  m.getMemberList(CircleID);
}


// Callback function to display the results of searching for name in Everyone Circle
var selectCircleMembers = function (member) {
  console.log('starting selectCircleMembers');
  var CircleDiv = document.getElementById("searchDiv");
  if (member.DATA.length === 0) {
    searchDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i>' +
      "You must add the person you searched for to your Everyone Circle first."
    return;
  } else {
    var itemCode = '<h4>Add from this list:<BR>';
    for (k = 0; k < member.DATA.length; k++) {
      var memID = member.DATA[k][0];
      var memUserDisplayName = member.DATA[k][1];
      var memCircleID = member.DATA[k][5];
      var memEveryoneID = member.DATA[k][6];
      console.log('line 136');
      itemCode = itemCode +
        '<div class="w-50">' +
        '<button class="btn-sm btn btn-secondary" onclick="addToCircle(' +
        memCircleID + ', ' + memID + ', ' + memEveryoneID + ')' +
        '">' +
        '<i class="fas fa-plus"></i>' +
        '</button>' +
        memUserDisplayName +
        '</div>'

    }
    itemCode = itemCode +
      '<hr style="width: 100%; color: black; height: 1px; background-color:black;" />'
  }
  searchDiv.innerHTML = itemCode
  console.log('setting the searchDiv here');
  return;

}

// Use an asynchronous call to add friend to a circle 
var addToCircle = function (circleID, memID, userID) {
  console.log('starting addToCircle');
  var e = new mem();
  console.log('created new mem with the circleID and everyone circle');
  e.setCallbackHandler(remUpdateList);
  e.setErrorHandler(myErrorHandler);
  e.addMember(circleID, memID, userID);
}


// Use an asynchronous call to add friend to a circle 
var removeFromCircle = function (remID, circleID) {
  console.log('starting removeFromCircle');
  var e = new mem();
  console.log('created new mem to delete member, return circleID');
  e.setCallbackHandler(remUpdateList);
  e.setErrorHandler(myErrorHandler);
  e.removeMember(remID, circleID);
}

// GET MEMBER LIST FOR Editing Circle 
var remUpdateList = function (data) {
  var setCircleID = data.DATA[0][0];
  console.log('setCircleID is: ', setCircleID);
  document.getElementById("searchInput").value = '';
  document.getElementById("searchDiv").innerHTML = '';
  console.log('search input and div should be blank');
  console.log('about to run getCircleMembers');
  getCircleMembers(setCircleID);
  return;

}

// Use an asynchronous call to add friend to a circle 
var deleteCircle = function (circleID) {
  var userID = document.getElementById("userID").value;
  console.log('starting deleteCircle');
  console.log(userID);
  var e = new cir();
  console.log('created new cir to delete circleID', circleID, userID);
  e.setCallbackHandler(populateCircles);
  e.setErrorHandler(myErrorHandler);
  e.deleteCircle(circleID, userID);
}


