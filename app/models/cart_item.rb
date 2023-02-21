class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def subtotal
    item.with_tax_price * amount
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
