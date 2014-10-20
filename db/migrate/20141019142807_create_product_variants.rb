class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.references :product, index: true
      t.references :size, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
