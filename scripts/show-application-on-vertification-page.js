function showApplicationOnVertificationPage(url){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-application-on-vertification-page.jsp?applicationId="+url,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    var split = output.trim().split("$");
    document.getElementById("show-application-id").innerHTML = ""+split[0];
    var photoPath = split[1].split("webapps");
    var aadharCardPath = split[2].split("webapps");
    var applicationId = split[3];
    document.getElementById("photo-id").src = photoPath[1];
    document.getElementById("aadhar-card-id").src = aadharCardPath[1];
    document.getElementById("applicationId").value = applicationId;
}
