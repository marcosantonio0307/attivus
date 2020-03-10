class HomeController < ApplicationController

	def index
		@news = Product.where(news: true, active: true)
		@news = @news.order :updated_at
		@news = @news.sample(4)
		@offers = Product.where(offer: true, active: true)
		@offers = @offers.sample(8)
	end
end
