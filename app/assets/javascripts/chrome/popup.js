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
  	$("#dim_signup").fadeIn(200);
  	$("html, body").animate({ scrollTop: 0  }, 0);
    	return false;
	});
    		
	$(".closedim").click(function(){
  	$("#dim").fadeOut(200);
    	return false;
	});
	
	$(".signup_popup_anchor").click(function() {
		$("div#dim_signup").fadeIn(200);
		$("html, body").animate({ scrollTop: 0  }, 100);
			return false;
	});
	
	$(".scroll_top").click(function() {
		$("html, body").animate({ scrollTop: 0  }, 100);
			return false;
	})
	
	$("a#popup_page_info_close").click(function() {
		$("div#popup_page_info").slideUp();
	});
});
		
$(window).bind("resize", function(){
	$("#dim2").css("height", $(window).height());
		$("#fuzz").css("height", $(window).height());
});

function closeSignupButton() {
	$("#dim_signup").fadeOut(200);
	$("#dim_signup_deal_show").fadeOut(200);
};

function signupPopupExclusive() {
	$("div#dim_signup").fadeIn(200);
	$("html, body").animate({ scrollTop: 0  }, 0);
	return false
};

function toggleSignupLogin() {
	var s = $("#signup_message_form");
	var l = $("#login_form");
	if(s.css("display") == "none" && l.css("display") == "block") {
		s.css("display", "block");
		l.css("display", "none");
	} else if (s.css("display") == "block" && l.css("display") == "none") {
		s.css("display", "none");
		l.css("display", "block");
	}
};