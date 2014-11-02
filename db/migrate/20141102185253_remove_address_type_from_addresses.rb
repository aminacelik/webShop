class RemoveAddressTypeFromAddresses < ActiveRecord::Migration
  def change
  	remove_reference :addresses, :address_type
  end
end
