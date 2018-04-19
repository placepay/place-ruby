require "place/version"
require "place/client"
require "place/exceptions"
require "place/api_resource"
require "place/resources"

module Place

	@PROD_URL = "https://api.placepay.com"
	@TEST_URL = "https://test-api.placepay.com"

	@api_key = nil
	@api_url = @PROD_URL

	@default_client = self::Client.new

	class << self
		attr_accessor :PROD_URL, :TEST_URL, :api_key, :api_url, :default_client
	end

end
