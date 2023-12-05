class Admin::ItemsController < ApplicationController
  
  def index
    if params[:item_name] != nil
      @items = Item.where("name LIKE?", "%#{params[:item_name]}%")
    else
      @items = Item.all
    end
  end
  
  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end
  
  def show
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
  
end
