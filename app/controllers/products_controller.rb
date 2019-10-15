class ProductsController < ApplicationController

	def create
		values = params.require(:product).permit!
		@product = Product.new values
		if params[:product][:news] == 'sim'
			@product.news = true
		else
			@product.news = false
		end	
		@product.save
		redirect_to admin_index_path
	end

	def update
		@product = Product.find(params[:id])
		values = params.require(:product).permit!
		@product.update values
		redirect_to admin_product_path(@product), notice: 'Produto atualizado com sucesso!'
	end

	def show
		@product = Product.find(params[:id])
	end
end
