class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :image, styles: {background: "1756x600#", medium: "600x400#", thumb: "100x100#"}, default_url: "images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :image, attachment_presence: true
end
