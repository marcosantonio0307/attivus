class OrdersController < ApplicationController
	before_action :authenticate_client!
	before_action :set_client

	def finish
		@order = Order.find(params[:id])
		@order.update(status: 'pendente')
	end

	def edit
		@order = Order.find(params[:id])
		@total_order = 0
		@order.item.each do |item|
			if item.price != nil
				@total_order += item.price
			end
		end
	end

	def show
		@order = Order.find(params[:id])
	end

	private
		def set_client
			@client = current_client
		end
end
