require 'rails_helper'

RSpec.describe Public::CustomersController, type: :controller do
  describe "showページのテスト" do
    context "認証済みのユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "レスポンスが正常であるか？" do
        sign_in @customer
        get :show
        expect(response).to be_successful
      end

      it "200レスポンスを返すか？" do
        sign_in @customer
        get :show
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すか？" do
        get :show
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトするか？" do
        get :show
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end

  describe "editページのテスト" do
    context "認証済みのユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "レスポンスが正常であるか？" do
        sign_in @customer
        get :edit
        expect(response).to be_successful
      end

      it "200レスポンスを返すか？" do
        sign_in @customer
        get :edit
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返すか？" do
        get :edit
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトするか？" do
        get :edit
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end

  describe "updateのテスト" do
    context "認証済みユーザーとして正常" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "顧客情報(姓)を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, last_name: "鈴木")
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.last_name).to eq "鈴木"
      end

      it "顧客情報(名)を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, first_name: "一郎")
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.first_name).to eq "一郎"
      end

      it "顧客情報(姓カナ)を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, last_name_kana: "スズキ" )
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.last_name_kana).to eq "スズキ"
      end

      it "顧客情報(名カナ)を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, first_name_kana: "イチロウ")
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.first_name_kana).to eq "イチロウ"
      end
    end

    context "ゲストとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "302レスポンスを返すこと" do
        customer_params = FactoryBot.attributes_for(:customer)
        patch :update, params: { customer: customer_params }
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        customer_params = FactoryBot.attributes_for(:customer)
        patch :update, params: { customer: customer_params }
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end
end
