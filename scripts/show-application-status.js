function showApplicationStatus(){
    xmlhttp = new XMLHttpRequest();
    var applicationNo = document.myForm.applicationNo.value;
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-application-status.jsp?applicationNo="+applicationNo,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("show-application-status").innerHTML = ""+output;
}