class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
  end
  
  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.status == 'confirmed_payment'
      change_status(order)
    end
    redirect_to admin_order_path(order.id)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def change_status(order)
    order.order_details.each do |order_detail|
      order_detail.update(status: 'wating')
    end
  end
  
end
