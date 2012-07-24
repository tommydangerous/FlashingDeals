// make all anchors in #deal_show_info have attribute target = _blank
$(document).ready(function() {
	$('#deal_show_info a').attr("target", "_blank");
});

function setPreviousNextHeight() {
	var h = $("#deal_show_container").height();
	$("#previous_deal").height(h);
	$("#next_deal").height(h);
};
/*
$(document).ready(function() {
	$("#previous_deal").mouseover(function() {
		$("#previous_arrow").show();
	});
	$("#previous_deal").mouseout(function() {
		$("#previous_arrow").hide();
	});
	$("#next_deal").mouseover(function() {
		$("#next_arrow").show();
	});
	$("#next_deal").mouseout(function() {
		$("#next_arrow").hide();
	});
})

$(document).ready(function() {
	$("#previous_deal").mouseover(function(e) {
		$("#previous_arrow").css("top", (e.pageY - 100));
	});
	$("#next_deal").mouseover(function(e) {
		$("#next_arrow").css("top", (e.pageY - 100));
	});
});
*/