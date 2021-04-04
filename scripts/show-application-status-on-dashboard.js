function showApplicationStatusOnDashboard(url){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-application-status-on-dashboard.jsp?applicationNo="+url,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("submitted-application-table").innerHTML = ""+output;
}

function checkFormApprovedStatus(url){
    var applicationId = url.split("=")[1];
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/check-form-approved-status.jsp?applicationId="+applicationId,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    var status = output.trim();
    if(parseInt(status) == 1){   //If form is approved then you cannot edit it.
        document.getElementById("edit-id").disabled = true;
    } else {
        isApplicationRejected(url);
        document.getElementById("edit-id").disabled = false;
    }
}

function isApplicationRejected(url){
    var applicationId = url.split("=")[1];
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/is-application-rejected.jsp?applicationId="+applicationId,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    var rejectStatus = output.trim();
    //alert(rejectStatus);
    if(rejectStatus != "0"){
        document.getElementById("display-rejection-div-id").style.display = 'block';
        document.getElementById("display-rejection-div-id").style.backgroundColor = '#b3e5fc';
        document.getElementById("show-reject-reason-id").innerHTML = "Rejection Reason: "+rejectStatus;
    }
}