require "date"
require "net/http"
require "rexml/document"
require "uri"

class Lastfmbb
    def self.load_and_gen(req)
        string=load_top_last(req)
        bb=gen_bb(req,string)
        bb
    end

    def self.load_top_last(req)
        uri = URI.parse('http://ws.audioscrobbler.com/2.0/?method=' + req.method + \
            '&user=' + req.user +          \
            '&period=' + req.period +      \
            '&limit=' + req.limit.to_s +   \
            '&page=' + req.page.to_s +     \
            '&api_key=' + req.api_key)

        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        if (response.code.to_i == 200) # OK
            response.body
        else
            $stderr.puts("Error calling Last.fm API. Expected code 200. Got code " + response.code + ".")
        end
    end

    def self.gen_bb(req, string)
        xml = REXML::Document.new(string) # REXML representation
        color = "#d51007"
        items = 1

        if (req.method == "user.getTopAlbums")
            req.method = "album"
        elsif (req.method == "user.getTopArtists")
            req.method = "artist"
        elsif (req.method == "user.getTopTracks")
            req.method = "track"
        else
            $stderr.puts("Incorrect method.")
        end

        if (req.period == "7day")
            req.period = "Last 7 days"
        elsif (req.period == "1month")
            req.period = "Last month"
        elsif (req.period == "3month")
            req.period = "Last 3 months"
        elsif (req.period == "6month")
            req.period = "Last 6 months"
        elsif (req.period == "12month")
            req.period = "Last year"
        elsif (req.period == "overall")
            req.period = "Overall"
        else
            $stderr.puts("Incorrect period.")
        end

        result="[align=center][size=11][color="+color+"][b]"+req.user.capitalize+"'s Top " +req.limit.to_s+" "+req.method.sub("user.getTop","").capitalize+"s ("+req.period.to_s+"):[/b][/color][/size][/align]"

        xml.elements.each("*/top" + req.method.to_s + "s/" + req.method.to_s + "") { |e|
            en_name     = e.get_elements("name").first.text
            playcount   = e.get_elements("playcount").first.text
            mbid        = e.get_elements("mbid").first.text
            url         = e.get_elements("url").first.text

            begin
                image_l= e.get_elements("image")[2].text
            rescue NomethododError => ex
                image_l=""
            end

            if (req.method == "album")
                aname       = e.get_elements("artist/name").first.text
                ambid       = e.get_elements("artist/mbid").first.text
                aurl        = e.get_elements("artist/url").first.text
                en = Album.new(en_name, playcount, mbid, url, image_l, aname, ambid, aurl)
            elsif (req.method == "artist")
                streamable  = e.get_elements("streamable").first.text
                en = Artist.new(en_name, playcount, mbid, url, image_l, streamable)
            elsif (req.method == "track")
                streamable  = e.get_elements("streamable").first.text
                aname       = e.get_elements("artist/name").first.text
                ambid       = e.get_elements("artist/mbid").first.text
                aurl        = e.get_elements("artist/url").first.text
                en = Track.new(en_name, playcount, mbid, url, image_l, streamable, aname, ambid, aurl)
            end

            result << "[quote][b]" + items.to_s + ".[/b] "
            if (req.method == "album" || req.method == "track")
                result << "[url=" + en.aurl + "]" + en.aname + "[/url] - [url=" + en.url + "][b]" + en.name + "[/b][/url] (" + en.playcount + ")[/quote][align=center][url=" + en.url + "][img]" + en.image + "[/img][/url][/align]\n"
            elsif (req.method == "artist")
                result << "[url=" + en.url + "]" + en.name + "[/url] (" + en.playcount + ")[/quote][align=center][url=" + en.url + "][img]" + en.image + "[/img][/url][/align]\n"
            end
            items += 1;
        }
        result << "[align=right]Generated on " + Date.today.to_s + "[/align]\n"
        result
    end
end

require_relative "lastfmbb/album.rb"
require_relative "lastfmbb/artist.rb"
require_relative "lastfmbb/track.rb"
require_relative "lastfmbb/request.rb"
