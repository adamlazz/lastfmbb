class Album < Lastfmbb
    attr_reader :name
    attr_reader :playcount
    attr_reader :mbid
    attr_reader :url
    attr_reader :image
    attr_reader :aname
    attr_reader :abmid
    attr_reader :aurl

    def initialize(name, playcount, mbid, url, image, aname, ambid, aurl)
        @name = name
        @playcount = playcount
        @mbid = mbid
        @url = url
        @image = image
        @aname = aname
        @ambid = ambid
        @aurl = aurl
    end
end
