class AddActiveToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :active, :boolean
    add_column :products, :offer, :boolean
    add_column :products, :price_offer, :decimal
  end
end
