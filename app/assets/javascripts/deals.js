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