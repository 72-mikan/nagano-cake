class Public::ItemsController < ApplicationController

  def index
    if params[:name] != nil
      @items = Item.where("name LIKE?", "%#{params[:name]}%")
      @item_type = params[:name]
      @item_count = Item.where("name LIKE?", "%#{params[:name]}%").where(is_active: true).count
    else
      @items = Item.all
      @item_type = "全て"
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
