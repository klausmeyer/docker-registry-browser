$(document).on("ready page:load", function() {
  $("#delete_confirm").on("keyup", function(e) {
    var field = $(this);
    var button = $("#delete-button");
    if(field.val() == field.data("expected")) {
      button.removeClass("disabled");
    }
    else {
      button.addClass("disabled");
    }
    e.preventDefault();
  });
});