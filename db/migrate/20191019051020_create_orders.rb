class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :client, foreign_key: true
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
