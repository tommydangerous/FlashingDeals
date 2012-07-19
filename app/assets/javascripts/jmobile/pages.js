$(document).on('pageinit', function() {
	// pagination slide transitions
	$('.pagination a').attr('data-transition', 'slide');
	$('.pagination:last .previous_page').on('click', function() {
		var x = $('.pagination:last a[rel=prev]:last').attr('href');
		$.mobile.changePage(x, { transition: 'slide', reverse: true });
		return false;
	})
	// load more deals when scrolling
	$(window).scroll(function() {
		var next = $('.contentWrapper:last .pagination a.next_page').attr('href');
		if (next && $(window).scrollTop() > $(document).height() - $(window).height() - 200) {
			$('.contentWrapper:last .endlessPagination').replaceWith("<div class='loadingMoreDeals'>Loading More Deals...</div>");
			if ($('.contentWrapper:last .rootPage').length > 0) {
				$.ajax({
					url: next + "&mobilejs=true&format=mobilejs",
					dataType: "script"
				})
			}
			else {
				var fullPath = next.split(".mobile?page=")[0];
				var pageNum = next.split(".mobile?page=")[1];
				$.ajax({
					url: fullPath + "?page=" + pageNum + "&mobilejs=true&format=mobilejs",
					dataType: "script"
				})
			}
		}
	})
})