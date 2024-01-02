class Public::CartItemsController < ApplicationController
  # カート内商品一覧ページ
  # カート内商品一覧データの
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
    if cart_item_params[:amount].empty? # 商品個数の判定
      flash[:item_error] = '個数を入力して下さい'
      redirect_to item_path(cart_item_params[:item_id])
      return
    end

    if cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id]) # 同一商品あり処理
      # 商品数更新
      cart_item.item_amount_update(cart_item_params[:amount])
    else # 同一商品なし処理
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = customer.id
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
