class ProductsController < ApplicationController
	before_action :authenticate_user!, only:[:create, :update]

	def create
		values = params.require(:product).permit!
		@product = Product.new values
		if params[:product][:news] == 'sim'
			@product.news = true
		else
			@product.news = false
		end	
		if params[:product][:files] == nil
			@product.files.attach(io: File.open("app/assets/images/no-image.jpg"), filename: "no-image.jpg", content_type: "no-image/jpg")
		end
		@product.save
		redirect_to admin_products_path
	end

	def update
		@product = Product.find(params[:id])
		if @product.files.last != nil && params[:product][:files] != nil
			@product.files.last.purge
		end
		values = params.require(:product).permit!
		@product.update values
		redirect_to admin_product_path(@product), notice: 'Produto atualizado com sucesso!'
	end

	def show
		@product = Product.find(params[:id])
	end
end
