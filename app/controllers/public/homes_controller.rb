class Public::HomesController < ApplicationController
  def top
    @items = Item.order(id: "DESC").where(is_active: true).first(4)
    @genre_type = "全て"
    @item_count = Item.where(is_active: true).last(4).count
    @genres = Genre.all
  end
end
