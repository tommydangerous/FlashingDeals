// Hide Reply button 

$(document).ready(function() {
	$(document).click(function() {
		$('div.reply').hide();
	});
	$('textarea.subcomment_textarea').click(function() {
		return false;
	});
	$('textarea.subcomment_textarea_2').click(function() {
		return false;
	});
	$('a.reply_link').click(function() {
		return false;
	});
});