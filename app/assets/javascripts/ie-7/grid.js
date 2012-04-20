$(window).resize(function() {
	winWidth = $(window).width();
	var gridColCount = Math.floor(winWidth/292);
	var gridWidth = (gridColCount * 292);
	if(gridWidth <= 970) {
		$("#grid_container_large").width(970);
	} else {
		$("#grid_container_large").width(gridWidth);
	}
})

$(document).ready(function() {
	winWidth = $(window).width();
	var gridColCount = Math.floor(winWidth/292);
	var gridWidth = (gridColCount * 292);
	$("#grid_container_large").width(gridWidth);
})

$(document).ready(function() {
	winWidth = $(window).width();
	var comColCount = Math.floor(winWidth/242);
	var comWidth = (comColCount * 242);
	$(".community_grid_container").width(comWidth);
});

$(document).ready(function() {
	windowWidth = $(window).width();
	winWidth = windowWidth - 243
	var userColCount = Math.floor(winWidth/242);
	var userWidth = (userColCount * 242);
	$(".user_grid_container").width(userWidth);
})

$(document).ready(function() {
	windowWidth = $(window).width();
	winWidth = windowWidth - 243
	var friendColCount = Math.floor(winWidth/212);
	var friendWidth = (friendColCount * 212);
	$("#friend_container").width(friendWidth);
})

$(document).ready(function() {
	$("img.lazy").lazyload({
		effect: "fadeIn",
		failure_limit: 50
	});
	$("img.lazy_load").lazyload({
		event: "load",
		effect: "fadeIn",
		failure_limit: 50
	});
	var container = $("#grid_container");
	container.imagesLoaded(function() {
		container.masonry({
			itemSelector: ".box_deal",
			isAnimated: true,
			isFitWidth: true,
			animationOptions: {
				duration: 200
			}
		})
	});
	var container_large = $("#grid_container_large");
	container_large.imagesLoaded(function() {
		container_large.masonry({
			itemSelector: ".box_deal_large",
			isAnimated: true,
			animationOptions: {
				duration: 200
			}
		})
	});
	var container_friend = $("#friend_container");
	container_friend.imagesLoaded(function() {
		container_friend.masonry({
			itemSelector: ".box_friend",
			isAnimated: true,
			isFitWidth: true,
			animationOptions: {
				duration: 200
			}
		})
	})
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
	
	$(".categories_signup").click(function() {
		$("#grid_categories_list").hide(0, function() {
			$("#dim_signup").fadeIn(200);
		});
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
	$(".box_deal_large_share").hide();
};

function showBoxFriendAction(id) {
	var i = id
	$(".box_friend_add_"+i).show();
};

function hideBoxFriendAction() {
	$(".box_friend_add").hide();
};