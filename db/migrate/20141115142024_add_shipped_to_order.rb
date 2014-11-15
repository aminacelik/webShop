class AddShippedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipped, :boolean, default: false, index: true
  end
end
