$(document).ready(function() {
	var x = $("#flashmob_deals");
	var y = $("div#category_drop_down");
	x.mouseover(function() {
		y.show();
	});
	$(document).mouseover(function() {
		y.hide();
	})
	x.mouseover(function() {
		return false;
	})
	y.mouseover(function() {
		return false;
	})
	
	var catWay = $('#categoriesWaypoint');
	var catBar = $('#categoriesBar');
	catWay.waypoint(function(event, direction) {
		if (direction == 'down') {
			catBar.addClass("fixed");
		}
	})
	catWay.waypoint(function(event, direction) {
		if (direction == 'up') {
			catBar.removeClass("fixed");
		}
	})
})