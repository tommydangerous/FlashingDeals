$(document).bind("mobileinit", function() {
	$.mobile.loadingMessage = false;
	$.mobile.defaultPageTransition = 'none';
	$.event.special.swipe.horizontalDistanceThreshold = "150";
	$.event.special.swipe.verticalDistanceThreshold = "20";
	$.event.special.swipe.durationThreshold = "500";
})