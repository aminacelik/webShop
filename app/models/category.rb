class Category < ActiveRecord::Base
	has_many :products
	has_many :prder_products
	has_many :category_translations 
	
	validates :name, presence: true
	validates :name, uniqueness: true



	def name
		if I18n.locale == 'en'
			read_attribute(:name)
		else
			language = Language.where(short_name: I18n.locale).first
			@translation = category_translations.where(language_id: language.id).first
	    if @translation
				@translation.name
	    else
      		read_attribute(:name)
    	end
    end
	end

	
end
