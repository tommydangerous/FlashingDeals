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

function addCatClass(id) {
	var i = id
	$("p#cat_"+i).addClass("grey_75");
};

function removeCatClass(id) {
	var i = id
	$("p#cat_"+i).removeClass("grey_75");
};


// comments 
function makeCommentBigger() {
	$('div.field textarea#comment_content').css("padding-bottom", "32px");
	$('div#comment_submit').show();
};

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
		var x = $('input#friend_name').val();
		var y = $('textarea#message_content').val();
		if (y === "" || x === "") {
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

// Info for FlashBack and FlashMob
function toggleDealPageInfo() {
	$("div.deal_page_info").fadeToggle(200);
};

function hidePageDealInfo() {
	$("div#page_deal_info").fadeOut(200);
};

// Login & Signup
function signupSwitch() {
	$("#dim_signup").hide();
	$("#dim_signup_deal_show").hide();
	$("#dim").show();
}

function loginSwitch() {
	$("#dim_signup").show();
	$("#dim").hide();
}

// Facebook Like Button
function hideFacebookLike() {
	var h = $('.fb_iframe_widget').height();
	if (h > 30) {
		$('.fb_iframe_widget').hide();
	} else
	{
		$('.fb_iframe_widget').show();
	}
}
setInterval(hideFacebookLike, 0);