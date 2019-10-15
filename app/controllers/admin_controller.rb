class AdminController < ApplicationController
	before_action :authenticate_user!

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
end
