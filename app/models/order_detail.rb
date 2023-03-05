class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  def subtotal
    item.with_tax_price * amount
  end
  
  enum making_status: { unproduced: 0, waiting_for_production: 1, production: 2, production_complete: 3 }

end
