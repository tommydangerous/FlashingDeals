$(document).ready(function() {
	$("#leaderboard_how_to_level").click(function() {
		$("div#leaderboard").hide();
		$("div#how_to_level").show();
	})
	$("#how_to_level_leaderboard").click(function() {
		$("div#how_to_level").hide();
		$("div#leaderboard").show();
	})
})