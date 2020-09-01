// Use an asynchronous call to bring back all books from the ColdFusion server.
var getInterview= function () {
  // create an instance of the proxy. 
  var ab = new interview();
  ab.setCallbackHandler(populateInterviewList);
  ab.setErrorHandler(myErrorHandler);
  ab.getInterview();
}

// CALLBACK FUNTION 
var populateInterviewList = function (interviewList) {
  var interviewDiv = document.getElementById("interviewDiv");
  var itemCode = '';
  var catCode = '';
  if (interviewList === "You haven't created any yet.") {
    interviewDiv.innerHTML = "You haven't created any yet."
    return;
  } else {

    for (k = 0; k < interviewList.DATA.length; k++) {
      var interviewID = interviewList.DATA[k][0];
      var interviewOrgQuestion = interviewList.DATA[k][1];
      var interviewCategory = interviewList.DATA[k][2];
      var interviewQuestion = interviewOrgQuestion.replace(/'/g,"\'");
    
      if (interviewCategory !== catCode) {
          itemCode = itemCode + 
            '<div>' + '<strong>' + 
            interviewCategory + '</strong>' + '</div>';
            catCode = interviewCategory;
        }

      itemCode = itemCode + 

      '<div id="myLink" title="Click to select a tradition" ' +
          'class="divHover"' +
          'href="#" myAttr="' + 
          interviewQuestion + '" ' + 
          'onclick="setTitle(this.getAttribute(' + '\'myAttr\'));"' + 
          '>' +
          interviewQuestion + 
          '</div>' + '<br />'


 
    }
    console.log(itemCode);
    interviewDiv.innerHTML = itemCode;
    return;
  }
}

// set the title of the page to the question selected
var setTitle= function (title) {
    var titleInput = document.getElementById("StoryTitle");
    titleInput.value = title;
    $("[data-dismiss=modal]").trigger({ type: "click" });
  }

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}

