class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    if @cart_items == nil
      puts "カート内は空です。"
    else
      return
    end
  end

  def update
    
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    @cart_items.delete
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @item = Item.find(cart_item_params[:item.id])
    @cart_item = CartItem.new
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(params[:id])
      render item_path
    end
  end
end
