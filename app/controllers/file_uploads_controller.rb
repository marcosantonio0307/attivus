class FileUploadsController < ApplicationController
	belongs_to :products, dependent: :destroy
end
