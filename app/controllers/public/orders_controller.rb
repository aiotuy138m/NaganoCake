class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    cart_items = current_customer.cart_items
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.save
      end
      redirect_to complete_orders_path
      cart_items.destroy_all
    else
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders
    @postage = 800
  end

  def show
    @order = Order.find(params[:id])
    @postage = 800
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @cart_items = current_customer.cart_items
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @ship = Address.find(params[:order][:ship_address_id])
      @order.post_code = @ship.postal_code
      @order.address = @ship.address
      @order.name = @ship.name
    elsif params[:order][:select_address] == "2"
      @order.post_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

  end

  def complete
  end


  private

  def order_params
    params.require(:order).permit(:post_code, :address, :name, :payment_way)
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :amount, :making_status)
  end

end
