function showApprovedDetails(){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-approved-applications.jsp",false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("show-approved-applications-table-body").innerHTML = ""+output;
}