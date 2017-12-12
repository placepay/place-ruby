
module RentShare
	class Client
		attr_accessor :api_key, :api_url

		def initialize(api_key: nil, api_url: nil)
			@api_key = api_key
			@api_url = api_url
		end

		def api_key()
			@api_key || RentShare.api_key
		end

		def api_url()
			@api_url || RentShare.api_url
		end
	end
end
