class OrderProductImage < ActiveRecord::Base

  belongs_to :order_product

  has_attached_file :image, styles: {medium: "600x600#"}, default_url: "images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :image, attachment_presence: true


  def get_image
  	if image.present?
  		image.url(:medium)
  	end
  end


end
