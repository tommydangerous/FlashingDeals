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
  	$("#dim").fadeIn();
    	return false;
	});
    		
	$(".closedim").click(function(){
  	$("#dim").fadeOut();
    	return false;
	});
});
		
$(window).bind("resize", function(){
	$("#dim2").css("height", $(window).height());
		$("#fuzz").css("height", $(window).height());
});

function showNewMessage() {
	$('div#new_message_main').show();
};

function closeNewMessage() {
	$('div#new_message_main').hide();
};