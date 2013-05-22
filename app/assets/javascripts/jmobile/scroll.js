/*
$(document).on('pageinit', function() {
	$(document).live('pagebeforeload', function() {
		$('.contentWrapper:last').data('swipe-start', null);
	});
	
	$('.contentWrapper:last').live('vmousedown', function(event) {
		duration = 0;
		counter = setInterval(function() {
			duration++;
		}, 1);
		$(this).data('swipe-start', { x: event.pageX, y: event.pageY });
	})
	$('.contentWrapper:last').live('vmouseup', function(event) {
		$(this).data('swipe-start', null);
		clearInterval(counter);
	})
	$('.contentWrapper:last').live('vmousemove', function(event) {
		if ($(this).data('swipe-start') != null) {
			var distanceX = $(this).data('swipe-start').x - event.pageX;
			var distanceY = $(this).data('swipe-start').y - event.pageY;
			var distanceT = Math.sqrt(Math.pow(Math.abs($(this).data('swipe-start').x - event.pageX), 2) + Math.pow(Math.abs($(this).data('swipe-start').y - event.pageY), 2));
			if (distanceT > 100) {
				if(distanceX > 0 && distanceX < 50 && distanceY > 0) {
					if (duration <= 50) {
						var scrollPos = $(window).scrollTop();
						var distance = $(document).height();
						$.mobile.silentScroll(scrollPos + distance);
					}
				}
				else if (distanceX > 0 && distanceX < 50 && distanceY < 0) {
					$('#counter').html(duration);
					if (duration <= 50) {
						var scrollPos = $(window).scrollTop();
						var distance = 1000/duration;
						$.mobile.silentScroll(scrollPos - distance);
					}
				}
				$(this).data('swipe-start', { x: event.pageX, y: event.pageY });
			}
		}
	})
})
*/