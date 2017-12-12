require "net/http"
require "uri"
require 'json'

module RentShare
	class APIResource
		@@resource = nil
		@@object_type = nil
		@@object_index = {}

		def initialize(client: nil, obj: obj)
			@client = client || RentShare.default_client
			self._set_obj(obj)
		end

		def _set_obj(obj)
			@_obj = obj
		end

		def self.request(method, path=nil, id: nil, client: nil, **kwargs)
			path   = path || @@resource
			client = client || RentShare.default_client

			if id
				path = File.join(path, id)
			end

			uri = URI.join(client.api_url, path)
			http = Net::HTTP.new(uri.host, uri.port)

			request = Net::HTTP.const_get(method).new(uri.request_uri)
			request.basic_auth(client.api_key, "")

			response = http.request(request)
			status_code = response.code

			begin
				obj = JSON.parse(response.body)
			rescue JSON::ParserError
				if status_code == '500'
					raise RentShare::InternalError.new
				end

				raise RentShare::InvalidResponse.new
			end

			if obj.class != Hash
				raise RentShare::InvalidResponse.new
			end

			object_type = obj["object"]
			if !object_type
				raise RentShare::InvalidResponse.new('Response missing "object" attribute')
			end

			if status_code != '200'
				if object_type != 'error'
					raise RentShare::InvalidResponse.new('Expected error object')
				end

				for exc in RentShare::APIException.descendants
					if exc.status_code != status_code
						next
					end

					if exc.error_type && exc.error_type != obj["error_type"]
						next
					end

					raise exc.new(obj["error_description"])
				end

				raise RentShare::APIException.new(obj["error_description"])
			end

			if object_type == 'list'
				return obj["values"].map {|o| self.new(:client=>client, :obj=>o) }
			end

			return self.new(:client=>client, :obj=>obj)
		end
	end
end
