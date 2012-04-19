class Entry
	attr_reader :name
	attr_reader :playcount
	attr_reader :mbid
	attr_reader :url

	def initialize(name, playcount, mbid, url)
		@name = name
		@playcount = playcount
		@mbid = mbid
		@url = url
	end
end
