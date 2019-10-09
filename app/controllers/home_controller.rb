class HomeController < ApplicationController

	def index
		@news = Product.where(news: true)
	end
end
