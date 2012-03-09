# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	if $('#endless_pagination .pagination').length
		$(window).scroll ->
			url = $('#endless_pagination .pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 800
				$('#endless_pagination').replaceWith('
					<div id="loading_deals">
						<img src="/assets/loading.gif">
						<div id="loading_deals_words">
							<em>Fetching more deals...</em>
						</div>
					</div>
				')
				$.getScript(url)
		$(window).scroll()