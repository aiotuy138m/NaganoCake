class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  
  def customer_address_display
    '〒' + postal_code + ' ' + address + ' ' + last_name + first_name
  end
  
  enum is_deleted: { deleted: true, undeleted: false } 
  
end
