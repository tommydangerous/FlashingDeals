$(document).ready(function() {
	// Add bold text tags
	$('.addBold').live('click', function() {
		var open = '<b>';
		var close = '</b>'
		addHtmlTags(open, close);
	})
	// Add italic text tags
	$('.addItalic').live('click', function() {
		var open = '<em>';
		var close = '</em>'
		addHtmlTags(open, close);
	})
	// Add unordered list tags
	$('.addUl').live('click', function() {
		var open = '<ul>';
		var close = '</ul>'
		addHtmlTags(open, close);
	})
	// Add ordered list tags
	$('.addOl').live('click', function() {
		var open = '<ol>';
		var close = '</ol>'
		addHtmlTags(open, close);
	})
	// Add list item tags
	$('.addListItem').live('click', function() {
		var open = '<li>';
		var close = '</li>';
		addHtmlTags(open, close);
	})
	// Add hyperlink url and text between anchor tags
	$('.addHyperlink').live('click', function() {
		var link = $('.hyperlinkUrl').val();
		var linkText = $('.hyperlinkText').val();
		var open = '<a href="' + link + '">' + linkText;
		var close = '</a>';
		addHtmlTags(open, close);
		$('.hyperlinkUrl').val('');
		$('.hyperlinkText').val('');
	})
	// Add image tag with max width and max height
	$('.addImage').live('click', function() {
		var numberRegex = /^(\s*|\d+)$/
		var image = $('.addImageUrl').val();
		var width = $('.addImageWidth').val();
		var height = $('.addImageHeight').val();
		if (width != '' && height != '') {
			var open = '<img src="' + image + '" ' + 'class="widthheight_x' + width + 'x' + height + '"' + '>'
		}
		else if (width != '' && height == '') {
			var open = '<img src="' + image + '" ' + 'class="maxwidth_' + width + '"' + '>'
		}
		else if (width == '' && height != '') {
			var open = '<img src="' + image + '" ' + 'class="maxheight_' + height + '"' + '>'
		}
		else {
			var open = '<img src="' + image + '">'
		}
		var close = '';
		if (!width.match(numberRegex)) {
			alert('Width value must be a number')
		}
		else if (!height.match(numberRegex)) {
			alert('Height value must be a number')
		}
		else {
			addHtmlTags(open, close);
			$('.addImageUrl').val('');
			$('.addImageWidth').val('');
			$('.addImageHeight').val('');
		}
	})
	// Add span tag with color rgb
	$('.addColor').live('click', function() {
		var numberRegex = /^(\s*|\d+)$/
		var red = $('.rgbRed').val();
		var green = $('.rgbGreen').val();
		var blue = $('.rgbBlue').val();
		var open = '<span class="color_x' + red + 'x' + green + 'x' + blue + '">';
		var close = '</span>'
		if (red == '' || green == '' || blue == '') {
			alert('Please enter in all color values')
		}
		else if (parseInt(red) > 255 || parseInt(red) < 0) {
			alert('Red values needs to be between 0 and 255')
		}
		else if (parseInt(green) > 255 || parseInt(green) < 0) {
			alert('Green values needs to be between 0 and 255')
		}
		else if (parseInt(blue) > 255 || parseInt(blue) < 0) {
			alert('Blue values needs to be between 0 and 255')
		}
		else if (!red.match(numberRegex) && !green.match(numberRegex) && !blue.match(numberRegex)) {
			alert('Color value needs to be a number between 0 and 255');
		}
		else {
			addHtmlTags(open, close);
		}
	})
	// Add span tag with font-size
	$('.addSize').live('click', function() {
		var numberRegex = /^(\s*|\d+)$/
		var size = $('.fontSize').val();
		var open = '<span class="fontsize_' + size + '">'
		var close = '</span>';
		if (size == '') {
			alert('Please enter a font size')
		}
		else if (!size.match(numberRegex)) {
			alert('Font size must be a number');
		}
		else {
			addHtmlTags(open, close);
		}
	})
	// Add target="_blank" to all anchor tag links in post entries
	$('.postSingle section a').attr("target", "_blank");
	// Add max
	if ($('.postSingle section img').length > 0) {
		$('.postSingle section img').each(function(i) {
			var widthReg = /maxwidth/;
			var heightReg = /maxheight/;
			var widthHeightReg = /widthheight/;
			var imgClass = $(this).attr("class");
			if (imgClass.match(widthReg)) {
				var width = imgClass.split('_')[1];
				$(this).css("max-width", width + "px");
			}
			if (imgClass.match(heightReg)) {
				var height = imgClass.split('_')[1];
				$(this).css("max-height", height + "px");
			}
			if (imgClass.match(widthHeightReg)) {
				var width = imgClass.split('x')[1];
				var height = imgClass.split('x')[2];
				$(this).css("max-width", width + "px");
				$(this).css("max-height", height + "px");
			}
		})
	}
	// Add color or font size style to post
	if ($('.postSingle section span').length > 0) {
		$('.postSingle section span').each(function(i) {
			var colorRegex = /color/;
			var fontSizeRegex = /fontsize/;
			var spanClass = $(this).attr("class");
			if (spanClass.match(colorRegex)) {
				var red = spanClass.split(/x/)[1];
				var green = spanClass.split(/x/)[2];
				var blue = spanClass.split(/x/)[3];
				$(this).css("color", "rgb(" + red + ", " + green + ", " + blue + ")")
			}
			if (spanClass.match(fontSizeRegex)) {
				var size = spanClass.split(/_/)[1];
				$(this).css("font-size", size + "px");
			}
		})
	}
})

// Insert the open and close tags around the highlighted selected text
function addHtmlTags(open, close) {
	var openTag = open;
	var closeTag = close;
	var el = $('#post')[0];
	var selectedText = getInputSelection(el);
	var start = selectedText.start;
	var end = selectedText.end;
	var content = $('.postContent');
	var contentVal = content.val();
	var stringFirst = contentVal.slice(0, start);
	var stringSelect = contentVal.slice(start, end);
	var stringLast = contentVal.slice(end, contentVal.length);
	content.val(stringFirst + openTag + stringSelect + closeTag + stringLast)
	return false;
}

// Get the starting index of highlighted selection and the ending index of highlighted selection
function getInputSelection(el) {
    var start = 0, end = 0, normalizedValue, range,
        textInputRange, len, endRange;

    if (typeof el.selectionStart == "number" && typeof el.selectionEnd == "number") {
        start = el.selectionStart;
        end = el.selectionEnd;
    } else {
        range = document.selection.createRange();

        if (range && range.parentElement() == el) {
            len = el.value.length;
            normalizedValue = el.value.replace(/\r\n/g, "\n");

            // Create a working TextRange that lives only in the input
            textInputRange = el.createTextRange();
            textInputRange.moveToBookmark(range.getBookmark());

            // Check if the start and end of the selection are at the very end
            // of the input, since moveStart/moveEnd doesn't return what we want
            // in those cases
            endRange = el.createTextRange();
            endRange.collapse(false);

            if (textInputRange.compareEndPoints("StartToEnd", endRange) > -1) {
                start = end = len;
            } else {
                start = -textInputRange.moveStart("character", -len);
                start += normalizedValue.slice(0, start).split("\n").length - 1;

                if (textInputRange.compareEndPoints("EndToEnd", endRange) > -1) {
                    end = len;
                } else {
                    end = -textInputRange.moveEnd("character", -len);
                    end += normalizedValue.slice(0, end).split("\n").length - 1;
                }
            }
        }
    }

    return {
        start: start,
        end: end
    };
}