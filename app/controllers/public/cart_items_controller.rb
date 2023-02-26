class Public::CartItemsController < ApplicationController
  def new
    @cart_item = CartItem.new
  end

  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @cart_item.item_id = @item.id
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = (cart_item.amount).to_i + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      else
        @cart_item.save
      end
    end
    redirect_to cart_items_path
  end


  def index
    @cart_items = current_customer.cart_items
    @subtotal = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_items = current_customer.cart_items
    if @cart_item.update(params[:id])
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_items = current_customer.cart_items
    @cart_item = @cart_items.find_by(params[:item_id])
    @cart_item.delete
    redirect_to cart_items_path
  end




  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
