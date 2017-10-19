
function displayMenu() {
  menuDiv = document.getElementById("mobileMenu")

  if (menuDiv.style.height === "0%") {
      menuDiv.style.height = "100%";
  } else {
      menuDiv.style.height = "0%";
  }
}

function closeMenu() {
  document.getElementById("mobileMenu").style.display = "0";
}

function changeBurger(x) {
  x.classList.toggle("change");
  displayMenu();
}
