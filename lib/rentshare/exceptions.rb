module RentShare
	class APIException < StandardError
		@error_type  = nil
		@status_code = nil

		def self.descendants
			ObjectSpace.each_object(Class).select { |klass| klass < self }
		end

		class << self
			attr_reader :error_type, :status_code
		end
	end


	class InvalidArguments < APIException
		@error_type  = 'InvalidArguments'
		@status_code = '400'
	end


	class InvalidRequest < APIException
		@error_type  = 'Error'
		@status_code = '400'
	end


	class Unauthorized < APIException
		@status_code = '401'
	end


	class Forbidden < APIException
		@status_code = '403'
	end


	class NotFound < APIException
		@status_code = '403'
	end


	class MethodNotAllowed < APIException
		@status_code = '405'
	end


	class TooManyRequests < APIException
		@status_code = '429'
	end


	class InternalError < APIException
		@status_code = '500'
	end


	class InvalidResponse < APIException
	end
end
