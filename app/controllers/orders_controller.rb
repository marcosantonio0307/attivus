class OrdersController < ApplicationController
	protect_from_forgery
	before_action :authenticate_client!
	before_action :set_client
	before_action :set_order, only:[:finish, :myorder, :edit, :checkout, :create, :show, :receipt]
	before_action :validation_client

	def finish
		@order.update(status: 'pendente')
		redirect_to myorder_path(@order), notice: 'Pedido Realizado! Aguardando Pagamento'
	end

	def edit
		order_total(@order)
	end

	def checkout
		@session_id = (PagSeguro::Session.create).id
	end

	def create
	    payment = PagSeguro::CreditCardTransactionRequest.new
	    payment.notification_url = "https://pagseguro-teste.herokuapp.com/notification"
	    payment.payment_mode = "gateway"
	    # Aqui vão os itens que serão cobrados na transação, caso você tenha multiplos itens
	    # em um carrinho altere aqui para incluir sua lista de itens
	    payment.items << {
	      id: @order.id,
	      description: "Nova Compra",
	      amount: @order.total,
	      weight: 0
	    }

	    # Criando uma referencia para a nossa ORDER
	    reference = "REF_#{(0...8).map { (65 + rand(26)).chr }.join}_#{@order.id}"
	    payment.reference = reference
	    payment.sender = {
	      hash: params[:sender_hash],
	      name: params[:name],
	      email: params[:email]
	    }

	    payment.credit_card_token = params[:card_token]
	    payment.holder = {
	     name: params[:card_name],
	     birth_date: params[:birthday],
	     document: {
	       type: "CPF",
	       value: params[:cpf]
	     },
	     phone: {
	       area_code: params[:phone_code],
	       number: params[:phone_number]
	     }
	    }

	    payment.installment = {
	     value: @order.total,
	     quantity: 1
	    }

	    puts "=> REQUEST"
	    puts PagSeguro::TransactionRequest::RequestSerializer.new(payment).to_params
	    puts

	    payment.create

	    # Cria uma Order para registro das transações
	    Order.update(status: 'pendente')

	    if payment.errors.any?
	     puts "=> ERRORS"
	     puts payment.errors.join("\n")
	     render plain: "Erro No Pagamento #{payment.errors.join("\n")}"
	    else
	     puts "=> Transaction"
	     puts "  code: #{payment.code}"
	     puts "  reference: #{payment.reference}"
	     puts "  type: #{payment.type_id}"
	     puts "  payment link: #{payment.payment_link}"
	     puts "  status: #{payment.status}"
	     puts "  payment method type: #{payment.payment_method}"
	     puts "  created at: #{payment.created_at}"
	     puts "  updated at: #{payment.updated_at}"
	     puts "  gross amount: #{payment.gross_amount.to_f}"
	     puts "  discount amount: #{payment.discount_amount.to_f}"
	     puts "  net amount: #{payment.net_amount.to_f}"
	     puts "  extra amount: #{payment.extra_amount.to_f}"
	     puts "  installment count: #{payment.installment_count}"

	     puts "    => Items"
	     puts "      items count: #{payment.items.size}"
	     payment.items.each do |item|
	       puts "      item id: #{item.id}"
	       puts "      description: #{item.description}"
	       puts "      quantity: #{item.quantity}"
	       puts "      amount: #{item.amount.to_f}"
	     end

	     puts "    => Sender"
	     puts "      name: #{payment.sender.name}"
	     puts "      email: #{payment.sender.email}"
	     puts "      phone: (#{payment.sender.phone.area_code}) #{payment.sender.phone.number}"
	     puts "      document: #{payment.sender.document}: #{payment.sender.document}"
	     redirect_to orders_finish_path, notice: 'Seu Pedido Foi Realizado! Aguardando confirmação do pagamento'
	    end

	end

	def orders_finish
		client = current_client
		@orders = Order.where(client_id: client.id)
	end

	def receipt
		@order.file.attach(params[:file])
		redirect_to myorder_path(@order)
	end

	def show
		order_total(@order)
	end

	def myorder
		order_total(@order)
	end

	private
		def set_client
			@client = current_client
		end

		def set_order
			@order = Order.find(params[:id])
		end

		def order_total(order)
			@total_order = 0
			order.item.each do |item|
				if item.price != nil
					@total_order += item.price
				end
			end
		end

		def validation_client
			unless current_client.email == @order.client.email
				redirect_to root_path
			end
		end
end
