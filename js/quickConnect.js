// Use an asynchronous call to bring back all story media from the ColdFusion server.
var getQCAnswers = function (QCID, EveryoneCircle, userID) {
  console.log('starting getQCAnswers');
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  ab.setCallbackHandler(populateQCAnswers);
  ab.setErrorHandler(myErrorHandler);
  ab.getQCAnswers(QCID, EveryoneCircle, userID);
}

// CALLBACK FUNTION 
var populateQCAnswers = function (answerList) {
  console.log('starting populateQCAnswers');
  console.log(answerList);
  if (answerList === 'No answers') {
    var qcAnswerDiv = document.getElementById("qcAnswerDiv");
    var itemCode = 'No one has answered yet.';
    qcAnswerDiv.innerHTML = itemCode;
    return
  } else {

    // itemCode will update the answerDiv
    var itemCode = '';
    for (k = 0; k < answerList.DATA.length; k++) {
      var divNo = k + 1;
      var answerDiv = 'qcAnswerDiv' + divNo;
      console.log(answerDiv, 'is the answerDiv');
      var qcAnswerDiv = document.getElementById(answerDiv);

      var qcAnswer = answerList.DATA[k][2];
      console.log(qcAnswer);
      var qcUserDisplayName = answerList.DATA[k][3];
      console.log(qcUserDisplayName);
      itemCode = itemCode +
        '<div>' +
        qcUserDisplayName + ': ' +
        qcAnswer +
        '</div>'
      console.log('itemCode is: ', itemCode);
      qcAnswerDiv.innerHTML = itemCode;

    }
    return;
  }
}

var saveMyAnswer = function (userID, qcID) {
  console.log('starting saveMyAnswer');
  var answerValue = document.getElementById("QCAnswer").value;
  console.log(answerValue);
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  console.log('new cqAnswers ran');
  ab.setCallbackHandler(saveMyAnswerCheck);
  ab.setErrorHandler(myErrorHandler);
  ab.saveMyAnswer(qcID, userID, answerValue);
}

var saveMyAnswerCheck = function (data) {
  console.log('answer added');
  document.getElementById('QCAnswer').style.display = 'none';
  document.getElementById('saveQCBtn').style.display = 'none';
  document.getElementById('editQCBtn').style.display = 'inline';
  return;
}

var getMyAnswer = function (qcID, userID) {
  console.log('starting getMyAnswer');
  if (qcID === 1) {
     document.getElementById('QCAnswer').style.display='none';
     document.getElementById('saveQCBtn').style.display='none';
     document.getElementById('editQCBtn').style.display='none'; 
     document.getElementById('saveEditQCBtn').style.display='none';  
    return;
  }
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  console.log('new cqAnswers ran');
  ab.setCallbackHandler(populateMyAnswer);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyAnswer(qcID, userID);
}

var populateMyAnswer = function (data) {
  console.log('filling in input field');
  console.log('data length is: ', data.DATA.length);
  if (data.DATA.length === 0) {
    document.getElementById('QCAnswer').value = '';
    document.getElementById('QCAnswer').style.display = 'inline';
    document.getElementById('saveQCBtn').style.display = 'inline';
    document.getElementById('editQCBtn').style.display = 'none';
    document.getElementById('saveEditQCBtn').style.display = 'none';
  } else {
    document.getElementById('QCAnswer').value = data.DATA[0][0];
    document.getElementById('QCAnswer').style.display = 'none';
    document.getElementById('saveQCBtn').style.display = 'none';
    document.getElementById('editQCBtn').style.display = 'inline';
    document.getElementById('saveEditQCBtn').style.display = 'none';
  }
  return;
}

var editMyAnswer = function (userID, qcID) {
  console.log('starting editMyAnswer');
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  console.log('new cqAnswers ran');
  ab.setCallbackHandler(populateEditAnswer);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyAnswer(qcID, userID);
}

var populateEditAnswer = function (myAnswer) {
  console.log('filling in input field');
  if (myAnswer.DATA.length === null) {
    document.getElementById('QCAnswer').value = myAnswer.DATA[0][0];
  }
  document.getElementById('QCAnswer').style.display = 'inline';
  document.getElementById('saveQCBtn').style.display = 'none';
  document.getElementById('editQCBtn').style.display = 'none';
  document.getElementById('saveEditQCBtn').style.display = 'inline';
  return;
}

var saveMyEdit = function (userID, qcID) {
  console.log('starting saveMyAnswer');
  var answerValue = document.getElementById("QCAnswer").value;
  console.log(answerValue);
  if (answerValue.len = "") {
    deleteMyAnswer(userID, qcID)
    return
  }
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  console.log('new cqAnswers ran');
  ab.setCallbackHandler(saveMyEditCheck);
  ab.setErrorHandler(myErrorHandler);
  ab.saveMyEdit(qcID, userID, answerValue);
}

var saveMyEditCheck = function (data) {
  console.log('answer updated');
  document.getElementById('QCAnswer').style.display = 'none';
  document.getElementById('saveQCBtn').style.display = 'none';
  document.getElementById('editQCBtn').style.display = 'inline';
  document.getElementById('saveEditQCBtn').style.display = 'none';

  return;
}

var deleteMyAnswer = function (userID, qcID) {
  console.log('starting saveMyAnswer');
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  console.log('new cqAnswers ran');
  ab.setCallbackHandler(saveMyEditCheck);
  ab.setErrorHandler(myErrorHandler);
  ab.deleteMyAnswer(qcID, userID);
}

var getMyAnswerPage = function (qcID, userID) {
  console.log('starting getMyAnswer');

  // create an instance of the proxy. 
  var ab = new qcAnswers();
  console.log('new cqAnswers ran');
  ab.setCallbackHandler(populateMyAnswer);
  ab.setErrorHandler(myErrorHandler);
  ab.getMyAnswer(qcID, userID);
}

var populateMyAnswerPage = function (data) {
  return;
}

// Use an asynchronous call to bring back all story media from the ColdFusion server.
var getQCToday = function (QCID, EveryoneCircle, userID) {
  console.log('starting getQCToday');
  // create an instance of the proxy. 
  var ab = new qcAnswers();
  ab.setCallbackHandler(populateQCToday);
  ab.setErrorHandler(myErrorHandler);
  ab.getQCAnswers(QCID, EveryoneCircle, userID);
}

// CALLBACK FUNTION 
var populateQCToday = function (answerList) {
  console.log('starting populateQCToday');
  console.log(answerList);
  if (answerList === 'No answers') {
    var qcAnswerDiv = document.getElementById("qcAnswerDiv");
    var itemCode = 'No one has answered yet.';
    qcAnswerDiv.innerHTML = itemCode;
    return
  } else {

    // itemCode will update the answerDiv
    var itemCode = '';
    for (k = 0; k < answerList.DATA.length; k++) {
      var answerDiv = 'qcAnswerDiv';
      console.log(answerDiv, 'is the answerDiv');
      var qcAnswerDiv = document.getElementById(answerDiv);

      var qcAnswer = answerList.DATA[k][2];
      console.log(qcAnswer);
      var qcUserDisplayName = answerList.DATA[k][3];
      console.log(qcUserDisplayName);
      itemCode = itemCode +
        '<div>' +
        qcUserDisplayName + ': ' +
        qcAnswer +
        '</div>'
      console.log('itemCode is: ', itemCode);
      qcAnswerDiv.innerHTML = itemCode;

    }
    return;
  }
}
// ____________________________________________________________
// Error handler for the asynchronous functions. 
var myErrorHandler = function (statusCode, statusMsg) {
  alert('Status: ' + statusCode + ', ' + statusMsg);
}