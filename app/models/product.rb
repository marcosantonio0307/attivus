class Product < ApplicationRecord
	has_many_attached :files
	has_many :items
end
