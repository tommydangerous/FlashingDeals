$(document).ready(function() {
	var submit = $('#password_reset_form .actions input');
	var email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
	submit.live('click', function() {
		if ($('#name').length > 0) {
			var name = $('#password_reset_form #name').val();
			var email = $('#password_reset_form #email').val();
			if (name.length == 0 || email.length == 0) {
				return false;
			}
			else if (!email.match(email_regex)) {
				return false;
			}
		}
		else {
			var email = $('#password_reset_form #email').val();
			if (email.length == 0) {
				return false;
			}
			else if (!email.match(email_regex)) {
				return false;
			}
		}
	})
})