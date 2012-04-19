require_relative 'entry.rb'

class Artist < Entry
	attr_reader :streamable

	def initialize(name, playcount, mbid, url, streamable)
		@name = name
		@playcount = playcount
		@mbid = mbid
		@url = url
		@streamable = streamable
	end
end
