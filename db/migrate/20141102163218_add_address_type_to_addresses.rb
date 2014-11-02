class AddAddressTypeToAddresses < ActiveRecord::Migration
  def change
  	add_reference :addresses, :address_type, index: true

  	remove_column :addresses, :shipping_default
  	remove_column :addresses, :billing_default
  	remove_column :addresses, :billing
  end
end
