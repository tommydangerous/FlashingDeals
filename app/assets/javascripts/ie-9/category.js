$(document).ready(function() {
	var x = $("#category_deals");
	var y = $("#category_drop_down");
	x.click(function() {
		y.show();
	});
	$(document).click(function() {
		y.hide();
	})
	x.click(function() {
		return false;
	})
})