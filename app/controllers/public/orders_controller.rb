class Customer::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
    if !@current_customer.cart_items.exists?
      redirect_to customer_items_path
    end
  end
  
  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    
    select_payment_method = params[:order][:payment_method]
    if select_payment_method != 'credit_card' && select_payment_method != 'transfer'
      render :new
      return
    end
    
    select_address = params[:order][:select_address]
    if select_address == '0'
      @order = my_address(@order)
    elsif select_address == '1'
      address = Address.find(params[:order][:address_id])
      @order = registered_address(@order, address)
    elsif select_address != '2'
      render :new
      return
    end
    @postal_cost = 800
    @cart_items = current_customer.cart_items
    @sum = 0
    render :confirm
  end
  
  def complete
  end
  
  def create
    order = order_confirmed
    create_ordre_ditails(order)
    redirect_to customer_order_complete_path
  end
  
  def index
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
  
  def my_address(order)
    order.postal_code = current_customer.postal_code
    order.address = current_customer.address
    order.name = current_customer.last_name + current_customer.first_name
    return order
  end
  
  def registered_address(order, address)
    order.postal_code = address.postal_code
    order.address = address.address
    order.name = address.name
    return order
  end
  
  def order_confirmed
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.total_payment = params[:order][:sum].to_i + params[:order][:postal_cost].to_i
    order.save
    return order
  end
  
  def create_ordre_ditails(order)
    current_customer.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = order.id
      order_detail.item_id = cart_item.item_id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price
      order_detail.save
    end
    current_customer.cart_items.destroy_all
  end
  
  
end
