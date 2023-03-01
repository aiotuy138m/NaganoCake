class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_confirm_path
    else
      render new_order_path
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  def confirm
    @orders = current_customer.orders
  end

  def complete
  end


  private

  def order_params
    params.require(:order).permit(:post_code, :address, :name, :payment_way)
  end

end
