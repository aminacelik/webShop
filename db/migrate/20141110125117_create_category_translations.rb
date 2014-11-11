class CreateCategoryTranslations < ActiveRecord::Migration
  def change
    create_table :category_translations do |t|
      t.references :language, index: true
      t.references :category, index: true
      t.string :name

      t.timestamps
    end
  end
end
