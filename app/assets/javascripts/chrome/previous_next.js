$(document).ready(function() {
	// previous deal
	$('#previous_deal').imagesLoaded(function() {
		var prev_deal = $('#previous_deal');
		var prev_deal_image = $('.previous_deal_image');
		var w = prev_deal_image.width();
		var w_show = (w * 50)/100
		var w_hide = w - w_show
		// previous deal hover
		var prev_deal_show = 0;
		prev_deal.mouseover(function() {
			if(prev_deal_show == 0) {
				prev_deal_show++;
				prev_deal_hide = 0;
				$(this).animate({ left: '+='+w_hide }, 100);
			}
		})
		var prev_deal_hide = 0;
		prev_deal.mouseleave(function() {
			if(prev_deal_hide == 0) {
				prev_deal_show = 0;
				prev_deal_hide++;
				$(this).stop()
				$(this).css("left", (-1 * w_hide));
			}
		})
		// previous deal position and width
		prev_deal.css("left", (-1 * w_hide));
		prev_deal.css("width", w);
		// previous deal image height
		var h = $('.previous_deal_image').height();
		var nh = (160-h)/2;
		$('.previous_deal_image').css("top", nh);
	})
	
	// next deal
	$('#next_deal').imagesLoaded(function() {
		var next_deal = $('#next_deal');
		var next_deal_image = $('.next_deal_image');
		var w = next_deal_image.width();
		var w_show = (w * 50)/100
		var w_hide = w - w_show
		// next deal hover
		var next_deal_show = 0;
		next_deal.mouseover(function() {
			if(next_deal_show == 0) {
				next_deal_show++;
				next_deal_hide = 0;
				$(this).animate({ right: '+='+w_hide }, 100);
			}
		})
		var next_deal_hide = 0;
		next_deal.mouseleave(function() {
			if(next_deal_hide == 0) {
				next_deal_show = 0;
				next_deal_hide++;
				$(this).stop()
				$(this).css("right", (-1 * w_hide));
			}
		})
		// next deal position and width
		next_deal.css("right", (-1 * w_hide));
		next_deal.css("width", w);
		// next deal image height
		var h = $('.next_deal_image').height();
		var nh = (160-h)/2;
		$('.next_deal_image').css("top", nh);
	})
})