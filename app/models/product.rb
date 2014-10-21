class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :color
    
	has_many :product_variants

	validates :category, associated: true
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
    }
    
    before_destroy :ensure_not_referenced_by_any_line_item
    
    def self.latest
        Product.order(:updated_at).last
    end
    
    
   
    
end
