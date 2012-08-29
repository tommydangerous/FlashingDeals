function bitly(long_url, name, tweet_id) {
    var login = "flashingdeals";
    var api_key = "R_8b0537e5029cb7e4f83c48bab1a66eba";
    $.getJSON("http://api.bitly.com/v3/shorten?callback=?", {
        "format": "json",
        "apikey": api_key,
        "login": login,
        "longUrl": long_url
    },
    function(response) {
        var bitlyRegex = /bit.ly/
        var origUrl = $('#' + tweet_id).attr('href');
        if (!origUrl.match(bitlyRegex)) {
            var twitterUrl = "https://twitter.com/intent/tweet?original_referer=&text="
            var linkName = name
            var shortUrl = response.data.url;
            var newUrl = twitterUrl + linkName + "%20" + shortUrl;
            $('#' + tweet_id).attr('href', newUrl);
            window.open($('#' + tweet_id).attr('href'))
        }
    });
};

$(document).ready(function() {
    $('.twitterShare').live('click', function(e) {
        var url = $(this).attr('href');
        var name = $(this).attr('name');
        var tweet_id = $(this).attr('id');
        bitly(url, name, tweet_id);
        e.preventDefault();
    })
})