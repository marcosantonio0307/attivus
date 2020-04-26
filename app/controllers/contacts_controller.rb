class ContactsController < ApplicationController
	def budget
		@contact = Contact.new
		@contact.contact_type = 'budget'
		@contact.status = false
		render :new
	end

	def professional
		@contact = Contact.new
		@contact.contact_type = 'professional'
		@contact.status = false
		render :new
	end

	def create
		values = params.require(:contact).permit!
		@contact = Contact.new(values)
		if @contact.save
			redirect_to root_path, notice: 'Obrigado por seu contato! Em breve iremos lhe responder :)'
		else
			redirect_to root_path, notice: 'Deculpe, houve um erro no envio do formulário :('
		end
	end
end
