class AddOrderIdToTables < ActiveRecord::Migration
  def change
  	add_reference :addresses, :order
  	add_reference :products, :order
  	add_reference :product_variants, :order
  end
end
