class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
  end

  def update
    if @order = Order.find(params[:id])
      @order.update(order_params)
      return
    elsif @order_detail = OrderDetail.find(params[:id])
      @order_detail.update(order_detail_params)
    redirect_to admin_order_path
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
