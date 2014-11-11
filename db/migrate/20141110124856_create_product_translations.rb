class CreateProductTranslations < ActiveRecord::Migration
  def change
    create_table :product_translations do |t|
      t.references :language, index: true
      t.references :product, index: true
      t.string :title
      t.text :description
      t.decimal :price

    end
  end
end
