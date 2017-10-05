$(document).on("turbolinks:load", function() {
  $("#delete_confirm").on("keyup", function(e) {
    e.preventDefault();

    var field = $(this);
    var button = $("#delete-button");

    if(field.val() == field.data("expected")) {
      button.removeClass("disabled");
    }
    else {
      button.addClass("disabled");
    }
  });

  $("*[data-behaviour=copy-pull-command]").on("click", function(e) {
    e.preventDefault();

    var $link = $(this);
    var $input = $("input[type=text]", $link.closest(".input-group"));

    $input.select();
    document.execCommand("copy");
    $input.unselect();

    return false;
  });
});
