function displayMenu() {
  var menu = document.getElementById("mobileMenu");
  menu.style.height = menu.style.height === "0%" ? "100%" : "0%";
}

function closeMenu() {
  document.getElementById("mobileMenu").style.display = "0";
}

function changeBurger(x) {
  x.classList.toggle("change");
  displayMenu();
}
