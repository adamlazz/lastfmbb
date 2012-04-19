require_relative 'entry.rb'

class Album < Entry
	attr_reader :aname
	attr_reader :abmid
	attr_reader :aurl

	def initialize(name, playcount, mbid, url, aname, ambid, aurl)
		@name = name
		@playcount = playcount
		@mbid = mbid
		@url = url
		@aname = aname
		@ambid = ambid
		@aurl = aurl
	end
end
