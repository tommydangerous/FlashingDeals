/*
$(document).on('pageinit', function() {
	// swipe left and swipe right on deal list page or deal show page
	$('.dealShowContent').on('swipeleft swiperight', function(event) {
		if (event.type == 'swipeleft') {
			event.stopImmediatePropagation();
			var next = $('.contentWrapper:last .pagination a.next_page');
			var nextDeal = $('.contentWrapper:last .nextDeal');
			if (next.length > 0) {
				var nurl = next.attr('href');
				$.mobile.changePage(nurl, { transition: "slide" });
			}
			if (nextDeal.length > 0) {
				var nextDealUrl = nextDeal.attr('href');
				$.mobile.changePage(nextDealUrl, { transition: "slide" });
			}
		}
		else if (event.type == 'swiperight') {
			event.stopImmediatePropagation();
			var prev = $('.contentWrapper:last .pagination a.previous_page');
			var prevDeal = $('.contentWrapper:last .prevDeal');
			if (prev.length > 0) {
				var purl = prev.attr("href");
				$.mobile.changePage(purl, { transition: "slide", reverse: true });
			}
			if (prevDeal.length > 0) {
				var prevDealUrl = prevDeal.attr('href');
				$.mobile.changePage(prevDealUrl, { transition: "slide", reverse: true });
			}
		}
	})
})
*/