// Use an asynchronous call to bring back all qc info from the ColdFusion server.
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

    // itemCode will update the answerDiv
    var itemCode = '';

    if (typeof (answerList) === 'number') {

      return
    } else {
    for (k = 0; k < answerList.DATA.length; k++) {
      var dispDiv = 'qcListDiv' + answerList.DATA[k][1];
      console.log('dispDiv is: ', dispDiv);
      var qcAnswerDiv = document.getElementById(dispDiv);
      console.log(qcAnswerDiv, 'is the dispDiv')

      var qcAnswer = answerList.DATA[k][2];
      console.log(qcAnswer);
      var qcUserDisplayName = answerList.DATA[k][3];
      console.log(qcUserDisplayName);
      itemCode = itemCode +
        '<div class="qcListDiv"' + '>' +
        qcUserDisplayName + ': ' +
        qcAnswer + 
        '</div>'
    }
    itemCode = itemCode + 
    '<br><a href="editQCAnswer.cfm?qcAnswerID=' + answerList.DATA[0][1] + 
    '" class="btn btn-sm btn-secondary">' + 
    '<i class="far fa-edit icon-align-center"></i>' +
    '</a>' + '<BR>'
    console.log('itemCode is: ', itemCode);
    qcAnswerDiv.innerHTML = itemCode;
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
  // document.getElementById('editQCBtn').style.display = 'inline';
  return;
}

var getMyAnswer = function (qcID, userID) {
  console.log('starting getMyAnswer');
  if (qcID === 1) {
     document.getElementById('QCAnswer').style.display='none';
     document.getElementById('saveQCBtn').style.display='none';
    //  document.getElementById('editQCBtn').style.display='none'; 
    //  document.getElementById('saveEditQCBtn').style.display='none';  
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
    // document.getElementById('editQCBtn').style.display = 'inline';
    // document.getElementById('saveEditQCBtn').style.display = 'none';
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
  // document.getElementById('editQCBtn').style.display = 'none';
  // document.getElementById('saveEditQCBtn').style.display = 'inline';
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
  // document.getElementById('editQCBtn').style.display = 'inline';
  // document.getElementById('saveEditQCBtn').style.display = 'none';

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
    // itemCode will update the answerDiv
    var itemCode = '';
    for (k = 0; k < answerList.DATA.length; k++) {
        var qcListDiv = 'qcListDiv' + answerList.DATA[k][1];
        if (answerList === 'No answers') {
          var qcAnswerDiv = document.getElementById("qcListDiv");
          var itemCode = 'No one has answered yet.';
          qcAnswerDiv.innerHTML = itemCode;
          return
        } else {


      var answerDiv = 'qcListDiv' + answerList.DATA[k][1];
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