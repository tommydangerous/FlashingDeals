$(document).on('pageinit', function() {
	// Name
	var nameSubmit = $('.contentWrapper:last #userNameSubmit');
	nameSubmit.on('click', function() {
		var nameRegex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $('.contentWrapper:last #user_name');
		var nameVal = name.val();
		if (nameVal.length === 0) {
			$('.contentWrapper:last #nameBlank').show();
			$('.contentWrapper:last #nameLong').hide();
			$('.contentWrapper:last #nameInvalid').hide();
			$('.contentWrapper:last #nameError').hide();
			name.addClass("fieldError");
			return false;
		}
		else if(nameVal.length > 20) {
			$('.contentWrapper:last #nameBlank').hide();
			$('.contentWrapper:last #nameLong').show();
			$('.contentWrapper:last #nameInvalid').hide();
			$('.contentWrapper:last #nameError').hide();
			name.addClass("fieldError");
			return false;
		}
		else if(!nameVal.match(nameRegex)) {
			$('.contentWrapper:last #nameBlank').hide();
			$('.contentWrapper:last #nameLong').hide();
			$('.contentWrapper:last #nameInvalid').show();
			$('.contentWrapper:last #nameError').hide();
			name.addClass("fieldError");
			return false;
		}
		else {
			$('.contentWrapper:last #nameBlank').hide();
			$('.contentWrapper:last #nameLong').hide();
			$('.contentWrapper:last #nameInvalid').hide();
			$('.contentWrapper:last #nameError').hide();
			name.removeClass("fieldError");
		}
	})
	// Email
	var emailSubmit = $('.contentWrapper:last #userEmailSubmit');
	emailSubmit.on('click', function() {
		var emailRegex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i
		var email = $('.contentWrapper:last #user_email');
		var emailVal = email.val();
		if(emailVal.length == 0) {
			$('.contentWrapper:last #emailBlank').show();
			$('.contentWrapper:last #emailInvalid').hide();
			$('.contentWrapper:last #emailError').hide();
			email.addClass("fieldError");
			return false;
		}
		else if(!emailVal.match(emailRegex)) {
			$('.contentWrapper:last #emailBlank').hide();
			$('.contentWrapper:last #emailInvalid').show();
			$('.contentWrapper:last #emailError').hide();
			email.addClass("fieldError");
			return false;
		}
		else {
			$('.contentWrapper:last #emailBlank').hide();
			$('.contentWrapper:last #emailInvalid').hide();
			$('.contentWrapper:last #emailError').hide();
			email.removeClass("fieldError");
		}
	})
	// Password
	var passwordSubmit = $('.contentWrapper:last #userPasswordSubmit');
	passwordSubmit.on('click', function() {
		var password = $('.contentWrapper:last #user_password');
		var confirm = $('.contentWrapper:last #user_password_confirmation');
		var passwordVal = password.val();
		var confirmVal = confirm.val();
		if (passwordVal.length < 2) {
			$('.contentWrapper:last #pwShort').show();
			$('.contentWrapper:last #pwLong').hide();
			$('.contentWrapper:last #pwMismatch').hide();
			password.addClass("fieldError");
			confirm.removeClass("fieldError");
			return false;
		}
		else if (passwordVal.length > 40) {
			$('.contentWrapper:last #pwShort').hide();
			$('.contentWrapper:last #pwLong').show();
			$('.contentWrapper:last #pwMismatch').hide();
			password.addClass("fieldError");
			confirm.removeClass("fieldError");
			return false;
		}
		else if (passwordVal != confirmVal) {
			$('.contentWrapper:last #pwShort').hide();
			$('.contentWrapper:last #pwLong').hide();
			$('.contentWrapper:last #pwMismatch').show();
			password.removeClass("fieldError");
			confirm.addClass("fieldError");
			return false;
		}
		else {
			$('.contentWrapper:last #pwShort').hide();
			$('.contentWrapper:last #pwLong').hide();
			$('.contentWrapper:last #pwMismatch').hide();
			password.removeClass("fieldError");
			confirm.removeClass("fieldError");
		}
	})
	// Cancel Password
	$('.contentWrapper:last .passwordCancel').on('click', function() {
		var password = $('.contentWrapper:last #user_password');
		var confirm = $('.contentWrapper:last #user_password_confirmation');
		password.val("");
		confirm.val("");
		$('.contentWrapper:last #pwShort').hide();
		$('.contentWrapper:last #pwLong').hide();
		$('.contentWrapper:last #pwMismatch').hide();
		password.removeClass("fieldError");
		confirm.removeClass("fieldError");
	})
})