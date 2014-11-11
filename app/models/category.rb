class Category < ActiveRecord::Base
	has_many :products
	has_many :category_translations 
	
	validates :name, presence: true
	validates :name, uniqueness: true


	def translation_for_category_name(short_name)
		language = Language.where(short_name: short_name).first
		@translation = category_translations.where(language_id: language.id).first
		@translation.name
	end
end
