$(document).on('pageinit', function() {
	// swipe left and swipe right on deal list page or deal show page
	$('.dealShowContent').on('swipeleft swiperight', function(event) {
		if (event.type == 'swiperight') {
			event.stopImmediatePropagation();
			var prevDeal = $('.contentWrapper:last .prevDeal');
			if (prevDeal.length > 0) {
				var prevDealUrl = prevDeal.attr('href');
				$.mobile.changePage(prevDealUrl);
				if ($('.contentWrapper').length == 1) {
					var spinner = new Spinner().spin();
					$('.contentWrapper .spinner').html(spinner.el);
					$('.contentWrapper #dealShow').toggle();
					$('.contentWrapper #dealLoading').toggle();
				}
				else {
					$('.contentWrapper:last #dealShow').hide();
					$('.contentWrapper:last #dealLoading').show();
					$(window).scrollTop(0);
				}
			}
		}
		else if (event.type == 'swipeleft') {
			event.stopImmediatePropagation();
			var nextDeal = $('.contentWrapper:last .nextDeal');
			if (nextDeal.length > 0) {
				var nextDealUrl = nextDeal.attr('href');
				$.mobile.changePage(nextDealUrl);
				if ($('.contentWrapper').length == 1) {
					var spinner = new Spinner().spin();
					$('.contentWrapper .spinner').html(spinner.el);
					$('.contentWrapper #dealShow').toggle();
					$('.contentWrapper #dealLoading').toggle();
				}
				else {
					$('.contentWrapper:last #dealShow').hide();
					$('.contentWrapper:last #dealLoading').show();
					$(window).scrollTop(0);
				}
			}
		}
	})
})