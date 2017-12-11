require "rentshare/version"

module RentShare
	
	@PROD_URL = "https://api.rentshare.com"
	@TEST_URL = "https://staging-api.rentshare.com"
	
	@api_key = nil
	@api_url = @PROD_URL
	
	class << self
    attr_accessor :PROD_URL, :TEST_URL, :api_key, :api_url
  end
end