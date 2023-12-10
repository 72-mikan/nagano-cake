class Public::CartItemsController < ApplicationController
  # カート内商品一覧ページ
  def index
    @cart_items = current_customer.cart_items
    @sum = 0
  end

  # カート登録処理
  # 1. 商品個数、商品IDの取得
  # 2. 商品個数が選択されているかの判定
  #    - 商品が選択されていない場合item_showへリダイレクト
  # 3. 同一商品がカートに含まれているカナの判定
  #    - 含まれている場合
  #      - 商品個数の更新
  #    - 含まれていない場合
  #      - 新規保存
  # 4. 商品一覧に遷移
  def create
    amount = cart_item_params[:amount]
    item_id = cart_item_params[:item_id]
    if amount == '' # 商品個数の判定
      flash[:item_error] = '個数を入力して下さい'
      redirect_to item_path(item_id)
      return
    end
    if cart_item = CartItem.find_by(item_id: item_id) # 同一商品あり処理
      amount = cart_item.amount + amount.to_i
      if amount <= 9 # 個数上限判定
        cart_item.update(amount: amount)
      else
        cart_item.update(amount: 9)
      end
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
