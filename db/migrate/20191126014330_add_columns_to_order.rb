class AddColumnsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :send_date, :date
    add_column :orders, :received_date, :date
  end
end
