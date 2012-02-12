$(document).ready(function() {
	$("div#progress")
		.hide()
		.ajaxStart(function() {
			$(this).show();
		})
		.ajaxStop(function() {
			$(this).hide();
		});
});