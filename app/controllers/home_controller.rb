class HomeController < ApplicationController

	def index
		@news = Product.where(news: true)
		@news = @news.order :updated_at
		@news = @news.sample(4)
	end
end
