class Entry
    attr_reader :name
    attr_reader :playcount
    attr_reader :mbid
    attr_reader :url
    attr_reader :image

    def initialize(name, playcount, mbid, url, image)
        @name = name
        @playcount = playcount
        @mbid = mbid
        @url = url
        @image = image
    end
end
