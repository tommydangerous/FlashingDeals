$(document).bind("mobileinit", function() {
	$.mobile.loadingMessage = false;
	$.mobile.defaultPageTransition = 'none';
	$.event.special.swipe.horizontalDistanceThreshold = "30";
	$.event.special.swipe.verticalDistanceThreshold = "30";
})