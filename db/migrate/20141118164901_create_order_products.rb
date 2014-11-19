class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.references :category, index: true
    end
  end
end
