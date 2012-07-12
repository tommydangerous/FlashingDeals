$(document).on('pageinit', function() {
	// Add target _blank to links in the deal show info when document loads
	$('.dealShowInfoLink a').attr("target", "_blank");
})

$(document).on("pageload", function() {
	// Add target _blank to links in the deal show info when new page loads
	$('.dealShowInfoLink a').attr("target", "_blank");
});