require "net/http"
require "uri"
require "date"
require "rexml/document"
include REXML

# call last.fm API 
def load_top_last(req, api_key)
    uri = URI.parse('http://ws.audioscrobbler.com/2.0/?method=' + req.meth +  \
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
        
    if (req.meth == "user.getTopAlbums")
        meth = "album"
    elsif (req.meth == "user.getTopArtists")
        meth = "artist"
    elsif (req.meth == "user.getTopTracks")
        meth = "track"
    else
        $stderr.puts("Incorrect meth.")
    end
    
    result="[align=center][size=11][color="+color+"][b]"+req.user.capitalize+"'s Top "    \
        +req.limit+" "+meth.to_s.capitalize+"s ("+req.period+"):[/b][/color][/size][/align]"

    xml.elements.each("*/top" + meth.to_s + "s/" + meth.to_s + "") { |e|
        en_name     = e.get_elements("name").first.text
        playcount   = e.get_elements("playcount").first.text
        mbid        = e.get_elements("mbid").first.text
        url         = e.get_elements("url").first.text
        image_s = e.get_elements("image")[0].text
        image_m = e.get_elements("image")[1].text
        image_l = e.get_elements("image")[2].text
        
        if (meth == "album")
            aname       = e.get_elements("artist/name").first.text
            ambid       = e.get_elements("artist/mbid").first.text
            aurl        = e.get_elements("artist/url").first.text
            en = Album.new(en_name, playcount, mbid, url, image_l, aname, ambid, aurl)
    	elsif (meth == "artist")
            streamable  = e.get_elements("streamable").first.text
            en = Artist.new(en_name, playcount, mbid, url, image_l, streamable)
    	elsif (meth == "track")
            streamable  = e.get_elements("streamable").first.text
            aname       = e.get_elements("artist/name").first.text
            ambid       = e.get_elements("artist/mbid").first.text
            aurl        = e.get_elements("artist/url").first.text
            en = Track.new(en_name, playcount, mbid, url, image_l, streamable, aname, ambid, aurl)
        end
    	
    	result << "[quote][b]" + items.to_s + ".[/b] "
    	if (meth == "album")
    	    result << "[url=" + en.aurl + "]" + en.aname + "[/url] - [url=" + en.url + "][b]" + en.name + "[/b][/url] (" + en.playcount + ")[/quote][align=center][url=" + en.url + "][img]" + en.image + "[/img][/url][/align]\n"
        elsif (meth == "artist")
            result << "[url=" + en.url + "]" + en.name + "[/url] (" + en.playcount + ")[/quote][align=center][url=" + en.url + "][img]" + en.image + "[/img][/url][/align]\n"
    	elsif (meth == "track")
            result << "[url=" + en.aurl + "]" + en.aname + "[/url] - [url=" + en.aurl + "][b]" + en.name + "[/b][/url] (" + en.playcount + ")[/quote][align=center][url=" + en.url + "][img]" + en.image + "[/img][/url][/align]\n"
        end
        items += 1;
    }
    github_page = "https://github.com/adamlazz/bb-last"
    result << "[align=right]Generated on " + Date.today.to_s + "[/align]\n"
    result << "[align=right][b][url=" + github_page + "]GitHub[/url][/b][/align]"
    
    result
end

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each do |file| 
  require file
end

# main
meth    = "user.getTopAlbums"   # Albums, Artists, Tracks
user    = "nodonutweek"         # Last.fm user name
period  = "3month"              # overall, 7day, 3month, 6month, 12month (default overall)
limit   = "5"                   # results per page (default 50) 
page    = "1"                   # page to return (default 1)
api_key = "" # use your own

request = Request.new(meth, user, period, limit, page)

xml_s = load_top_last(request, api_key) # XML string
bbcode = gen_bb(xml_s, request) # outputs BBCode string
puts bbcode