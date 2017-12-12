require "rentshare/version"
require "rentshare/api_resource"
require "rentshare/client"
require "rentshare/exceptions"

module RentShare

	@PROD_URL = "https://api.rentshare.com"
	@TEST_URL = "https://staging-api.rentshare.com"

	@api_key = nil
	@api_url = @PROD_URL

	@default_client = self::Client.new

	class << self
		attr_accessor :PROD_URL, :TEST_URL, :api_key, :api_url, :default_client
	end

end
