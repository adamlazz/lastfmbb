class Request
	attr_reader :meth
	attr_reader :user
	attr_reader :period
	attr_reader :limit
	attr_reader :page

	def initialize(meth, user, period, limit, page)
		@meth = meth
		@user = user
		@period = period
		@limit = limit
		@page = page
	end
end
