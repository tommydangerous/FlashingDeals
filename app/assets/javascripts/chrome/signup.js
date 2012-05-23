$(document).ready(function() {
	// name field
	var name_clicks = 0;
	$("#user_name").click(function() {
		if(name_clicks == 0) {
			name_clicks++;
			$("#user_name_example").show();
		}
	})
	$("#user_name").focus(function() {
		if(name_clicks == 0) {
			name_clicks++;
			$("#user_name_example").show();
		}
	})
	// email field
	var email_clicks = 0;
	$("#user_email").click(function() {
		if(email_clicks == 0) {
			email_clicks++;
			$("#user_email_example").show();
		};
	})
	$("#user_email").focus(function() {
		if(email_clicks == 0) {
			email_clicks++;
			$("#user_email_example").show();
		};
	})
	// password field
	var pw_clicks = 0;
	$("#user_password").click(function() {
		if(pw_clicks == 0) {
			pw_clicks++;
			$("#user_pw_example").show();
		};
	})
	$("#user_password").focus(function() {
		if(pw_clicks == 0) {
			pw_clicks++;
			$("#user_pw_example").show();
		};
	})
	// clicking signup button
	$("#signup_submit").click(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#user_name_example").hide();
			$("#user_name_blank").show();
			$("#user_name_invalid").hide();
			$("#user_name_good").hide();
			return false;
		} else if(!name_val.match(name_regex)) {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").show();
			$("#user_name_good").hide();
			return false;
		}
	})
	$("#signup_submit").click(function() {
		// email
		email_clicks++;
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#user_email_example").hide();
			$("#user_email_blank").show();
			$("#user_email_invalid").hide();
			$("#user_email_good").hide();
			return false;
		} else if(!email_val.match(email_regex)) {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").show();
			$("#user_email_good").hide();
			return false;
		}
	})
	$("#signup_submit").click(function() {
		// password
		pw_clicks++;
		var pw = $("#user_password");
		var pw_val = pw.val();
		if(pw_val.length < 2) {
			$("#user_pw_example").hide();
			$("#user_pw_short").show();
			$("#user_pw_long").hide();
			$("#user_pw_good").hide();
			return false;
		} else if(pw_val.length > 40) {
			$("#user_pw_example").hide();
			$("#user_pw_short").hide();
			$("#user_pw_long").show();
			$("#user_pw_good").hide();
			return false;
		}
	})
	
	// clicking email field
	$("#user_email").click(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#user_name_example").hide();
			$("#user_name_blank").show();
			$("#user_name_invalid").hide();
			$("#user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").show();
			$("#user_name_good").hide();
		} else {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").hide();
			$("#user_name_good").show();
		}
	})
	$("#user_email").focus(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#user_name_example").hide();
			$("#user_name_blank").show();
			$("#user_name_invalid").hide();
			$("#user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").show();
			$("#user_name_good").hide();
		} else {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").hide();
			$("#user_name_good").show();
		}
	})
	
	// clicking password field
	$("#user_password").click(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#user_name_example").hide();
			$("#user_name_blank").show();
			$("#user_name_invalid").hide();
			$("#user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").show();
			$("#user_name_good").hide();
		} else {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").hide();
			$("#user_name_good").show();
		}
	})
	$("#user_password").click(function() {
		// email
		email_clicks++;
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#user_email_example").hide();
			$("#user_email_blank").show();
			$("#user_email_invalid").hide();
			$("#user_email_good").hide();
		} else if(!email_val.match(email_regex)) {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").show();
			$("#user_email_good").hide();
		} else {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").hide();
			$("#user_email_good").show();
		}
	})
	$("#user_password").focus(function() {
		// name
		name_clicks++;
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#user_name_example").hide();
			$("#user_name_blank").show();
			$("#user_name_invalid").hide();
			$("#user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").show();
			$("#user_name_good").hide();
		} else {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").hide();
			$("#user_name_good").show();
		}
	})
	$("#user_password").focus(function() {
		// email
		email_clicks++;
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#user_email_example").hide();
			$("#user_email_blank").show();
			$("#user_email_invalid").hide();
			$("#user_email_good").hide();
		} else if(!email_val.match(email_regex)) {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").show();
			$("#user_email_good").hide();
		} else {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").hide();
			$("#user_email_good").show();
		}
	})
	
	// typing validations
	var typingTimer;
	var doneTypingInterval = 1500;
	var typingTimerEmail;
	var doneTypingIntervalEmail = 2000;
	var typingTimerPw;
	var doneTypingIntervalPw = 1000;
	
	$("#user_name").keyup(function() {
		typingTimer = setTimeout(doneTypingName, doneTypingInterval);
	})
	$("#user_name").keydown(function() {
		clearTimeout(typingTimer);
	})
	$("#user_email").keyup(function() {
		typingTimerEmail = setTimeout(doneTypingEmail, doneTypingIntervalEmail);
	})
	$("#user_email").keydown(function() {
		clearTimeout(typingTimerEmail);
	})
	$("#user_password").keyup(function() {
		typingTimerPw = setTimeout(doneTypingPw, doneTypingIntervalPw);
	})
	$("#user_password").keydown(function() {
		clearTimeout(typingTimerPw);
	})
	function doneTypingName() {
		// name
		var name_regex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $("#user_name");
		var name_val = name.val();
		if(name_val.length == 0) {
			$("#user_name_example").hide();
			$("#user_name_blank").show();
			$("#user_name_invalid").hide();
			$("#user_name_good").hide();
		} else if(!name_val.match(name_regex)) {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").show();
			$("#user_name_good").hide();
		} else {
			$("#user_name_example").hide();
			$("#user_name_blank").hide();
			$("#user_name_invalid").hide();
			$("#user_name_good").show();
		}
	}
	function doneTypingEmail() {
		// email
		var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $("#user_email");
		var email_val = email.val();
		if(email_val.length == 0) {
			$("#user_email_example").hide();
			$("#user_email_blank").show();
			$("#user_email_invalid").hide();
			$("#user_email_good").hide();
		} else if(!email_val.match(email_regex)) {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").show();
			$("#user_email_good").hide();
		} else {
			$("#user_email_example").hide();
			$("#user_email_blank").hide();
			$("#user_email_invalid").hide();
			$("#user_email_good").show();
		}
	}
	function doneTypingPw() {
		// password
		var pw = $("#user_password");
		var pw_val = pw.val();
		if(pw_val.length < 2) {
			$("#user_pw_example").hide();
			$("#user_pw_short").show();
			$("#user_pw_long").hide();
			$("#user_pw_good").hide();
		} else if(pw_val.length > 40) {
			$("#user_pw_example").hide();
			$("#user_pw_short").hide();
			$("#user_pw_long").show();
			$("#user_pw_good").hide();
		} else {
			$("#user_pw_example").hide();
			$("#user_pw_short").hide();
			$("#user_pw_long").hide();
			$("#user_pw_good").show();
		}
	}
})