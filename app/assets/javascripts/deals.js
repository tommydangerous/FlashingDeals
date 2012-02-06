$(function() {
	$("#sort a, #deals .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	$("#deals_search input").keyup(function() {
		$.get($("#deals_search").attr("action"), $("#deals_search").serialize(), null, "script");
		return false;
	});
	
/*	$("#deals_search").submit(function() {
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	}); */
	
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
	$('div#info').toggle();
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