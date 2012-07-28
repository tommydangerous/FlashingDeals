$(document).on('pageinit', function() {
	var messageSubmit = $('#messageForm .actions input');
	messageSubmit.on('click', function() {
		var messageContent = $('#messageForm .field textarea').val();
		if (messageContent === "") {
			return false;
		}
		else if (messageSubmit.hasClass("noClick")) {
			return false;
		}
		else {
			messageSubmit.addClass("noClick")
		};
	});
});