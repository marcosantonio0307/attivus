class Admin::CategoriesController < ApplicationController
	before_action :authenticate_user!
	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		name = params[:name]
		Category.create(name: name)
		redirect_to admin_categories_path, notice: 'Categoria criada com sucesso!'
	end

	def update
		category = Category.find(params[:id])
		name = params[:name]
		category.update(name: name)

		redirect_to admin_categories_path, notice: 'Categoria atualizada com sucesso!'
	end

	def edit
		@category = Category.find(params[:id])
	end
end
