function contactNoValidation() {
    var phoneNo = document.getElementById("contact_no").value;
    var checkString = /^\d{10}$/;
    if((phoneNo.match(checkString))) {
        return true;
    } else {
        alert("Phone No must contains 10 digits.");
        return false;
    }
}