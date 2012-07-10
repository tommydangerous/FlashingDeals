$(document).ready(function() {
	$('#backLink').live("tap", function() {
		parent.history.back();
		return false;
	})
})