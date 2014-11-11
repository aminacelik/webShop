class Language < ActiveRecord::Base
	has_many :product_translations
	has_many :category_translations
end
