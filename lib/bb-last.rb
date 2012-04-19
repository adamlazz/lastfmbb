require "net/http"
require "uri"
require "rexml/document"
include REXML

require_relative 'album.rb'
require_relative 'artist.rb'
require_relative 'track.rb'
require_relative 'entry.rb'
require_relative 'request.rb'

# call last.fm API 
def load_top_last(req, api_key)
    uri = URI.parse('http://ws.audioscrobbler.com/2.0/?method=' + req.method +  \
        '&user=' + req.user +       \
        '&period=' + req.period +   \
        '&limit=' + req.limit +     \
        '&page=' + req.page +       \
        '&api_key=' + api_key + '')
    
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)        
    
    if (response.code.to_i == 200) # OK
        response.body
    else
        $stderr.puts("Error calling Last.fm API\n
            Expected code 200. Got " + response.code + ".")
    end
end

# parse XML response from last.fm API and generate BBCode
def gen_bb(xml_s, req)
    xml = REXML::Document.new(xml_s) # REXML representation
    color = "#d51007"
    items = 1
        
    if (req.method == "user.getTopAlbums")
        method = "album"
    elsif (req.method == "user.getTopArtists")
        method = "artist"
    elsif (req.method == "user.getTopTracks")
        method = "track"
        puts method
    else
        $stderr.puts("Incorrect method.")
    end
    
    result="[align=center][size=11][color="+color+"][b]"+req.user.capitalize+"'s top "    \
        +req.limit+" "+method.to_s.capitalize+"s ("+req.period+"):[/b][/color][/size][/align]"

	xml.elements.each("*/top" + method.to_s + "s/" + method.to_s + "") { |e|   
	    # Entry
	    name        = e.get_elements("name").first.text
        playcount   = e.get_elements("playcount").first.text
    	mbid        = e.get_elements("mbid").first.text
        url         = e.get_elements("url").first.text
        
        if (method == "album")
    	    aname       = e.get_elements("artist/name").first.text
        	ambid       = e.get_elements("artist/mbid").first.text
        	aurl        = e.get_elements("artist/url").first.text
        	en = Album.new(name, playcount, mbid, url, aname, ambid, aurl)
    	elsif (method == "artist")
    	    streamable  = e.get_elements("streamable").first.text
    	    en = Artist.new(name, playcount, mbid, url, streamable)
    	elsif (method == "track")
    	    streamable  = e.get_elements("streamable").first.text
    	    aname       = e.get_elements("artist/name").first.text
        	ambid       = e.get_elements("artist/mbid").first.text
        	aurl        = e.get_elements("artist/url").first.text
            en = Track.new(name, playcount, mbid, url, streamable, aname, ambid, aurl)
        end
    	
    	if (method == "album" || method == "track")
            result << "[quote][b]" + items.to_s + ".[/b] [url=" + en.aurl + "]" + en.aname + "[/url] - [url=" + en.aurl + "][b]" + en.aname + "[/b][/url] (" + en.playcount + ")[/quote]
                [align=center][url=" + en.url + "][img][/img][/url][/align]\n"
        elsif (method == "artist")
            result << "[quote][b]" + items.to_s + ".[/b] [url=" + en.url + "]" + en.name + "[/url] (" + en.playcount + ")[/quote]
                [align=center][url=" + en.url + "][img][/img][/url][/align]\n"
        end
        items += 1;
    }
    
    result
end

# main
method  = "user.getTopTracks"  # Albums, Artists, Tracks
user    = "nodonutweek"         # Last.fm user name
period  = "3month"              # overall, 7day, 3month, 6month, 12month (default overall)
limit   = "5"                   # results per page (default 50) 
page    = "1"                   # page to return (default 1)
api_key = "" # use your own

request = Request.new(method, user, period, limit, page)

xml_s = load_top_last(request, api_key) # XML string
bbcode = gen_bb(xml_s, request) # outputs BBCode string
puts bbcode