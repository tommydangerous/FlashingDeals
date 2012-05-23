$(document).ready(function() {
	// name field
	var name_clicks = 0;
	$("#signup_message_form #user_name").click(function() {
		if(name_clicks == 0) {
			name_clicks++;
			$("#signup_message_form #user_name_example").show();
		}
	})
	$("#signup_message_form #user_name").focus(function() {
		if(name_clicks == 0) {
			name_clicks++;
			$("#signup_message_form #user_name_example").show();
		}
	})
	// email field
	var email_clicks = 0;
	$("#signup_message_form #user_email").click(function() {
		if(email_clicks == 0) {
			email_clicks++;
			$("#signup_message_form #user_email_example").show();
		};
	})
	$("#signup_message_form #user_email").focus(function() {
		if(email_clicks == 0) {
			email_clicks++;
			$("#signup_message_form #user_email_example").show();
		};
	})
	// password field
	var pw_clicks = 0;
	$("#signup_message_form #user_password").click(function() {
		if(pw_clicks == 0) {
			pw_clicks++;
			$("#signup_message_form #user_pw_example").show();
		};
	})
	$("#signup_message_form #user_password").focus(function() {
		if(pw_clicks == 0) {
			pw_clicks++;
			$("#signup_message_form #user_pw_example").show();
		};
	})
	// clicking signup button
	$("#signup_message_form #signup_submit").click(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#signup_message_form #user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").show();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").hide();
			return false;
		} else if(!name_val.match(name_regex)) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").show();
			$("#signup_message_form #user_name_good").hide();
			return false;
		}
	})
	$("#signup_message_form #signup_submit").click(function() {
		// email
		email_clicks++;
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#signup_message_form #user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").show();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").hide();
			return false;
		} else if(!email_val.match(email_regex)) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").show();
			$("#signup_message_form #user_email_good").hide();
			return false;
		}
	})
	$("#signup_message_form #signup_submit").click(function() {
		// password
		pw_clicks++;
		var pw = $("#signup_message_form #user_password");
		var pw_val = pw.val();
		if(pw_val.length < 2) {
			$("#signup_message_form #user_pw_example").hide();
			$("#signup_message_form #user_pw_short").show();
			$("#signup_message_form #user_pw_long").hide();
			$("#signup_message_form #user_pw_good").hide();
			return false;
		} else if(pw_val.length > 40) {
			$("#signup_message_form #user_pw_example").hide();
			$("#signup_message_form #user_pw_short").hide();
			$("#signup_message_form #user_pw_long").show();
			$("#signup_message_form #user_pw_good").hide();
			return false;
		}
	})
	
	// clicking email field
	$("#signup_message_form #user_email").click(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#signup_message_form #user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").show();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").show();
			$("#signup_message_form #user_name_good").hide();
		} else {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").show();
		}
	})
	$("#signup_message_form #user_email").focus(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#signup_message_form #user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").show();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").show();
			$("#signup_message_form #user_name_good").hide();
		} else {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").show();
		}
	})
	
	// clicking password field
	$("#signup_message_form #user_password").click(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#signup_message_form #user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").show();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").show();
			$("#signup_message_form #user_name_good").hide();
		} else {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").show();
		}
	})
	$("#signup_message_form #user_password").click(function() {
		// email
		email_clicks++;
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#signup_message_form #user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").show();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").hide();
		} else if(!email_val.match(email_regex)) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").show();
			$("#signup_message_form #user_email_good").hide();
		} else {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").show();
		}
	})
	$("#signup_message_form #user_password").focus(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#signup_message_form #user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").show();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").show();
			$("#signup_message_form #user_name_good").hide();
		} else {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").show();
		}
	})
	$("#signup_message_form #user_password").focus(function() {
		// email
		email_clicks++;
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#signup_message_form #user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").show();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").hide();
		} else if(!email_val.match(email_regex)) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").show();
			$("#signup_message_form #user_email_good").hide();
		} else {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").show();
		}
	})
	
	// typing validations
	var typingTimer;
	var doneTypingInterval = 1000;
	var typingTimerEmail;
	var doneTypingIntervalEmail = 2000;
	var typingTimerPw;
	var doneTypingIntervalPw = 500;
	
	$("#signup_message_form #user_name").keyup(function() {
		typingTimer = setTimeout(doneTypingName, doneTypingInterval);
	})
	$("#signup_message_form #user_name").keydown(function() {
		clearTimeout(typingTimer);
	})
	$("#signup_message_form #user_email").keyup(function() {
		typingTimerEmail = setTimeout(doneTypingEmail, doneTypingIntervalEmail);
	})
	$("#signup_message_form #user_email").keydown(function() {
		clearTimeout(typingTimerEmail);
	})
	$("#signup_message_form #user_password").keyup(function() {
		typingTimerPw = setTimeout(doneTypingPw, doneTypingIntervalPw);
	})
	$("#signup_message_form #user_password").keydown(function() {
		clearTimeout(typingTimerPw);
	})
	function doneTypingName() {
		// name
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#signup_message_form #user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").show();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").show();
			$("#signup_message_form #user_name_good").hide();
		} else {
			$("#signup_message_form #user_name_example").hide();
			$("#signup_message_form #user_name_blank").hide();
			$("#signup_message_form #user_name_invalid").hide();
			$("#signup_message_form #user_name_good").show();
		}
	}
	function doneTypingEmail() {
		// email
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#signup_message_form #user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").show();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").hide();
		} else if(!email_val.match(email_regex)) {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").show();
			$("#signup_message_form #user_email_good").hide();
		} else {
			$("#signup_message_form #user_email_example").hide();
			$("#signup_message_form #user_email_blank").hide();
			$("#signup_message_form #user_email_invalid").hide();
			$("#signup_message_form #user_email_good").show();
		}
	}
	function doneTypingPw() {
		// password
		var pw = $("#signup_message_form #user_password");
		var pw_val = pw.val();
		if(pw_val.length < 2) {
			$("#signup_message_form #user_pw_example").hide();
			$("#signup_message_form #user_pw_short").show();
			$("#signup_message_form #user_pw_long").hide();
			$("#signup_message_form #user_pw_good").hide();
		} else if(pw_val.length > 40) {
			$("#signup_message_form #user_pw_example").hide();
			$("#signup_message_form #user_pw_short").hide();
			$("#signup_message_form #user_pw_long").show();
			$("#signup_message_form #user_pw_good").hide();
		} else {
			$("#signup_message_form #user_pw_example").hide();
			$("#signup_message_form #user_pw_short").hide();
			$("#signup_message_form #user_pw_long").hide();
			$("#signup_message_form #user_pw_good").show();
		}
	}
})