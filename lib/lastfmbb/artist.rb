class Artist < Lastfmbb
    attr_reader :name
    attr_reader :playcount
    attr_reader :mbid
    attr_reader :url
    attr_reader :image
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
