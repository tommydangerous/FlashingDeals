$(document).ready(function() {
	$("#friend_name").autocomplete({
		source: $("#friend_name").data('autocomplete-source')
	})
})