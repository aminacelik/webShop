class AddDefaultValueToDefaultShippingAddress < ActiveRecord::Migration
  def change
    
    change_column :addresses, :shipping_default, :boolean, default: false
  end
end
