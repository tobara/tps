var clickState = 1;

function nameUpdate (event) {
  event.preventDefault();
  nameAction = document.getElementById('nameAction');
  clickState++;
  usernameField = document.getElementById('usernameField');
  if (clickState % 2 === 0) {
   nameAction.innerHTML = 'Save';
    usernameField.disabled = false;
    currentUsername = usernameField.placeholder;
    usernameField.value = currentUsername;
  } else {
        $(function (){
           $.ajax({
              url: "/user/"+userID+"/settings/username/edit",
              type: 'post', //send it through get method
              data: { username: $('#usernameField').val() },
              success: function(response) {
                $(".eds__flash").html('<div data-alert class="flash success alert-box radius">'
                    +"Your Username has been changed."+
                    '<a href="#" class="close">×</a></div>');
              },
                error: function(xhr) {
                  $(".eds__flash").html('<div data-alert class="flash notice alert-box radius">'
                    +"Username change failed. "+ "<%= user.errors.full_messages.join('. ') %>"+
                    '<a href="#" class="close">×</a></div>');

              }
           });
        });
      nameAction.innerHTML = 'Edit';
      usernameField.disabled = true;
  }
};




