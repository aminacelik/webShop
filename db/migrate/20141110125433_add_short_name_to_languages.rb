class AddShortNameToLanguages < ActiveRecord::Migration
  def change
  	add_column :languages, :short_name, :string, index: true
  end
end
