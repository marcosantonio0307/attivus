class FileUploadsController < ApplicationController
	belongs_to :orders, dependent: :destroy
	belongs_to :products, dependent: :destroy
end
