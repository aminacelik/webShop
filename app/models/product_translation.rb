class ProductTranslation < ActiveRecord::Base
  belongs_to :language
  belongs_to :product
end
