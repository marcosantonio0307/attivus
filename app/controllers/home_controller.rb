class HomeController < ApplicationController

	def index
		@news = Product.where(news: true)
		@news = @news.order :updated_at
		@news = @news.sample(4)
		@sales = Product.all
		@sales = @sales.sample(8)
	end
end
