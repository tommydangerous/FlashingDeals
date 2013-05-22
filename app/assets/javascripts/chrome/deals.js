// Box deal
function removeUnclicked(id) {
	$('#box_deal_'+id).removeClass('deal_unclicked');
	$('#box_deal_'+id).addClass('deal_clicked');
}

function addUnclicked() {
	$('.box_deal').addClass('deal_unclicked');
	$('.box_deal').removeClass('deal_clicked');
}

// Top Deals
function showLightning(id) {
	var i = id
	$('div#deal_'+i).fadeIn(200);
};

function hideLightning() {
	$('div.show_lightning').hide();
};

function adjustBoxImage1() {
	var i = $("div#home_deal_four:nth-child(1) img.top_deal_image").attr("id")
	var h = $("img#"+i).height();
	var x = (150 - h)/2
	$("img#"+i).css("top", x+"px")
};

function adjustBoxImage2() {
	var i = $("div#home_deal_four:nth-child(2) img.top_deal_image").attr("id")
	var h = $("img#"+i).height();
	var x = (150 - h)/2
	$("img#"+i).css("top", x+"px")
};

function adjustBoxImage3() {
	var i = $("div#home_deal_four:nth-child(3) img.top_deal_image").attr("id")
	var h = $("img#"+i).height();
	var x = (150 - h)/2
	$("img#"+i).css("top", x+"px")
};

function adjustBoxImage4() {
	var i = $("div#home_deal_four:nth-child(4) img.top_deal_image").attr("id")
	var h = $("img#"+i).height();
	var x = (150 - h)/2
	$("img#"+i).css("top", x+"px")
};

function adjustBoxName1() {
	var i = $("div#home_deal_four:nth-child(1) div.box_name_four p.top_deal_name").attr("id")
	var h = $("p#"+i).height();
	var x = (150 - h)/2
	$("p#"+i).css("top", x+"px")
}

function adjustBoxName2() {
	var i = $("div#home_deal_four:nth-child(2) div.box_name_four p.top_deal_name").attr("id")
	var h = $("p#"+i).height();
	var x = (150 - h)/2
	$("p#"+i).css("top", x+"px")
}

function adjustBoxName3() {
	var i = $("div#home_deal_four:nth-child(3) div.box_name_four p.top_deal_name").attr("id")
	var h = $("p#"+i).height();
	var x = (150 - h)/2
	$("p#"+i).css("top", x+"px")
}

function adjustBoxName4() {
	var i = $("div#home_deal_four:nth-child(4) div.box_name_four p.top_deal_name").attr("id")
	var h = $("p#"+i).height();
	var x = (150 - h)/2
	$("p#"+i).css("top", x+"px")
}

// Deal Show Page
function adjustImage() {
	var h = $('img#deal_image').height();
	var x = (250 - h)/2
	$('img#deal_image').css("top", x+"px")
};

function showCouponPopup() {
	$("div#coupon_popup").fadeIn(100);
}

function hideCouponPopup() {
	$("div#coupon_popup").hide();
}

// Ajax Sortables, pagination, search, and electric flashing sort
$(function() {
	$("#sort a, #deals .pagination a, #electric_flashing a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	$("#deals_search input").keyup(function() {
		$.get($("#deals_search").attr("action"), $("#deals_search").serialize(), null, "script");
		return false;
	});
	$("#deals_search").submit(function() {
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});

// The Queue
function toggleQueueEdit(id) {
	var i = id
	$("div#queue_edit_"+i).toggle();
};

// Rising Deals
function toggleRisingDealEdit(id) {
	var i = id
	$("div#rising_deal_edit_"+i).toggle();
};

// Deal Show Edit Info
function toggleInfoEditForm() {
	$('div#info_edit_the_flash').toggle();
	$('div#deal_show_info').toggle();
	if ($('div#info_edit_the_flash').css("display") == "none") {
		$('span#edit_the_flash a').html("Edit");
	} else {
		$('span#edit_the_flash a').html("Hide");
	};
};

$(document).ready(function() {
	$('div#queue_list').sortable({
		axis: 'y',
		update: function(event, ui) {
			$.post($(this).data('update-url'), $(this).sortable('serialize'))
		}
	});
});

// Toggle Electric Deals and/or Flashing Deals
function toggleDealsElectric() {
	var n = $("div.deal_nothing");
	var e = $("div.deal_electric");
	var f = $("div.deal_flashing");
	if (e.length == 0) {
		$("div.deal_single").show();
	} else if (n.css("display") != "none" && e.css("display") != "none" && f.css("display") != "none") {
		n.hide();
		f.hide();
	} else if (n.css("display") == "none" && e.css("display") != "none" && f.css("display") == "none") {
		n.show();
		f.show();
	} else if (n.css("display") == "none" && e.css("display") == "none" & f.css("display") != "none") {
		e.show();
		f.hide();
	} else if (n.css("display") == "none" && e.css("display") != "none") {
		n.show();
	}
};

function toggleDealsFlashing() {
	var n = $("div.deal_nothing");
	var e = $("div.deal_electric");
	var f = $("div.deal_flashing");
	if (f.length == 0) {
		$("div.deal_single").show();
	} else if (n.css("display") != "none" && e.css("display") != "none" && f.css("display") != "none") {
		n.hide();
		e.hide();
	} else if (n.css("display") == "none" && e.css("display") == "none" && f.css("display") != "none") {
		n.show();
		e.show();
	} else if (n.css("display") == "none" && e.css("display") != "none" & f.css("display") == "none") {
		e.hide();
		f.show();
	} else if (n.css("display") == "none" && f.css("display") != "none") {
		n.show();
	}
};