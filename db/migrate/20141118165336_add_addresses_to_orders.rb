class AddAddressesToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :shipping_address_id, :integer, index: true
  	add_column :orders, :billing_address_id, :integer, index: true
  end
end
