class Admin::ContactsController < ApplicationController
	def budgets
		@title = 'Orçamentos Recebidos'
		@contacts = Contact.where(contact_type: 'budget', status: false)
		@contacts = @contacts.order(:created_at)
		render :index
	end

	def budgets_sends
		@title = 'Orçamentos Atendidos'
		@contacts = Contact.where(contact_type: 'budget', status: true)
		@contacts = @contacts.order(:created_at)
		render :index
	end

	def professional
		@title = 'Contatos Profissionais Recebidos'
		@contacts = Contact.where(contact_type: 'professional', status: false)
		@contacts = @contacts.order(:created_at)
		render :index
	end

	def professional_sends
		@title = 'Profissionais Atendidos'
		@contacts = Contact.where(contact_type: 'professional', status: true)
		@contacts = @contacts.order(:created_at)
		render :index
	end

	def edit
		contact = Contact.find(params[:id])
		contact.update(status: true)
		if contact.contact_type == 'budget'
			redirect_to admin_contacts_budgets_received_path, notice: 'Orçamento respondido'
		else
			redirect_to admin_contacts_professional_received_path, notice: 'Contato profissional respondido'
		end
	end

	def show
		@contact = Contact.find(params[:id])
		if @contact.contact_type == 'budget'
			@title = "Orçamento N° #{@contact.id}"
		else
			@title = "Solicitação Profissional Nº #{@contact.id}"
		end
	end
end