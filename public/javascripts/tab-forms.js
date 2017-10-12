function tabForm(evt, formName) {

    [].forEach.call(document.getElementsByClassName('tabcontent'), function(tc) {
        tc.style.display = 'none';
    });

    [].forEach.call(document.getElementsByClassName('tablinks'), function(tl) {
        tl.className = tl.className.replace(" active", "");
    });

    document.getElementById(formName).style.display = "block";
    evt.currentTarget.className += " active";
}
