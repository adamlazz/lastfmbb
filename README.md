lastfmbb
=======
`lastfmbb` is a Ruby gem that uses the Last.fm API to generate BBCode for pasting into your About Me section based on your top artists, albums or tracks.

Installation
------------
```gem install lastfmbb```

Usage
-----
To use the gem, create a `Request` object with the required options:

* API Key: http://www.last.fm/api (required)
* Method: `user.getTopAlbums`, `user.getTopArtists`, `user.getTopTracks` (required)
* User: Last.fm user name (required)
* Time: `overall`, `7day`, `1month`, `3month`, `6month`, `12month` (Optional, defaults to overall)
* Limit: integer results per page (Optional, defaults to 50)
* Page: integer page number to return (Optional, defaults to 1)

Then, pass this object to the `load_and_gen` method, which returns generated BBCode.

Example
-------
```ruby
require 'lastfmbb'

api_key = ""                  # Use your own
method  = "user.getTopAlbums" # Albums, Artists, Tracks
user    = "nodonutweek"       # Last.fm user name
period  = "3month"            # overall, 7day, 3month, 6month, 12month (Optional, default overall)
limit   = 5                   # Results per page (Optional, default 50)
page    = 1                   # Page to return (Optional, default 1)

request = Request.new(api_key, method, user, period, limit, page)
bbcode = Lastfmbb.load_and_gen(request)
puts bbcode
```

License
-------
Copyright (c) 2012 Adam Lazzarato. Released under The MIT License.
