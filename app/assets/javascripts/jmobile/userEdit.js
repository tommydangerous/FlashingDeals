$(document).on('pageinit', function() {
	// Name
	var nameSubmit = $('.contentWrapper:last #userNameSubmit');
	nameSubmit.on('click', function() {
		var nameRegex = /^[A-Za-z]{1,}[A-Za-z0-9]+[-_ ]?[A-Za-z0-9]{1,}$/
		var name = $('.contentWrapper:last #user_name');
		var nameVal = name.val();
		if (nameVal.length === 0) {
			$('#nameBlank').show();
			$('#nameLong').hide();
			$('#nameInvalid').hide();
			$('#nameError').hide();
			name.addClass("fieldError");
			return false;
		}
		else if(nameVal.length > 20) {
			$('#nameBlank').hide();
			$('#nameLong').show();
			$('#nameInvalid').hide();
			$('#nameError').hide();
			name.addClass("fieldError");
			return false;
		}
		else if(!nameVal.match(nameRegex)) {
			$('#nameBlank').hide();
			$('#nameLong').hide();
			$('#nameInvalid').show();
			$('#nameError').hide();
			name.addClass("fieldError");
			return false;
		}
		else {
			$('#nameBlank').hide();
			$('#nameLong').hide();
			$('#nameInvalid').hide();
			$('#nameError').hide();
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
			$('#emailBlank').show();
			$('#emailInvalid').hide();
			$('#emailError').hide();
			email.addClass("fieldError");
			return false;
		}
		else if(!emailVal.match(emailRegex)) {
			$('#emailBlank').hide();
			$('#emailInvalid').show();
			$('#emailError').hide();
			email.addClass("fieldError");
			return false;
		}
		else {
			$('#emailBlank').hide();
			$('#emailInvalid').hide();
			$('#emailError').hide();
			email.removeClass("fieldError");
		}
	})
})