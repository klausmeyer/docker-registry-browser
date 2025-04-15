import "@hotwired/turbo-rails"
import "bootstrap"
import $ from "jquery"

// Auto select light or dark theme

; (function () {
  const htmlElement = document.querySelector("html")
  if (htmlElement.getAttribute("data-bs-theme") === "auto") {
    function updateTheme() {
      document.querySelector("html").setAttribute("data-bs-theme",
        window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light")
    }
    window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", updateTheme)
    updateTheme()
  }
})()

// Delete tag button

$(document).on("turbo:load", function () {
  $("#delete_confirm").on("keyup", function(event) {
    event.preventDefault();

    var field = $(this);
    var button = $("#delete-button");

    if (field.val() == field.attr("data-expected")) {
      button.removeClass("disabled");
    }
    else {
      button.addClass("disabled");
    }
  });
});
