function setHeight() {
	var h =	$("div#deal_show_overlay_container").height();
	var o = $(".overlayOuter").height();
	var l = $(".overlay_left");
	var r = $(".overlay_right");
	var i = $(".overlayInner");
	var b = $(".overlay_bottom");
	var nh = (h + 42)
	var fs = $("#fs_wrapper").height();
	l.height(h + 22)
	r.height(h + 22)
	i.height(h + 22)
	if(o > nh) {
		b.height(o - nh)
	} else {
		b.height("0")
	}
};

function setWidth() {
	var w = $(".overlay_top").width()
	var nw = (w - 989)/2
	var l = $(".overlay_left");
	var r = $(".overlay_right");
	if(l.width != nw) {
		l.width(nw);
	}
	if(r.width != nw) {
		r.width(nw);
	}
};

$(function() {
	$(".overlay_top").click(function() {
		$(".overlayOuter").hide();
		$("body").removeClass("stationary");
		$(".box_image").show()
	})
	$(".overlay_left").click(function() {
		$(".overlayOuter").hide();
		$("body").removeClass("stationary");
		$(".box_image").show()
	})
	$(".overlay_right").click(function() {
		$(".overlayOuter").hide();
		$("body").removeClass("stationary");
		$(".box_image").show()
	})
	$(".overlay_bottom").click(function() {
		$(".overlayOuter").hide();
		$("body").removeClass("stationary");
		$(".box_image").show()
	})
});

function hideOverlayOuter() {
	$(".overlayOuter").hide();
	$("body").removeClass("stationary");
	$(".box_image").show()
};

function setPNOHeight() {
	var h = $("div#deal_show_overlay_container").height();
	var p = $("a#previous_deal_overlay");
	var n = $("a#next_deal_overlay");
	var x = ((h + 22)/2) - 35
	var y = ((h + 22)/2) + 35
	p.css("top", x)
	n.css("top", x)
	$("div#previous_top").height(x);
	$("div#next_top").height(x);
	$("div#previous_bottom").height(x);
	$("div#next_bottom").height(x);
	$("div#previous_bottom").css("top", y)
	$("div#next_bottom").css("top", y)
	$("#previous_arrow_overlay").fadeIn(300);
	$("#next_arrow_overlay").fadeIn(300);
}