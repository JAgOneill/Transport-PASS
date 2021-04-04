function ifFormSubmittedThenEnableEditButton(url){
    var applicationId = url.split("=")[1];
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/if-form-submitted-then-enable-edit-button.jsp?applicationId="+applicationId,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    var status = output.trim();
    if(parseInt(status) == 1){
        document.getElementById("edit-id").disabled = false;
    } else {
        document.getElementById("edit-id").disabled = true;
    }
}