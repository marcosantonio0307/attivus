class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :set_order_and_today, only:[:confirm_payment, :confirm_send, :confirm_received, :show_order]

	def new_product
		@product = Product.new
	end

	def products
		@products = Product.order :id
	end

	def edit_product
		@product = Product.find(params[:id])
	end

	def show_product
		@product = Product.find(params[:id])
	end

	# Orders session -------------
	def payment_pending
		@title = 'Pedidos com Pagamento Pendente'
		@orders = Order.where(status: 'pendente')
		render 'admin/orders/orders'
	end

	def send_pending
		@title = 'Pedidos com Envio Pendente'
		@orders = Order.where(status: 'pago')
		render 'admin/orders/orders'
	end

	def received_pending
		@title = 'Pedidos com Recebimento Pendente'
		@orders = Order.where(status: 'enviado')
		render 'admin/orders/orders'
	end

	def finished
		@title = 'Pedidos com Recebimento Pendente'
		@orders = Order.where(status: 'finalizado')
		render 'admin/orders/orders'
	end

	def confirm_payment
		@order.update(status: 'pago')
		redirect_to admin_orders_payment_pending_path, notice: 'Pagamento Registrado com Sucesso!'
	end

	def confirm_send
		@order.update(status: 'enviado', send_date: @today)
		redirect_to admin_orders_payment_pending_path, notice: 'Envio Registrado com Sucesso!'
	end

	def confirm_received
		@order.update(status: 'finalizado', received_date: @today)
		redirect_to admin_orders_payment_pending_path, notice: 'Recebimento Registrado com Sucesso!'
	end

	def show_order
		render 'admin/orders/show_order'
	end

	# ----------------------------

	private
		def set_order_and_today
			@order = Order.find(params[:id])
			@today = Time.zone.now
		end
end
