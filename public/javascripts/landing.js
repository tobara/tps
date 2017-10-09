
function openForms(e) {
    e.preventDefault();
    formName = e.currentTarget.name;
    tabForm(e, formName);
    document.getElementById("loginForm").style.height = "100%";
}

function closeForms() {
    document.getElementById("loginForm").style.height = "0%";
}


