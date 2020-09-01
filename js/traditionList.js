// Use an asynchronous call to bring back all books from the ColdFusion server.
var getTradition = function () {
  // create an instance of the proxy. 
  var ab = new tradition();
  ab.setCallbackHandler(populateTraditionList);
  ab.setErrorHandler(myErrorHandler);
  ab.getTradition();
}

// CALLBACK FUNTION 
var populateTraditionList = function (traditionList) {
  var traditionDiv = document.getElementById("traditionDiv");
  var itemCode = '';
  if (traditionList === "You haven't created any yet.") {
    traditionDiv.innerHTML = "You haven't created any yet."
    return;
  } else {

    for (k = 0; k < traditionList.DATA.length; k++) {
      var traditionID = traditionList.DATA[k][0];
      var traditionOrgName = traditionList.DATA[k][1];
      var traditionName = traditionOrgName.replace(/'/g, "\'");


      itemCode = itemCode +

        '<div id="myLink" title="Click to select a tradition" ' +
        'class="divHover"' +
        'href="#" myAttr="' +
        traditionName + '" ' +
        'onclick="setTitle(this.getAttribute(' + '\'myAttr\'));"' +
        '>' +
        traditionName +
        '</div>' + '<br />'

    }
    console.log(itemCode);
    traditionDiv.innerHTML = itemCode;
    return;
  }
}

// set the title of the page to the question selected
var setTitle = function (title) {
  console.log(title);
  var titleInput = document.getElementById("StoryTitle");
  titleInput.value = title;
  console.log(titleInput.value);
  $("[data-dismiss=modal]").trigger({
    type: "click"
  });
}

// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}