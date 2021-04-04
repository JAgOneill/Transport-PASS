function selectedFile(originalFile, fileType) {
	if(checkTypeOfFile(originalFile.value)){
        if(fileType == "photo"){
            uploadPhoto();
        } else {
            uploadAadharCard();
        }
	} else {
		alert("Invalid file");
	}
}
     
function checkTypeOfFile(fileName) {
	var extension = fileName.split(".")[1];
	var flag = false;
	if(extension == "jpg" || extension == "png" || extension == "jpeg"){
		flag = true;
	}
	return flag;
}

function uploadPhoto(){
    xmlhttp = new XMLHttpRequest();
    var imageFile = document.busPassForm.myPhoto.files[0];
    var applicationNo = getURL().split("=")[1];
    var fileName = imageFile.name;

    var formData = new FormData();
    formData.append("file", imageFile);
    xmlhttp.open("POST","/pmt-pass/jsp-pages/upload-photo.jsp?fileName="+fileName+"&applicationNo="+applicationNo,false);
    xmlhttp.send(formData);
    output = xmlhttp.responseText;
    document.getElementById("photoStatus").innerHTML = ""+output;
}

function uploadAadharCard(){
    xmlhttp = new XMLHttpRequest();
    var imageFile = document.busPassForm.myAadharCard.files[0];
    var applicationNo = getURL().split("=")[1];
    var fileName = imageFile.name;

    var formData = new FormData();
    formData.append("file", imageFile);
    xmlhttp.open("POST","/pmt-pass/jsp-pages/upload-addhar-card.jsp?fileName="+fileName+"&applicationNo="+applicationNo,false);
    xmlhttp.send(formData);
    output = xmlhttp.responseText;
    document.getElementById("aadharCardStatus").innerHTML = ""+output;
}