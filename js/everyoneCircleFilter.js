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

// GET MEMBER LIST FOR Exclude  
var getEveryoneMembers = function (everyoneID) {
  console.log('getting new mem using getMemberList');
  var m = new mem();
  console.log('mem created should have new list of group 5 members');
  m.setCallbackHandler(populateEveryoneMembers);
  m.setErrorHandler(myErrorHandler);
  m.getMemberList(everyoneID);
}

// Callback function to display the results of the getCircleMembers 
// function (for editing Circles). 
var populateEveryoneMembers = function (member) {
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
        '<div class="list-group s4u-LibraryBlock w-50">' +


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
var searchEveryoneList = function (circleID, everyoneCircle) {
  console.log('starting searchEveryoneList');
  var searchTerm = document.getElementById("searchInput").value;
  console.log('clearing out input and searchDiv')
  document.getElementById("searchInput").value = '';
  document.getElementById("searchDiv").innerHTML = '';
  console.log('about to search everyone list')
  var m = new mem();
  console.log('created new mem to get search results, then headed to selectCircleMembers');
  m.setCallbackHandler(selectEveryoneMembers);
  m.setErrorHandler(myErrorHandler);
  m.searchEveryoneList(circleID, everyoneCircle, searchTerm);
}

// Callback function to display the results of searching for name in Everyone Circle
var selectEveryoneMembers = function (member) {
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
var inviteToEveryone = function (circleID, memID, userID) {
  console.log('starting inviteToEveryone');
  var e = new mem();
  console.log('created new mem with the circleID and everyone circle');
  e.setCallbackHandler(updateEveryoneList);
  e.setErrorHandler(myErrorHandler);
  e.inviteToEveryone(circleID, memID, userID);
}
// GET MEMBER LIST FOR Editing Circle 
var updateEveryoneList = function (data) {
  var setCircleID = data;
  console.log('setCircleID is: ', setCircleID);
  document.getElementById("searchInput").value = '';
  document.getElementById("searchDiv").innerHTML = '';
  console.log('search input and div should be blank');
  console.log('about to run getCircleMembers with circle is: ', setCircleID);
  getInvitedList(setCircleID);
  return;

}

// GET Full MEMBER LIST FOR adding to Everyone Circle
var searchFullMembership = function (everyoneCircle) {
  console.log('starting searchFullMembership');
  var searchTerm = document.getElementById("searchInput").value;
  var sessionUserid = document.getElementById("session.userid").value;
  console.log('clearing out input and searchDiv')
  document.getElementById("searchInput").value = '';
  document.getElementById("searchDiv").innerHTML = '';
  console.log('about to search everyone list')
  var m = new mem();
  console.log('created new mem to get search results, then headed to populateFullMembershipSearch');
  m.setCallbackHandler(populateFullMembershipSearch);
  m.setErrorHandler(myErrorHandler);
  m.searchFullMemberList(everyoneCircle, searchTerm, sessionUserid);
}

// Callback function to display the results of searching for name in Full Membership
var populateFullMembershipSearch = function (member) {
  console.log('starting populateFullMembershipSearch');
  var sessionUserID = document.getElementById("session.userid").value;
  var CircleDiv = document.getElementById("searchDiv");
  if (member.DATA.length === 0) {
    searchDiv.innerHTML = '<h4><i class="fas fa-exclamation-circle"></i>' +
      'The person you are searching for doesn\'t appear to be a member.</h4>' +
      '<a class="btn btn-warning" href="InviteNewMember.cfm">' +
      'Invite Them!</button>'
    return;
  } else {
    var itemCode = '<h4>Add from this list:<BR>';
    for (k = 0; k < member.DATA.length; k++) {

      var memUserDisplayName = member.DATA[k][0];
      var memOwnerID = member.DATA[k][4];
      var everyoneID = member.DATA[k][5];

      itemCode = itemCode +
        '<div class="w-50">' +
        '<button class="btn-sm btn btn-secondary" onclick="inviteToEveryone(' +
        everyoneID + ', ' + memOwnerID + ', ' + sessionUserID + ')' +
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

// GET MEMBER LIST FOR Editing Circle 
var getInvitedList = function (everyoneID) {
  console.log('starting getMemberList');
  var m = new mem();
  m.setCallbackHandler(populateInvitedMembers);
  m.setErrorHandler(myErrorHandler);
  m.getInvitedList(everyoneID);
}

// function (for editing Circles). 
var populateInvitedMembers = function (member) {
  console.log('starting populateCircleMembers');
  var invitedDiv = document.getElementById("invitedDiv");
  if (member.DATA.length === 0) {
    invitedDiv.innerHTML = "You have no outstanding invitations."
    return;
  } else {
    var itemCode = '';
    for (k = 0; k < member.DATA.length; k++) {
      var remID = member.DATA[k][4];
      var remEveryoneID = member.DATA[k][5];
      var remUserDisplayName = member.DATA[k][1];

      itemCode = itemCode +
        '<div class="list-group s4u-LibraryBlock w-50">' +

        '<span class="newSaltUser">' +
        '<h4>' +
        '<button class="btn-sm btn btn-secondary" onclick="removeInvitation(' +
        remID + ', ' + remEveryoneID + ')' +
        '">' +
        '<i class="fa fa-minus-circle"></i>' +
        '</button>' +
        remUserDisplayName +
        '</h4>' +
        '</span>' +
        '</div>'
    }
  }
  invitedDiv.innerHTML = itemCode
  return;
}

// Use an asynchronous call to add friend to a circle 
var removeInvitation = function (remID, userID) {
  console.log('starting removeFromCircle');
  var e = new mem();
  console.log('created new mem to delete member, return circleID');
  e.setCallbackHandler(remInvitationList);
  e.setErrorHandler(myErrorHandler);
  e.removeInvitation(remID, userID);
}

// GET MEMBER LIST FOR Editing Circle 
var remInvitationList = function (data) {
  var everyoneID = data.DATA[0][0];
  console.log('setCircleID is: ', everyoneID);
  getInvitedList(everyoneID);
  return;

}