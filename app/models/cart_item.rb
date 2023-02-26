class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  has_one_attached :image
  

  def subtotal
    item.with_tax_price * amount
  end
  
  def get_image(width, hight)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, hight]).processed
  end
  
  
end
