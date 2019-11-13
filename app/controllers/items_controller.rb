class ItemsController < ApplicationController
	before_action :set_client
	before_action :set_item, only:[:edit, :update, :destroy]
	before_action :set_order, only:[:edit, :update, :destroy]

	def add
		if @client.orders != [] && @client.orders.last.status == 'aberta'
			@product = Product.find(params[:id])
			@item = Item.create(product_id: @product.id, order_id: @client.orders.last.id,
			 price: @product.price, amount: 1)
			@client.orders.last.update_total
			redirect_to edit_order_item_path(@client.orders.last.id, @item)
		else
			@order = Order.create(status: 'aberta', total: 0, shipping: 0, client_id: @client.id)
			@product = Product.find(params[:id])
			@item = Item.create(product_id: @product.id, order_id: @order.id,
			 price: @product.price, amount: 1)
			@order.update_total
			redirect_to edit_order_item_path(@order, @item)
		end
	end

	def edit
	end

	def update
		amount = params[:item][:amount].to_i
		price = @item.product.price * amount
		@item.update(amount: amount, price: price)
		@order.update_total

		redirect_to order_path(@order), notice: 'Carrinho Atualizado!'
	end

	def destroy
		Item.destroy params[:id]
		@order.update_total
		redirect_to order_path(@order), notice: 'Item Removido!'
	end

	private
		def set_client
			@client = current_client
		end

		def set_item
			@item = Item.find(params[:id])
		end

		def set_order
			@order = Order.find(params[:order_id])
		end
end
