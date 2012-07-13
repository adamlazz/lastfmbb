require_relative 'entry.rb'

class Artist < Entry
    attr_reader :streamable

    def initialize(name, playcount, mbid, url, image, streamable)
        @name = name
        @playcount = playcount
        @mbid = mbid
        @url = url
        @image = image
        @streamable = streamable
    end
end
