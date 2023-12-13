class Public::ItemsController < ApplicationController

  def index
    genre_id = params[:genre_id]
    genre_name = params[:name]
    if genre_id != nil
      @items = Item.where(genre_id: genre_id)
      @genre_type = genre_name
      @item_count = @items.where(is_active: true).count
    else
      @items = Item.all
      @genre_type = "全て"
      @item_count = Item.where(is_active: true).count
    end
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genre = Genre.all
  end

end
