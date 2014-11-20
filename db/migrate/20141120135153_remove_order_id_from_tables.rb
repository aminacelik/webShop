class RemoveOrderIdFromTables < ActiveRecord::Migration
  def change
  	remove_column :products, :order_id
  	remove_column :product_variants, :order_id
  	remove_column :addresses, :order_id
  end
end
