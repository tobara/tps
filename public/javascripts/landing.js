
function openForms(e) {
    e.preventDefault();
    formName = e.currentTarget.name;
    tabBtns = document.getElementsByClassName('tablinks');
    tabForm(event, formName);

    document.getElementById("loginForm").style.height = "100%";
    tabBtns[formName].className += " active"
}

function closeForms() {
    document.getElementById("loginForm").style.height = "0%";
}


