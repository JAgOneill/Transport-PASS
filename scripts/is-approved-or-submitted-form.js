function isFormSubmitted(url){
    var applicationId = url.split("=")[1];
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/is-approved-or-submitted-form.jsp?applicationId="+applicationId,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    var status = output.trim();
    if(parseInt(status) == 1){
        document.getElementById("make-payment-id").disabled = false;
    } else {
        document.getElementById("make-payment-id").disabled = true;
    }
}