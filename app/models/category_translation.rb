class CategoryTranslation < ActiveRecord::Base
  belongs_to :language
  belongs_to :category
end
