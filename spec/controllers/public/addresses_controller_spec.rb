require 'rails_helper'

RSpec.describe Public::AddressesController, type: :controller do
  describe "indexアクションのテスト" do
    context "認証済みユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "レスポンスが正常である" do
        sign_in @customer
        get :index
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in @customer
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "200レスポンスを返す" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトする" do
        get :index
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end

  describe "createアクションのテスト" do
    before do
      @customer = FactoryBot.create(:customer)
    end

    context "認証済みのユーザーとして" do
      it "配送先が追加される" do
        address_params = FactoryBot.attributes_for(:address)
        sign_in @customer
        expect {
          post :create, params: { address: address_params }
        }.to change(@customer.addresses, :count).by(1)
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返す" do
        address_params = FactoryBot.attributes_for(:address)
        post :create, params: { address: address_params }
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリ台レストする" do
        address_params = FactoryBot.attributes_for(:address)
        post :create, params: { address: address_params }
        expect(response).to redirect_to '/customers/sign_in'
      end
    end
  end

  describe "editアクションのテスト" do
    context "認証済みのユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
        @address = FactoryBot.create(:address, customer: @customer)
      end

      it "レスポンスが正常である" do
        sign_in @customer
        get :edit, params: { id: @address.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in @customer
        get :edit, params: { id: @address.id }
        expect(response).to have_http_status "200"
      end
    end

    context "認証されていないユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
        @address = FactoryBot.create(:address, customer: @customer)
        @other_customer = FactoryBot.create(:customer, :other_customer)
      end

      it "302レスポンスを返す" do
        sign_in @other_customer
        get :edit, params: { id: @address.id }
        expect(response).to have_http_status "302"
      end

      it "マイページにリダイレクトされる" do
        sign_in @other_customer
        get :edit, params: { id: @address.id }
        expect(response).to redirect_to "/customers/my_page"
      end
    end
  end

  describe "updateアクションの正常テスト" do
    context "認証済みのユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
        @address = FactoryBot.create(:address, customer: @customer)
      end

      it "郵便番号を更新できる" do
        address_params = FactoryBot.attributes_for(:address, postal_code: "3334444")
        sign_in @customer
        patch :update, params: { id: @address.id, address: address_params }
        expect(@address.reload.postal_code).to eq "3334444"
      end

      it "住所を更新できる" do
        address_params = FactoryBot.attributes_for(:address, address: "大阪府")
        sign_in @customer
        patch :update, params: { id: @address.id, address: address_params }
        expect(@address.reload.address).to eq "大阪府"
      end

      it "宛名を更新できる" do
        address_params = FactoryBot.attributes_for(:address, name: "鈴木")
        sign_in @customer
        patch :update, params: { id: @address.id, address: address_params }
        expect(@address.reload.name).to eq "鈴木"
      end
    end
    
    context "認証されていないユーザーとして" do
      
    end
  end
  
  describe "updateアクション異常テスト" do
    
  end
end
