class AddColorToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :color, index: true
  end
end
