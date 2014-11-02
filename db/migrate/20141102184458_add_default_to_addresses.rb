class AddDefaultToAddresses < ActiveRecord::Migration
  def change
  	add_column :addresses, :shipping, :boolean, index: true, default: false
  	add_column :addresses, :billing, :boolean, index: true, default: false
  	add_column :addresses, :default, :boolean, index: true, default: false  
  end
end
