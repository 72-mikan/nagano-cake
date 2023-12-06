class Public::OrdersController < ApplicationController
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
    @order.customer_id = @customer.id

    # 配送先選択処理
    select_address = params[:order][:select_address]
    if select_address == '0'
      # 自身の住所セット
      @order = set_order_address(@order, @customer.postal_code, @customer.address, @customer.full_name)
    elsif select_address == '1'
      # 登録済み住所セット
      address = Address.find(params[:order][:address_id])
      @order = set_order_address(address.postal_code, address.address, address.name)
    end

    # 送料セット
    @order.shipping_cost = Constants::SHIPPING_COST

    # **処理重**
    @order.total_payment = @customer.cart_item_total_payment

    if @order.valid?
      @cart_items = current_customer.cart_items
      @sum = 0
      render :confirm
    else
      render :new
    end
  end

  def complete
  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.total_payment = params[:order][:sum].to_i + params[:order][:postal_cost].to_i
    order.save
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

  def set_order_address(order, postal_code, address, name)
    order.postal_code = postal_code
    order.address = address
    order.name = name
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
