module Place
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


	class TransactionAllocation < APIResource
		@resource    = '/transaction_allocations'
		@object_type = 'transaction_allocation'
	end


	class PaymentMethod < APIResource
		@resource    = '/payment_methods'
		@object_type = 'payment_method'
	end


	class Address < APIResource
		@resource    = '/addresses'
		@object_type = 'address'
	end


	class RecurringInvoice < APIResource
		@resource    = '/recurring_invoices'
		@object_type = 'recurring_invoice'
	end


	class Invoice < APIResource
		@resource    = '/invoices'
		@object_type = 'invoice'
	end


	class InvoiceItem < APIResource
		@resource    = '/invoice_items'
		@object_type = 'invoice_item'
	end


	class InvoicePayer < APIResource
		@resource    = '/invoice_payers'
		@object_type = 'invoice_payer'
	end


	class InvoiceItemAllocation < APIResource
		@resource    = '/invoice_item_allocations'
		@object_type = 'invoice_item_allocation'
	end
end
