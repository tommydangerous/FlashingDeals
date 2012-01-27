$(function() {
	$("#sortable_name a, #sortable_price a, #sortable_posted a, #sortable_view a, #sortable_click a, #deals .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});
	$("#deals_search").submit(function() {
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});