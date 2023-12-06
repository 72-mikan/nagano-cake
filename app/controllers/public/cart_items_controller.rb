class Public::CartItemsController < ApplicationController
  # カート内商品一覧ページ
  def index
    @cart_items = current_customer.cart_items
    @sum = 0
  end
  
  # カート登録処理
  def create
    amount = cart_item_params[:amount]
    item_id = cart_item_params[:item_id]
    if cart_item = CartItem.find_by(item_id: item_id) # 同一商品あり処理
      amount = cart_item.amount + amount.to_i
      cart_item.update(amount: amount)
    else # 同一商品なし処理
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
      cart_item.save
    end
    redirect_to cart_items_path
  end
  
  # カート内商品個数更新処理
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  # カート内商品削除処理
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  # カート内商品全削除処理
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
