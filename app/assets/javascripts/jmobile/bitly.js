function dealShowTwitterShort(long_url) {
    var login = "flashingdeals";
    var api_key = "R_8b0537e5029cb7e4f83c48bab1a66eba";
    $.getJSON("http://api.bitly.com/v3/shorten?callback=?", {
        "format": "json",
        "apikey": api_key,
        "login": login,
        "longUrl": long_url
    },
    function(response) {
        var origUrl = $('.contentWrapper:last .twitterShare').attr('href');
        var shortUrl = response.data.url;
        var newUrl = origUrl + shortUrl;
        $('.contentWrapper:last .twitterShare').attr('href', newUrl);
    });
};