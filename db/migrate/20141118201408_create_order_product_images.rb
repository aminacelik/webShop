class CreateOrderProductImages < ActiveRecord::Migration
  def change
    create_table :order_product_images do |t|
    	t.references :order_product, index: true
    	t.attachment :image
    end
  end
end
