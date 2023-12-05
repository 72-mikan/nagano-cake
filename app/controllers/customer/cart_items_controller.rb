class Customer::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @sum = 0
  end
  
  def create
    amount = cart_item_params[:amount]
    item_id = cart_item_params[:item_id]
    if cart_item = CartItem.find_by(item_id: item_id)
      amount = cart_item.amount + amount.to_i
      cart_item.update(amount: amount)
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
      cart_item.save
    end
    redirect_to customer_cart_items_path
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to customer_cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to customer_cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to customer_cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
