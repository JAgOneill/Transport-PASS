function showDetailsOfPassenger(url){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-details-of-passenger-in-edit-form.jsp?applicationNo="+url,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    if(output.trim() == "DATA-NOT-AVAILABLE"){
        alert(" Please fill the application form first!!!");
    } else {
        var split = output.split("$");
        document.busPassForm.passengerName.value = split[0];
        document.busPassForm.message.value = split[1];
        document.busPassForm.passengerDOB.value = split[2];
        document.busPassForm.busRouteFrom.value = split[3];
        document.busPassForm.busRouteTo.value = split[4];
        document.busPassForm.city.value = split[6];
        document.busPassForm.gender.value = split[7];
    }
    //Following is used only for testing the data don't uncomment it.
    //document.getElementById("show-application-status").innerHTML = ""+output;
}