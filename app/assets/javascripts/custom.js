// Users
function showJoined(id) {
	var i = id
	$("div#user_"+i).show();
}

function hideJoined(id) {
	var i = id
	$("div#user_"+i).hide();
}

function toggleMostRecentActivity(id) {
	var i = id
	$("div.most_recent_activity_"+id).toggle();
};

// Feedback
$(document).ready(function() {
	$('a#feedback').click(function() {
		$('div#feedback_form').slideToggle();
	});
});

// Messages
function showMessagesMore() {
	$('a#show_messages_more').hide();
	$('div#list_of_messages_more').show();
};

// Flash messages
function closeFlash() {
	$("div.flash").hide("slide", { direction: "down" }, 500);
};

function closeFlashUp() {
	$("div.flash").hide("slide", { direction: "up" }, 500);
};

function showLightning(id) {
	var i = id
	$('div#deal_'+i).fadeIn();
};

function hideLightning() {
	$('div.show_lightning').fadeOut();
};

function showMyAccountMenu() {
	$('a#my_account').addClass("my_account_hover");
	$('div#my_account_drop_down').slideDown();
};

function hideMyAccountMenu() {
	$('a#my_account').removeClass("my_account_hover");
	$('div#my_account_drop_down').slideUp();
};

function toggleMyAccountMenu() {
	var x = $('div#my_account_drop_down');
	if (x.css("display") == "none") {
		$('a#my_account').addClass("my_account_hover");
		$('div#my_account_drop_down').slideDown();
	} else {
		$('div#my_account_drop_down').slideUp(400, function() {
			$('a#my_account').removeClass("my_account_hover");
		});
	};
};

// Side Panel

function toggleControlPanel() {
	$('div#user_index_control_panel').slideToggle();
};

function toggleLocations() {
	$('div.locations').slideToggle();
};

function toggleCategories() {
	$('div.categories').slideToggle();
};


// comments 

function makeCommentBigger() {
	$('textarea#comment_content').css("padding-bottom", "32px");
	$('div#comment_submit').show();
};

/* subcomments */

function showReply(id) {
	var i = id
	$('div#reply_'+i).show();
	$('div#subcomment_gravatar_'+i).show();
	$('textarea#reply_'+i).css("width", "438px");
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

// Share list

$(document).ready(function() {
	$('a#share_single').click(function() {
		$('div#share_list').fadeToggle(300);
	});
});

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

// Share list and Watchers list

function closeShareList() {
	$('div#share_list').fadeOut(300);
};

function show_watchers() {
	$("div#show_watchers").fadeIn(400);
};

function hide_watchers() {
	$("div#show_watchers").fadeOut(200);
};

function toggleWatchDealInfo() {
	$("div#watch_deal_info").fadeToggle();
};

// show user vote for or against

function showUserVote() {
	$("div#user_voted").fadeIn(200);
};

function hideUserVote() {
	$("div#user_voted").fadeOut(200);
};

// show labels for Mark as Read and Mark as UnRead

function showMarkAsRead(id) {
	var i = id
	$('div#mark_as_read_'+i).fadeIn(200);
};

function hideMarkAsRead(id) {
	var i = id
	$('div#mark_as_read_'+i).fadeOut(200);
}

function showMarkAsUnRead(id) {
	var i = id
	$('div#mark_as_unread_'+i).fadeIn(200);
};

function hideMarkAsUnRead(id) {
	var i = id
	$('div#mark_as_unread_'+i).fadeOut(200);
}

// cannot send message if recipient_id or content does not match regex (only white space)

$(document).ready(function() {
	var regex = /^\s*\S.*$/
	$('div#message_new_form div.actions input').click(function() {
		var x = $('select#message_recipient_id').val();
		var y = $('textarea#message_content').val();
		if (!y.match(regex) || !x.match(regex)) {
			return false;
		}
	});
});

/*
// regex on message reply

$(document).ready(function() {
	var regex = /^\s*\S.*$/
	$('div#message_reply_form div.actions input').click(function() {
		var x = $('div#message_reply_form textarea#message_content').val();
		if (!x.match(regex)) {
			return false;
		}
	});
});

// regex on comment

$(document).ready(function() {
	var regex = /^\s*\S.*$/
	$('div#comment_submit input').click(function() {
		var x = $('textarea#comment_content').val();
		if (!x.match(regex)) {
			return false;
		}
	});
});

// regex on subcomment

$(document).ready(function() {
	var regex = /^(?=\s*\S).*$/
	$('div.reply input').click(function() {
		var i = $(this).attr("id");
		var x = $('textarea#reply_'+i).val();
		if (!x.match(regex)) {
			return false;
		}
	})
})
*/

// Disable National Link
$(document).ready(function() {
	$("div#location a").click(function() {
		return false;
	});
});

// Reset your password REGEX
$(document).ready(function() {
	var regex = /^\s*\S.*$/
	$('div#password_reset_form div.actions input').click(function() {
		var x = $('div#password_reset_form input#email').val();
		if (!x.match(regex)) {
			return false;
		};
	});
});

// Feedback REGEX
$(document).ready(function() {
	var regex = /^\s*\S.*$/
	$('div#feedback_form div.actions input').click(function() {
		var x = $('textarea#feedback_content').val();
		if (!x.match(regex)) {
			return false;
		};
	});
});