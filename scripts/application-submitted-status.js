function isSubmitted(url){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/pmt-pass/jsp-pages/application-submitted-status.jsp?"+url,false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    if(parseInt(output.trim()) == 1){
        alert("Application already submitted! You cannot create another application. But you can edit your application.!");
        window.location.href = "dashboard.html?"+url;
    }
}