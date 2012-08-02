$(document).on('pageinit', function() {
	// Previous Deal
	var prev = $('.contentWrapper:last .prevArrow');
	if (prev.length > 0) {
		var px1 = -50;
		var py1 = prev.offset().top;
		var px2 = 0;
		var py2 = py1 - 100;
		prev.draggable({
			axis: "x",
			containment: [px1, py1, px2, py2]
		});
	}
	prev.on('dragstop', function() {
		$(this).css("left", "-50px");
		$(this).css("background", "rgba(150, 150, 150, 0.7)");
	});
	prev.on('drag', function() {
		if ($(this).offset().left == 0 && !$(this).hasClass("dragDisable")) {
			$(this).addClass("dragDisable");
			$(this).css("background", "rgba(150, 150, 150, 0.7)");
			$('.contentWrapper:first .nextArrow').removeClass("dragDisable");
			var prevDeal = $('.contentWrapper:last .prevDeal');
			if (prevDeal.length > 0) {
				$.mobile.changePage(prevDeal.attr('href'));
			};
		};
	});
	prev.on('drag', function() {
		if ($(this).offset().left >= -10) {
			$(this).css("background", "rgba(150, 150, 150, 0.38)");
		}
		else if ($(this).offset().left >= -20) {
			$(this).css("background", "rgba(150, 150, 150, 0.46)");
		}
		else if ($(this).offset().left >= -30) {
			$(this).css("background", "rgba(150, 150, 150, 0.54)");
		}
		else if ($(this).offset().left >= -40) {
			$(this).css("background", "rgba(150, 150, 150, 0.62)");
		}
	});
	// Next Deal
	var next = $('.contentWrapper:last .nextArrow');
	if (next.length > 0) {
		var nx1 = window.innerWidth - 57;
		var ny1 = next.offset().top;
		var nx2 = nx1 + 50;
		var ny2 = ny1 - 100;
		next.draggable({
			axis: "x",
			containment: [nx1, ny1, nx2, ny2]
		});
	};
	$(window).on('resize', function() {
		var left = window.innerWidth - 7;
		next.css("left", left);
		if (next.length > 0) {
			var nx1 = window.innerWidth - 57;
			var ny1 = next.offset().top;
			var nx2 = nx1 + 50;
			var ny2 = ny1 - 100;
			next.draggable({
				axis: "x",
				containment: [nx1, ny1, nx2, ny2]
			});
		};
	})
	$(window).on('orientationchange', function() {
		var left = window.innerWidth - 7;
		next.css("left", left);
		if (next.length > 0) {
			var nx1 = window.innerWidth - 57;
			var ny1 = next.offset().top;
			var nx2 = nx1 + 50;
			var ny2 = ny1 - 100;
			next.draggable({
				axis: "x",
				containment: [nx1, ny1, nx2, ny2]
			});
		};
	})
	next.on('dragstop', function() {
		var left = window.innerWidth - 7;
		$(this).css("left", left);
		$(this).css("background", "rgba(150, 150, 150, 0.7)");
	})
	next.on('drag', function() {
		var nx1 = window.innerWidth - 57;
		if ($(this).offset().left == nx1 && !$(this).hasClass("dragDisable")) {
			$(this).addClass("dragDisable");
			$(this).css("background", "rgba(150, 150, 150, 0.7)");
			$('.contentWrapper:first .prevArrow').removeClass("dragDisable");
			var nextDeal = $('.contentWrapper:last .nextDeal');
			if (nextDeal.length > 0) {
				$.mobile.changePage(nextDeal.attr('href'))
			}
		}
	})
	next.on('drag', function() {
		if ($(this).offset().left <= window.innerWidth - 47) {
			$(this).css("background", "rgba(150, 150, 150, 0.38)");
		}
		else if ($(this).offset().left <= window.innerWidth - 37) {
			$(this).css("background", "rgba(150, 150, 150, 0.46)");
		}
		else if ($(this).offset().left <= window.innerWidth - 27) {
			$(this).css("background", "rgba(150, 150, 150, 0.54)");
		}
		else if ($(this).offset().left <= window.innerWidth - 17) {
			$(this).css("background", "rgba(150, 150, 150, 0.62)");
		}
	});
});