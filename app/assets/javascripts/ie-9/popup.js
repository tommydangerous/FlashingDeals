$(document).ready(function(){ 		
	$("#dim2").css("height", $(document).height());
  $("#fuzz").css("height", $(document).height());
    				
  $(".alertfuzz").click(function(){
  	$("#fuzz").fadeIn();
    	return false;
	});
    		
  $(".closefuzz").click(function(){
  	$("#fuzz").fadeOut();
    	return false;
	});
			
	$(".alertdim").click(function(){
  	$("#dim").fadeIn(200);
  	$("html, body").animate({ scrollTop: 0  }, 0);
    	return false;
	});
    		
	$(".closedim").click(function(){
  	$("#dim").fadeOut(200);
    	return false;
	});
	
	$("#close_signup_message_button").click(function() {
		$("#dim_signup").fadeOut(200);
	});
	
	$(".signup_popup_anchor").click(function() {
		$("div#dim_signup").fadeIn(200);
			return false;
	});
	
	$(".scroll_top").click(function() {
		$("html, body").animate({ scrollTop: 0  }, 0);
			return false;
	})
});
		
$(window).bind("resize", function(){
	$("#dim2").css("height", $(window).height());
		$("#fuzz").css("height", $(window).height());
});