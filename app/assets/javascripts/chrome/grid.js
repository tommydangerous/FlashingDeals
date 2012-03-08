$(function() {
	var container = $("#grid_container");
	container.imagesLoaded(function() {
		container.masonry({
			itemSelector: ".box_deal",
			gutterWidth: 20,
			isAnimated: true,
			isFitWidth: true,
			animationOptions: {
				duration: 200
			}
		}).masonry('reloadItems')
	});
	$("img.lazy").lazyload({
		effect: "fadeIn"
	});
});

$(document).ready(function() {
	var x = $('#grid_categories_show');
	var z = $('#grid_categories_list');
	$(document).click(function() {
		z.hide(0);
	});
	x.click(function() {
		return false;
	});
	x.click(function() {
		if (z.is(':visible')) {
			z.hide(0);
		} else {
		z.show(0);
		};
	});
	
	$("#back_to_the_top").click(function() {
		$("html, body").animate({ scrollTop: 0 }, 100);
		$("#back_to_the_top_container").hide();
	});
	
	$(window).scroll(function() {
		if( $(window).scrollTop() > $(window).height() * 1 )
			$("#back_to_the_top_container").show();
		else
			$("#back_to_the_top_container").hide();
		});
});

function showBoxDealShare(id) {
	var i = id
	$("#box_deal_share_"+i).show();
};

function hideBoxDealShare() {
	$(".box_deal_share").hide();
};