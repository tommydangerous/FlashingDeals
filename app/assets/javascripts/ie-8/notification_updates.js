function friendRequest() {
	$.ajax({
		url: "/ajax/ajax_friend_requests",
		cache: false,
		success: function(html){
			$("span.friend_request_count").html(html);
		}
	})
};

function messageCount() {
	$.ajax({
		url: "/ajax/ajax_received_messages",
		cache: false,
		success: function(html){
			$("span.message_unread_count").html(html);
		}
	})
};

function sharedDealCount() {
	$.ajax({
		url: "/ajax/ajax_shared_deals",
		cache: false,
		success: function(html){
			$("span.ajax_shared_deals").html(html);
		}
	})
};

function accountNotice() {
	$.ajax({
		url: "/ajax/ajax_notification",
		cache: false,
		success: function(html){
			$("span#my_account_notification").html(html);
		}
	})
};

function notificationsUpdate() {
	$.ajax({
		url: "/ajax/ajax_notifications_update",
		cache: false,
		success: function(html){
			$("span.notification_count").html(html);
		}
	})	
};