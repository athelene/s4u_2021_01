// Used when adding/editing a book to be a time capsule
function timeCapsuleCheck() {
  if ($("#tcSwitch").prop("checked")) {
    $("#TimeCapsule").addClass(".visible");
  } else {
    $("#TimeCapsule").val('');
    $("#TimeCapsule").addClass(".invisible");
  };
}

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

// GET MEMBER LIST FOR PAGES 
var getMembers = function () {
  var circleVal = document.getElementById("CircleID").value;
  var m = new mem(circleVal);
  m.setCallbackHandler(populateMembers);
  m.setErrorHandler(myErrorHandler);
  m.getMembers(circleVal);
}

// GET MEMBER LIST FOR BOOKS
var getBookMembers = function () {
  var circleVal = document.getElementById("CircleID").value;
  var l = new memBook(circleVal);
  l.setCallbackHandler(populateBookMembers);
  l.setErrorHandler(myErrorHandler);
  l.getBookMembers(circleVal);
}

// Exclude MEMBERs from a page
// Use an asynchronous call to get the member details. 
var excludeMembers = function (memberID, circleVal) {
  var circleVal = document.getElementById("CircleID").value;
  var u = new exc(memberID, circleVal);
  u.setCallbackHandler(populateMembers);
  u.setErrorHandler(myErrorHandler);
  u.excludeMembers(memberID, circleVal);
}

// Used to restore members of a circle to be able to a page
var restoreMembers = function (memberID) {
  var circleVal = document.getElementById("CircleID").value;
  var u = new add(memberID, circleVal);
  u.setCallbackHandler(populateMembers);
  u.setErrorHandler(myErrorHandler);
  u.restoreMembers(memberID, circleVal);
}

// Callback function to display the results of the getMemberDetails 
// function (for pages). 
var populateMembers = function (member) {
  var MemDiv = document.getElementById("MemDiv");
  with(document.simpleAJAX) {
    {
      setUL =
        '<table class="table table-hover">' +
        '<tbody>'
    }
    for (j = 0; j < member.DATA.length; j++) {
      var mMemberID = member.DATA[j][0];
      var mUserDisplayName = member.DATA[j][1];
      var mExcStatus = member.DATA[j][2];

      if (mExcStatus === 'In') {
        var btnCode =
          '<div class="switch">' +
          '<label> No' +
          '<input type="checkbox" Checked ' +
          'onClick="excludeMembers(' + mMemberID + ')"' + '>' +
          '<span class="lever"></span> Yes' +
          '</label>' +
          '</div>' +
          '</tr>'
      } else {
        var btnCode =
          '<div class="switch">' +
          '<label> No' +
          '<input type="checkbox" ' +
          'onClick="restoreMembers(' + mMemberID + ')"' + '>' +
          '<span class="lever"></span> Yes' +
          '</label>' +
          '</div>' +
          '</tr>'
      }
      setUL = setUL +
        '<tr>' +
        '<td>' + mUserDisplayName + '</td>' +
        '<td>' +
        btnCode
    }
  }
  setUL = setUL +
    '</tbody>' +
    '</table>';
  MemDiv.innerHTML = setUL;
}

// Callback function to display the results of the getBookMemberDetails 
// function (for book editing). 
var populateBookMembers = function (BKmember) {
  var MemDiv = document.getElementById("MemDiv");
  with(document.simpleAJAX) {
    {
      setUL =
        '<table class="table table-hover">' +

        '<tbody>'
    }
    for (k = 0; k < BKmember.DATA.length; k++) {
      var kMemberID = BKmember.DATA[k][0];
      var kUserDisplayName = BKmember.DATA[k][1];
      var kExcStatus = BKmember.DATA[k][2];

      if (kExcStatus === 'In') {
        var btnCode =
          '<div class="switch">' +
          '<label> No' +
          '<input type="checkbox" Checked ' +
          'onClick="excludeMembersBK(' + kMemberID + ')"' + '>' +
          '<span class="lever"></span> Yes' +
          '</label>' +
          '</div>' +
          '</tr>'
      } else {
        var btnCode =
          '<div class="switch">' +
          '<label> No' +
          '<input type="checkbox" ' +
          'onClick="restoreMembersBK(' + kMemberID + ')"' + '>' +
          '<span class="lever"></span> Yes' +
          '</label>' +
          '</div>' +
          '</tr>'
      }
      setUL = setUL +

        '<tr>' +
        '<td>' + kUserDisplayName + '</td>' +
        '<td>' +

        btnCode
    }

  }
  setUL = setUL +
    '</tbody>' +
    '</table>';
  MemDiv.innerHTML = setUL;
}

// Exclude MEMBERs from a book during edit. 
// Use an asynchronous call to get the member details. 
var excludeMembersBK = function (memberID, circleVal) {
  var circleVal = document.getElementById("CircleID").value;
  var u = new excBK(memberID, circleVal);
  u.setCallbackHandler(getBookMembers);
  u.setErrorHandler(myErrorHandler);
  u.excludeMembersBK(memberID, circleVal);
}

// Used to restore members of a circle to be able to a book during edit
var restoreMembersBK = function (memberID) {
  var circleVal = document.getElementById("CircleID").value;
  var u = new addBK(memberID, circleVal);
  u.setCallbackHandler(getBookMembers);
  u.setErrorHandler(myErrorHandler);
  u.restoreMembersBK(memberID, circleVal);
}

// Used to get members of a circle to be able to see a new book
var getNewBookMembers = function () {
  var circleVal = document.getElementById("CircleID").value;
  var l = new memNewBook(circleVal);
  l.setCallbackHandler(populateNewBookMembers);
  l.setErrorHandler(myErrorHandler);
  l.getNewBookMembers(circleVal);
}

// Callback function to display the results of getNewBookMembers 
var populateNewBookMembers = function (NBKmember) {
  var MemDiv = document.getElementById("MemDiv");
  with(document.simpleAJAX) {
    {
      setUL =
        '<table class="table table-hover">' +
        '<tbody>'
    }
    for (k = 0; k < NBKmember.DATA.length; k++) {
      var kMemberID = NBKmember.DATA[k][0];
      var kUserDisplayName = NBKmember.DATA[k][1];
      var kExcStatus = NBKmember.DATA[k][2];

      if (kExcStatus === 'In') {
        var btnCode =
          '<div class="switch">' +
          '<label> No' +
          '<input type="checkbox" Checked ' +
          'onClick="excludeMembersNBK(' + kMemberID + ')"' + '>' +
          '<span class="lever"></span> Yes' +
          '</label>' +
          '</div>' +
          '</tr>'
      } else {
        var btnCode =
          '<div class="switch">' +
          '<label> No' +
          '<input type="checkbox" ' +
          'onClick="restoreMembersNBK(' + kMemberID + ')"' + '>' +
          '<span class="lever"></span> Yes' +
          '</label>' +
          '</div>' +
          '</tr>'
      }
      setUL = setUL +
        '<tr>' +
        '<td>' + kUserDisplayName + '</td>' +
        '<td>' +
        btnCode
    }
  }
  setUL = setUL +
    '</tbody>' +
    '</table>';
  MemDiv.innerHTML = setUL;
}

// Used to exclude members of a circle from a new book 
var excludeMembersNBK = function (memberID, circleVal) {
  var circleVal = document.getElementById("CircleID").value;
  var u = new excNBK(memberID, circleVal);
  u.setCallbackHandler(getNewBookMembers);
  u.setErrorHandler(myErrorHandler);
  u.excludeMembersNBK(memberID, circleVal);
}

// Used to restore members of a circle to a new book
var restoreMembersNBK = function (memberID) {
  var circleVal = document.getElementById("CircleID").value;
  var u = new addNBK(memberID, circleVal);
  u.setCallbackHandler(getNewBookMembers);
  u.setErrorHandler(myErrorHandler);
  u.restoreMembersNBK(memberID, circleVal);
}

// GET MEMBER LIST FOR PAGES 
var sessionUserid = function (userID) {
  var sessionUserID = new sessionUser(userID);
  sessionUserID.setCallbackHandler(setSessionUserID);
  sessionUserID.setErrorHandler(myErrorHandler);
  sessionUserID.sessionUserid(userID);
}

var setSessionUserID = function (userID) {
  window.UserID = userID.DATA[0][0];
  console.log("userid is: ", window.UserID)
  return;
}
// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}