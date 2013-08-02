$( document ).ready(function() {

  $("#preso").bind("showoff:loaded", function (event) {
    munge_footer();
    $(".content").bind("showoff:show", function (event) {
      munge_footer();
    });
  });


});

function munge_footer() {
  percent = getSlidePercent();
  $('.bar').css('width',percent + '%');
}
