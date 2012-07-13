require_relative 'entry.rb'

class Track < Entry
    attr_reader :streamable
    attr_reader :aname	
    attr_reader :ambid
    attr_reader :aurl

    def initialize(name, playcount, mbid, url, image, streamable, aname, ambid, aurl)
        @name = name
        @playcount = playcount
        @mbid = mbid
        @url = url
        @image = image
        @streamable = streamable
        @aname = aname
        @ambid = ambid
        @aurl = aurl
    end
end
