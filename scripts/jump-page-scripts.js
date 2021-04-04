function getURL(){
	var URL = window.location.href;
	var splitURLByQuestionMark = URL.split("?");
	return splitURLByQuestionMark[1];
}
function goToBusPassApplicationForm(){
	window.location = "bus-pass-application-form.html?"+getURL();
}
function goToCheckStatus(){
	window.location = "check-status.html?"+getURL();
}
function goToDashboard(){
	window.location = "dashboard.html?"+getURL();
}
function goToLogoutPage(){
	window.location = "jsp-pages/logout.jsp?"+getURL();
}