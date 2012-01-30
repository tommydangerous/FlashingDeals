$(function() {
	$("#sort a, #deals .pagination a").live("click", function() {
		$.getScript(this.href);
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