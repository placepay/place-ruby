module RentShare
	class AccessToken < APIResource
		@resource    = '/access_tokens'
		@object_type = 'access_token'
	end


	class AutopayEnrollment < APIResource
		@resource    = '/autopay_enrollments'
		@object_type = 'autopay_enrollment'
	end


	class Event < APIResource
		@resource    = '/events'
		@object_type = 'event'
	end


	class Account < APIResource
		@resource    = '/accounts'
		@object_type = 'account'
	end


	class DepositAccount < APIResource
		@resource    = '/deposit_accounts'
		@object_type = 'deposit_account'
	end


	class Transaction < APIResource
		@resource    = '/transactions'
		@object_type = 'transaction'
	end


	class Address < APIResource
		@resource    = '/addresses'
		@object_type = 'address'
	end
end
