$(document).ready(function() {
	$("#my_points").mouseover(function() {
		$("#my_points_next_level").fadeIn(200);
	})
	$(document).mouseover(function() {
		$("#my_points_next_level").fadeOut(100);
	})
	$("#my_points").mouseover(function() {
		return false;
	})
})

function showPointsPopup(points) {
	var x = $("#points_popup_normal");
	var i = points
	x.hide();
	x.delay(300);
	x.fadeIn(200);
	x.delay(3000);
	x.fadeOut(100);
	$(".points_earned").text(i);
}

function showLeveledUp(title) {
	var x = $("#leveled_up_normal");
	var i = title
	x.hide();
	x.delay(300);
	x.fadeIn(200);
	x.delay(3000);
	x.fadeOut(100);
	$(".leveled_up_to").text(i);
}

$(document).ready(function() {
	$(".share_points").click(function() {
		var x = $("#points_popup_normal");
		x.hide();
		x.delay(10000);
		x.fadeIn(200);
		x.delay(3000);
		x.fadeOut(100);
		$(".points_earned").text("50");
	})
})