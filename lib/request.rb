class Request
	attr_reader :method
	attr_reader :user
	attr_reader :period
	attr_reader :limit
	attr_reader :page

	def initialize(method, user, period, limit, page)
		@method = method
		@user = user
		@period = period
		@limit = limit
		@page = page
	end
end
