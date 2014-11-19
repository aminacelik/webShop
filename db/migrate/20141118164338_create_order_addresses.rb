class CreateOrderAddresses < ActiveRecord::Migration
  def change
    create_table :order_addresses do |t|
      t.string :street_name
      t.integer :street_number
      t.references :user, index: true
      t.references :city, index: true
      t.string :details
      t.string :first_name
      t.string :last_name
    end
  end
end
