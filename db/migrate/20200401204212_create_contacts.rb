class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :contact_type
      t.string :name
      t.string :clinic
      t.string :cr
      t.string :phone
      t.string :email
      t.text :description
      t.string :more_informations

      t.timestamps
    end
  end
end
