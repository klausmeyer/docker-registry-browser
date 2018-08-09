$(document).on("turbolinks:load", function() {
  // bootstrap tooltips
  $('[data-toggle="tooltip"]').tooltip();

  // bootstrap popover
  $('[data-toggle="popover"]').popover();
});
