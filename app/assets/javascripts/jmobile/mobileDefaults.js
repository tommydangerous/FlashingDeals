$(document).bind("mobileinit", function() {
	$.mobile.loadingMessage = false;
	$.mobile.defaultPageTransition = 'none';
	$.support.touchOverflow = true;
	$.mobile.touchOverflowEnabled = true;
	$.event.special.swipe.durationThreshold = 1000;
	$.event.special.swipe.horizontalDistanceThreshold = 60;
	$.event.special.swipe.verticalDistanceThreshold = 20;
})