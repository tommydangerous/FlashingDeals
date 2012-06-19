# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	if $('#endless_pagination .pagination').length
		$(window).scroll ->
			url = $('#endless_pagination .pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 800
				$('#endless_pagination').replaceWith('
					<div id="loading_deals"></div>
				')
				$.getScript(url)
		$(window).scroll()
jQuery ->
	if $('.feed_pagination .pagination').length
		$(window).scroll ->
			url = $('.feed_pagination .pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 800
				$('.feed_pagination').replaceWith('
					<div class="building_feed">
						Building feed...
					</div>
				')
				$.getScript(url)
		$(window).scroll()