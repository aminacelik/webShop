class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :unit
      t.decimal :exchange_rate, precision: 8, scale: 4

      t.timestamps
    end
  end
end
