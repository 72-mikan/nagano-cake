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
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
