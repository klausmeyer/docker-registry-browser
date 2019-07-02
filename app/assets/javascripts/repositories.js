$(document).on("turbolinks:load", function() {
  $("#delete_confirm").on("keyup", function(e) {
    e.preventDefault();

    var field = $(this);
    var button = $("#delete-button");

    if(field.val() == field.attr("data-expected")) {
      button.removeClass("disabled");
    }
    else {
      button.addClass("disabled");
    }
  });

  $("[data-copy-target]").on("click", function(e) {
    e.preventDefault();

    var $icon = $(this);
        $icon.data("origin-title", $icon.data("original-title"));
    var $target = $icon.parent().parent().find( $icon.data("copy-target") );

    $target.select();
    document.execCommand("copy");

    // microcopy
    $icon.prop("title", "Copied").tooltip('_fixTitle').tooltip('show');
    setTimeout(function(){ $icon.prop("title", $icon.data("origin-title")).tooltip('_fixTitle').tooltip('hide'); $target.blur(); }, 3000);

    return false;
  });

  $(".js-copy-to-clipboard").find("input").on("focus", function() {
    $(this).parent().next().find("a[data-copy-target]").click();
  });

  $("[data-copy]").on("click", function(e) {
    e.preventDefault();

    var $icon = $(this);
        $icon.data("origin-title", $icon.data("original-title"));
    var $target = $("<input />");
        $("body").append($target);

    var text = $(this).data("copy")
        $target.val(text)

    $icon.prop("title", "Copied").tooltip('_fixTitle').tooltip('show');
    setTimeout(function(){ $icon.prop("title", $icon.data("origin-title")).tooltip('_fixTitle').tooltip('hide'); }, 3000);

    $target.select();
    document.execCommand("copy");
    $target.remove();

    return false;
  });

});
