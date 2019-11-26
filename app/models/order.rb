class Order < ApplicationRecord
  has_one_attached :file
  belongs_to :client
  has_many :item, dependent: :destroy

  def update_total
  	new_total = item.map{|i| i.price}.sum
  	new_total += shipping
  	update(total: new_total)
  end
end
