
module Place
	class Client
		attr_accessor :api_key, :api_url

		def initialize(api_key: nil, api_url: nil)
			@api_key = api_key
			@api_url = api_url
		end

		def api_key()
			@api_key || Place.api_key
		end

		def api_url()
			@api_url || Place.api_url
		end
	end
end
