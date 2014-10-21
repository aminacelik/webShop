class RemoveProductFromLineItems < ActiveRecord::Migration
  def change
    remove_reference :line_items, :product, index: true
  end
end
