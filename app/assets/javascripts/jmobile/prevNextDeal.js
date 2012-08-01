$(document).on('pageinit', function() {
	var prev = $('.contentWrapper:last .prevDeal');
	var px1 = -40;
	var py1 = prev.offset().top;
	var px2 = 0;
	var py2 = py1 - 100;
	prev.draggable({
		axis: "x",
		containment: [px1, py1, px2, py2]
	});
	prev.on('dragstop', function() {
		$(this).css("left", "-40px");
	});
	prev.on('drag', function() {
		if ($(this).offset().left == 0) {
			var prev = $('.contentWrapper:last .pagination a.previous_page');
			var prevDeal = $('.contentWrapper:last .prevDeal');
			if (prevDeal.length > 0) {
				var prevDealUrl = prevDeal.attr('href');
				$.mobile.changePage(prevDealUrl, { transition: "slide", reverse: true });
			}
		}
	})
/*	
	var next = $('.contentWrapper:last .nextDeal');
	var left = next.offset().left;
	var nx1 = left + 7;
	var ny1 = next.offset().top;
	var nx2 = nx1 + 40;
	var ny2 = ny1 - 100;
	next.draggable({
		axis: "x",
		containment: [nx1, ny1, nx2, ny2]
	})
	alert(next.outerWidth())
*/
});