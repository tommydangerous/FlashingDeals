// remove overlay link
$(document).ready(function() {
	$('.box_deal_link_overlay_none').remove();
	$('.returnFalse').live('click', function() {
		return false;
	})
});

function showBoxDealCommentForm(id) {
	var i = id
	$("#box_deal_comment_form_"+i).toggle();
	$("#box_deal_comment_form_"+i+" textarea").focus();
	$("#grid_container_large").masonry({
		itemSelector: ".box_deal_large",
		isFitWidth: true,
	})
	$("#grid_container").masonry({
		itemSelector: ".box_deal",
		isFitWidth: true,
	})
}