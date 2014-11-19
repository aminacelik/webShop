class CreateOrderProductVariants < ActiveRecord::Migration
  def change
    create_table :order_product_variants do |t|
      t.references :order_product, index: true
      t.references :size, index: true
      t.references :color, index: true
      t.integer :quantity
      t.references :order, index: true
    end
  end
end
