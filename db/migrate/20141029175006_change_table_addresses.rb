class ChangeTableAddresses < ActiveRecord::Migration
  def change
    remove_reference :addresses, :address_type, index: true
    remove_column :addresses, :floor
    remove_column :addresses, :flat
    
    add_column :addresses, :details, :string
    add_column :addresses, :first_name, :string
    add_column :addresses, :last_name, :string
    
    rename_column :addresses, :default, :shipping_default
    
    change_column_default :addresses, :shipping_default, false
    add_index :addresses, :shipping_default
    add_column :addresses, :billing, :boolean, default: false, index: true
  end
end
