class User < ActiveRecord::Base
  
  belongs_to :role
  belongs_to :cart

  has_many :addresses, dependent: :destroy
  has_many :orders
	
  validates :name, :email, :role_id, presence: true
  validates :email, uniqueness: true
  validates :email, format: {
      with: %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i,
      message: 'Email address you entered is not valid.'
    }
  
  has_secure_password #validates if the pass and pass confirmation match
	
  def has_no_address?
    addresses.empty?
  end
    
  def the_same_billling_and_shipping_address?
    addresses.where(billing: true, shipping: true, default: true).first.present?
  end

  def default_billing_address
    addresses.where(billing: true, default: true).first
  end
    
  def default_shipping_address
    addresses.where(shipping: true, default: true).first
  end

  def get_all_billing_addresses
    addresses.where(billing: true)
  end

  def get_all_shipping_addresses
    addresses.where(shipping: true)
  end


end
