class ContactsController < ApplicationController
	def budget
		@contact = Contact.new
		@contact.contact_type = 'budget'
		render :new
	end
	def professional
		@contact = Contact.new
		@contact.contact_type = 'professional'
		render :new
	end
end
