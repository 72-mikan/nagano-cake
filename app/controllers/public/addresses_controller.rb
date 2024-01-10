class Public::AddressesController < ApplicationController
  before_action :ensure_customer, only: [:edit, :update]
  # 配送先登録一覧ページ処理
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  # 配送先登録処理
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  # 配送先登録編集ページ処理
  def edit
    customer = current_customer
    @address = Address.find(params[:id])
    if customer.id != @address.customer_id
      redirect_to addresses_path
    end
  end

  # 配送先登録編集処理
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  # 配送先登録削除処理
  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  def ensure_customer
    @address = Address.find(params[:id])
    unless current_customer == @address.customer
      redirect_to my_page_path
    end
  end
end
