$(document).bind('pageinit', function() {
	$('#loadMore').live("click", function() {
		$.ajax({
			type: "GET",
			url: "/assets/jmobile/test.js",
			dataType: "script"
		})
	});
})