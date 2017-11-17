function openForms(e) {
    e.preventDefault();

    var formName = e.currentTarget.name;

    tabForm(e, formName);
    document.getElementById("loginForm").style.height = "100%";
    document.getElementsByClassName("tablinks")[formName].className += " active"
}

function closeForms() {
    document.getElementById("loginForm").style.height = "0%";
}


