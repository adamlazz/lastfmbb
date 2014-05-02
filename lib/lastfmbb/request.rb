class Request
    attr_reader :api_key
    attr_accessor :method
    attr_reader :user
    attr_accessor :period
    attr_reader :limit
    attr_reader :page

    def initialize(api_key, method, user, period="overall", limit="50", page="1")
        @api_key = api_key  # required
        @method = method    # required
        @user = user        # required
        @period = period    # default to overall
        @limit = limit      # default to 50
        @page = page        # default to 1
    end
end