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

// Messages
function showMessagesMore() {
	$('a#show_messages_more').hide();
	$('div#list_of_messages_more').show();
};

function showNewMessage() {
	$('div#new_message_main').show();
	$('textarea#message_content').focus();
};

function showIndexMessage() {
	$('div#new_message_main').show();
	$('input#friend_name').focus();
};

function closeNewMessage() {
	$('div#new_message_main').hide();
};

// Flash messages
function closeFlash() {
	$("div.flash").hide("slide", { direction: "down" }, 500);
};

function closeFlashUp() {
	$("div.flash").hide("slide", { direction: "up" }, 500);
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
	$('div#user_index_control_panel').toggle();
};

function toggleLocations() {
	$('div.locations').toggle();
};

function toggleCategories() {
	$('div.categories').toggle();
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
function showShareList() {
	$('div#share_list').fadeIn(100);
	$('input#friend_name').focus();
};

function closeShareList() {
	$('div#share_list').hide();
};

function showShareAllInfo() {
	$('div#share_all_info').fadeIn(100);
};

function hideShareAllInfo() {
	$('div#share_all_info').hide();
};

function show_watchers() {
	$("div#show_watchers").fadeIn(100);
};

function hide_watchers() {
	$("div#show_watchers").hide();
};

function showWatchDealInfo() {
	$("div#watch_deal_info").fadeIn(100);
};

function hideWatchDealInfo() {
	$("div#watch_deal_info").hide();
};

// Vote
function toggleUserLike() {
	$('div#user_like').toggle();
};

function toggleUserDislike() {
	$('div#user_dislike').toggle();
};

// show labels for Mark as Read and Mark as UnRead

function showMarkAsRead(id) {
	var i = id
	$('div#mark_as_read_'+i).fadeIn(100);
};

function hideMarkAsRead(id) {
	var i = id
	$('div#mark_as_read_'+i).hide();
}

function showMarkAsUnRead(id) {
	var i = id
	$('div#mark_as_unread_'+i).fadeIn(100);
};

function hideMarkAsUnRead(id) {
	var i = id
	$('div#mark_as_unread_'+i).hide();
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

// Info for FlashBack and FlashMob
function toggleDealPageInfo() {
	$("div.deal_page_info").fadeToggle(200);
};