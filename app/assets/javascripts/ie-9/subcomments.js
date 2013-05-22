$(document).ready(function() {
	// Hide Reply button 
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

// show reply button
function showReply(id) {
	var i = id
	$('div#reply_'+i).show();
	$('div#subcomment_gravatar_'+i).show();
	$('textarea#reply_'+i).css("width", "392px");
};

function focusSubcomment(id) {
	var i = id
	$('textarea#reply_'+i).focus();
};

function showSubcommentForm(id) {
	var i = id
	$('div#hidden_subcomment_form_'+i).show();
	$('textarea#reply_'+i).focus();
};