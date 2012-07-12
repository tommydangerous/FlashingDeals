$(document).on('pageinit', function() {
	// pagination slide transitions
	$('.pagination a').attr('data-transition', 'slide');
	$('.pagination:last .previous_page').on('click', function() {
		var x = $('.pagination:last a[rel=prev]:last').attr('href');
		$.mobile.changePage(x, { transition: 'slide', reverse: true });
		return false;
	})
})