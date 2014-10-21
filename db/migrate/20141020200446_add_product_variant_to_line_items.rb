class AddProductVariantToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :product_variant, index: true
  end
end
