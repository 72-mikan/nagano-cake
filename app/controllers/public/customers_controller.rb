class Public::CustomersController < ApplicationController
  before_action :guest_update, only: [:update]
  before_action :guest_withdraw, only: [:withdraw]
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    if current_customer.update(customer_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    customer = current_customer
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  # ゲスト登録情報更新
  def guest_update
    if current_customer.email == "customer.guest@example.com" 
      flash[:notice] = "guestは登録情報を更新することができません。"
      redirect_to my_page_path
    end
  end
  
  # ゲスト退会処理
  def guest_withdraw
    if current_customer.email == "customer.guest@example.com" 
      reset_session
      redirect_to root_path
    end
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
