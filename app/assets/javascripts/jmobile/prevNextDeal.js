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
		$(this).css("background", "rgba(150, 150, 150, 0.5)");
	});
	prev.on('drag', function() {
		if ($(this).offset().left == 0 && !$(this).hasClass("dragDisable")) {
			$(this).addClass("dragDisable");
			$(this).css("background", "rgba(150, 150, 150, 0.5)");
			$('.contentWrapper:first .nextArrow').removeClass("dragDisable");
			var prevDeal = $('.contentWrapper:last .prevDeal');
			if (prevDeal.length > 0) {
				$.mobile.changePage(prevDeal.attr('href'));
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
			};
		};
	});
	prev.on('drag', function() {
		if ($(this).offset().left >= -10) {
			$(this).css("background", "rgba(150, 150, 150, 0.1)");
		}
		else if ($(this).offset().left >= -20) {
			$(this).css("background", "rgba(150, 150, 150, 0.2)");
		}
		else if ($(this).offset().left >= -30) {
			$(this).css("background", "rgba(150, 150, 150, 0.3)");
		}
		else if ($(this).offset().left >= -40) {
			$(this).css("background", "rgba(150, 150, 150, 0.4)");
		}
	});
	// Next Deal
	var next = $('.contentWrapper:last .nextArrow');
	if (next.length > 0) {
		var nx1 = window.innerWidth - 58;
		var ny1 = next.offset().top;
		var nx2 = nx1 + 50;
		var ny2 = ny1 - 100;
		next.draggable({
			axis: "x",
			containment: [nx1, ny1, nx2, ny2]
		});
	};
	$(window).on('resize', function() {
		var left = window.innerWidth - 8;
		next.css("left", left);
		if (next.length > 0) {
			var nx1 = window.innerWidth - 58;
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
		var left = window.innerWidth - 8;
		next.css("left", left);
		if (next.length > 0) {
			var nx1 = window.innerWidth - 58;
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
		var left = window.innerWidth - 8;
		$(this).css("left", left);
		$(this).css("background", "rgba(150, 150, 150, 0.5)");
	})
	next.on('drag', function() {
		var nx1 = window.innerWidth - 58;
		if ($(this).offset().left == nx1 && !$(this).hasClass("dragDisable")) {
			$(this).addClass("dragDisable");
			$(this).css("background", "rgba(150, 150, 150, 0.5)");
			$('.contentWrapper:first .prevArrow').removeClass("dragDisable");
			var nextDeal = $('.contentWrapper:last .nextDeal');
			if (nextDeal.length > 0) {
				$.mobile.changePage(nextDeal.attr('href'))
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
	next.on('drag', function() {
		if ($(this).offset().left <= window.innerWidth - 48) {
			$(this).css("background", "rgba(150, 150, 150, 0.1)");
		}
		else if ($(this).offset().left <= window.innerWidth - 38) {
			$(this).css("background", "rgba(150, 150, 150, 0.2)");
		}
		else if ($(this).offset().left <= window.innerWidth - 28) {
			$(this).css("background", "rgba(150, 150, 150, 0.3)");
		}
		else if ($(this).offset().left <= window.innerWidth - 18) {
			$(this).css("background", "rgba(150, 150, 150, 0.4)");
		}
	});
});