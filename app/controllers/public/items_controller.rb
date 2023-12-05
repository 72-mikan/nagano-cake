class Customer::ItemsController < ApplicationController
  
  def index
    puts 'test'
    puts params[:genre_id]
    if params[:genre_id] != nil
      puts 'test'
      @items = Item.where("genre_id LIKE?", "%#{params[:genre_id]}%")
      @item_type = "ジャンル一覧"
      @item_count = Item.where("genre_id LIKE?", "%#{params[:genre_id]}%").count
    else
      @items = Item.all
      @item_type = "商品一覧"
      @item_count = Item.where(is_active: true).count
    end
    @tax = 1.08
    @genre = Genre.all
  end
  
  def show
    @item = Item.find(params[:id])
    @tax = 1.08
    @cart_item = CartItem.new
    @genre = Genre.all
  end
  
end
