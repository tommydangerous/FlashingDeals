$(document).ready(function() {
	$("input.send_email").click(function() {
		var x = $("#user_email_invite").val();
		if (x === "") {
			return false;
		} else {
			$("div#sending_emails").show();
			$("html, body").animate({ scrollTop: 0  }, 0);
		}
	})
	$("input.send_gmail").click(function() {
		var l = $(".email_invite_selected").length
		if (l < 1) {
			return false;
		} else {
			$("div#sending_emails").show();
			$("html, body").animate({ scrollTop: 0  }, 0);
		}
	})
	$("input#gmail_login_submit").click(function() {
		var e = $("#gmail_login_email").val()
		var p = $("#gmail_login_password").val()
		if (e === "" || p === "") {
			return false;
		}
	})
})

function toggleEmailInvite(id) {
	var i = id
	var x = $("#contact_"+i)
	if($("#email_invite_check_"+i).is(":checked")) {
		x.addClass("email_invite_selected");
		var l = $(".email_invite_selected").length
		$("span#selected_emails_count").text(l);
	} else {
		x.removeClass("email_invite_selected");
		var l = $(".email_invite_selected").length
		$("span#selected_emails_count").text(l);
	}
}

function toggleChecked() {
	var x = $("input#check_all");
	if(x.is(":checked")) {
		$(".email_invite_check").each(function() {
			$(this).attr("checked", true);
		})
		$(".email_invite_contact").each(function() {
			$(this).addClass("email_invite_selected");
		})
		var l = $(".email_invite_selected").length
		$("span#selected_emails_count").text(l);
	} else {
		$(".email_invite_check").each(function() {
			$(this).attr("checked", false);
		})
		$(".email_invite_contact").each(function() {
			$(this).removeClass("email_invite_selected");
		})
		var l = $(".email_invite_selected").length
		$("span#selected_emails_count").text(l);
	}
}

$(document).ready(function() {
		$("#add_gmail_contacts").click(function(){
			$("#add_gmail_contacts").hide();
			$("#gmail_login").show();
	});
})