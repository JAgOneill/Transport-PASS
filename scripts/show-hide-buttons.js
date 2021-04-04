function showHideButtons(url){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/show-hide-buttons.jsp?"+url,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    if(output.trim() == "1"){
        document.getElementById("dashboardButton").style.display = "block";
        document.getElementById("applyButton").style.display = "none";
    } else {
        document.getElementById("applyButton").style.display = "block";
        document.getElementById("dashboardButton").style.display = "none";
    }
}