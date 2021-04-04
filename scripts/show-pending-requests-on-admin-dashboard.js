function showPendingRequests(){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-pending-requests-on-admin-dashboard.jsp",false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("show-pending-request-table-body").innerHTML = ""+output;
}