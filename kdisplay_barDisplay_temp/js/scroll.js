$(function(){

	$("a[href^=#]").click(function() {
	  var speed = 500;
	  var nav_height = 48;
	  var href= $(this).attr("href");
	  var target = $(href == "#" || href == "" ? "html" : href + " h1");
	  var position = target.offset().top - nav_height;

      $("#luxbar-checkbox").prop("checked", false);
	  $("body,html").animate({scrollTop: position}, speed, "swing");
	  return false;

	});

});
