function enableOrDisablePrintPassButton(url){
    var applicationId = url.split("=")[1];
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/enable-or-disable-print-pass-button.jsp?applicationId="+applicationId,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    var paymentStatus = output.trim();
    if(parseInt(paymentStatus) == 1){
        document.getElementById("print-pass-id").disabled = false;
    } else {
        document.getElementById("print-pass-id").disabled = true;
    }
}