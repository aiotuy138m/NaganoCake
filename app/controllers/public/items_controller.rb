class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: "sale").page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end
end
