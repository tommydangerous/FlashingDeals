$(document).bind('pageinit', function() {
	var dealActions = $('.dealShowContent .actions ').last();
	var submit = dealActions.children('input');
	submit.on('click', function() {
		var dealField = $('.dealShowContent .field').last();
		var cont = dealField.children('textarea').val();
		if (cont === "") {
			return false;
		}
		else if (submit.hasClass("noClick")) {
			return false;
		}
		else {
			submit.addClass("noClick");
		}
	})
})