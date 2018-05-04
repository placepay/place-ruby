
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
			if @api_key
				return @api_key
			end
			if self.api_key && self.api_key.start_with?('test_') and Place.api_url == Place.PROD_URL
				return Place.TEST_URL
			end
			return Place.api_url
		end
	end
end
