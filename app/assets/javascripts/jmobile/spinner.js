$(document).on('pageinit', function() {
	var spinner = new Spinner().spin();
	$('.spinner').append(spinner.el);
})