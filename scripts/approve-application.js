function approveApplication(){
    var applicationId = document.getElementById("applicationId").value;
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/approve-application.jsp?applicationId="+applicationId,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    alert(output.trim());
    window.location = "admin-dashboard.html";
    //document.getElementById("submitted-application-table").innerHTML = ""+output;
}