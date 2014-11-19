class AddSalePriceToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :sale_price, :decimal, precision: 8, scale: 2, index: true
  	remove_column :product_translations, :price
  end
end
