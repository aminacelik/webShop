class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :image, styles: {background: "1756x600#", medium: "400x400>", thumb: "100x100#"}, default_url: "images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :image, attachment_presence: true


  def get_thumb_image
  	image.url(:thumb)
  end

  def get_medium_image
  	image.url(:medium)
  end

  def get_background_image
  	image.url(:background)
  end

end
