class Public::HomesController < ApplicationController
  def top
    @items = Item.order(id: "DESC").where(is_active: true).first(4)
    @genre_type = "全て"
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
