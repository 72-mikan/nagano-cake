class Admin::OrderDetailsController < ApplicationController
  
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order = order_detail.order
    change_status(order_detail, order)
    redirect_to admin_order_path(order_detail.order.id)
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
  
  def change_status(order_detail, order)
    
    if order_detail.status = 'working'
      order_detail.order.update(status: 'under_construction')
    end
    
    order.order_details.each do |order_data|
      if order_data.status != 'completed'
        return
      end
    end
    
    order_detail.order.update(status: 'shipping_prepraration')
    
  end
end
