bb-last
=======
`bb-last.rb` is a Ruby application using the Last.fm API that produces BBCode to be pasted into your About Me section based on your top artists, albums or tracks.

Installation
------------
	git clone (this repository)
	cd bb-last

To run:
	ruby bb-last.rb

Options
-------
The options are defined in the code.

* Method: `user.getTopAlbums`, `user.getTopArtists`, `user.getTopTracks`
* User: Last.fm user name
* Type: `artists`, `albums`, `track`
* Time: `overall`, `7day`, `3month`, `6month`, `12month`
* Limit: integer results per page
* Page: integer page number to return

License
-------
Copyright (c) 2012 Adam Lazzarato
Released under The MIT License. Check `LICENSE` for full statement. 
