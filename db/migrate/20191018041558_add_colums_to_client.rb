class AddColumsToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :name, :string
    add_column :clients, :cpf, :string
    add_column :clients, :phone, :string
    add_column :clients, :cep, :string
    add_column :clients, :city, :string
    add_column :clients, :uf, :string
    add_column :clients, :address, :string
  end
end
