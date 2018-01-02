require "net/http"
require "uri"
require "json"

module RentShare

	def self.merge_obj( obj: nil, **params )
		params = params.collect{|k,v| [k.to_s, v]}.to_h
		if obj
			obj = obj.merge(params)
		else
			obj = params
		end
		return obj
	end

	def self.conv_object(obj, client: nil, inverse: false)
		obj = obj.clone
		if obj.class == Array
			iter = obj.map.with_index{|a,i| [i,a] }
		else
			iter = obj
		end

		iter.each do |key, val|
			if inverse
				if val.is_a?(RentShare::APIResource)
					obj[key] = val._obj
					val = obj[key]
				end
			elsif val.is_a?(Hash) and val['object']
				for resource in RentShare::APIResource.descendants
					if val['object'] != resource.object_type
						next
					end

					obj[key] = resource.new(client: client, obj: val)
					val = obj[key]
					break
				end
			end
			if [Hash, Array].member? val.class
				obj[key] = RentShare::conv_object(val, client:client, inverse: inverse)
			end
		end

		return obj
	end

	class APIResource
		attr_accessor :_obj

		def self.descendants
			ObjectSpace.each_object(Class).select { |klass| klass < self }
		end

		@resource = nil
		@object_type = nil
		@@object_index = {}

		class << self
			attr_reader :resource, :object_type
		end

		def self.new(client: nil, obj: nil, **params)
			obj = RentShare::merge_obj( obj: obj, **params )

			if obj["id"]
				if @@object_index[obj["id"]]
					@@object_index[obj["id"]]._set_obj(obj)
					return @@object_index[obj["id"]]
				end
			end
			super
		end

		def initialize(client: nil, obj: nil, **params)
			obj = RentShare::merge_obj( obj: obj, **params )
			@client = client || RentShare.default_client
			self._set_obj(obj)
		end

		def _set_obj(obj)
			@_obj = obj
			@_obj = RentShare::conv_object(@_obj, client: @_client)
			if obj["id"]
				@@object_index[obj["id"]] = self
			end
		end

		def method_missing(name, *args)
			attr = name.to_s
			if @_obj.key?(attr)
				return @_obj[attr]
			end
			super
		end

		def json()
			return JSON.pretty_generate(RentShare::conv_object(@_obj, inverse: true))
		end

		def self.request(method, path=nil, id: nil, client: nil, json: nil, params: nil)
			path   = path || @resource
			client = client || RentShare.default_client

			if id; path = File.join(path, id) end
			if path[0] == '/'; path = path[1..-1] end

			uri = URI.join(client.api_url, path)
			if params; uri.query = URI.encode_www_form(params) end

			http = Net::HTTP.new(uri.host, uri.port)
			if uri.port == 443; http.use_ssl = true end
			request = Net::HTTP.const_get(method).new(uri.request_uri)
			request.basic_auth(client.api_key, "")

			if json
				request.body = json.to_json
				request.add_field("Content-Type", "application/json")
			end

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
					if exc.status_code != status_code; next end

					if exc.error_type && exc.error_type != obj["error_type"]; next end

					raise exc.new(obj["error_description"])
				end

				raise RentShare::APIException.new(obj["error_description"])
			end

			if object_type == 'list'
				return obj["values"].map {|o| self.new(:client=>client, :obj=>o) }
			end

			return self.new(:client=>client, :obj=>obj)
		end

		def update(**updates)
			self.class.request('Put', id: self.id, json: updates)
		end

		def delete()
			self.class.request('Delete', id: self.id)
		end

		def self.get(id,update:nil)
			if update
				return self.request('Put', id: id, json: update )
			end
			return self.request('Get', id: id)
		end

		def self.select( update_all: nil, delete_all: false, **filter_by)
			if update_all
				return self.request('Put', params: filter_by, json: update_all)
			elsif delete_all
				return self.request('Delete', params: filter_by)
			else
				return self.request('Get', params: filter_by)
			end
		end

		def self.create( obj, **params)
			if obj.class == Array
				obj = {"object"=>"list", "values"=>obj}
			else
				obj = RentShare::merge_obj( obj: obj, **params )
			end
			obj = RentShare::conv_object(obj, inverse: true)
			return self.request('Post', json: obj)
		end

		def self.update_all(updates)
			updates = updates.map {|o, upd| Hash(id: o.id, **upd) }
			return self.request('Put',
								json: {"object"=>"list", "values"=>updates})
		end

		def self.delete_all(objects)
			deletes = objects.map {|o| o.id }.join('|')
			return self.request('Delete', params: {'id'=>deletes})
		end
	end
end
