// Add target _blank to links in the deal show info when document loads
$(document).on('pageinit', function() {
	$('.dealShowInfoLink a').attr("target", "_blank");
})
$(document).on("pageload", function() {
	$('.dealShowInfoLink a').attr("target", "_blank");
});