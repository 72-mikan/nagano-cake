require 'rails_helper'

RSpec.describe Public::CustomersController, type: :controller do
  describe "showアクションのテスト" do
    context "認証済みのユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "レスポンスが正常である" do
        sign_in @customer
        get :show
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in @customer
        get :show
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返す" do
        get :show
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトする" do
        get :show
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end

  describe "editアクションのテスト" do
    context "認証済みのユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "レスポンスが正常である" do
        sign_in @customer
        get :edit
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in @customer
        get :edit
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返す" do
        get :edit
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトする" do
        get :edit
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end

  describe "updateアクションのテスト" do
    context "認証済みユーザーとして正常テスト" do
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

      it "郵便番号を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, postal_code: "1112222")
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.postal_code).to eq "1112222"
      end

      it "住所を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, address: "大阪府")
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.address).to eq "大阪府"
      end

      it "電話番号を更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, telephone_number: "33344445555")
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.telephone_number).to eq "33344445555"
      end

      it "メールアドレスを更新できる" do
        customer_params = FactoryBot.attributes_for(:customer, email: "other_tester@example.com" )
        sign_in @customer
        patch :update, params: { customer: customer_params }
        expect(@customer.reload.email).to eq "other_tester@example.com"
      end
    end

    context "認証済みユーザーとして異常テスト" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "姓が空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, last_name: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.last_name).to eq "田中"
      end

      it "名が空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, first_name: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.first_name).to eq "太郎"
      end

      it "姓カナが空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, last_name_kana: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.last_name_kana).to eq "タナカ"
      end

      it "名カナが空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, first_name_kana: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.first_name_kana).to eq "タロウ"
      end

      it "郵便番号が空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, postal_code: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.postal_code).to eq "1500043"
      end

      it "住所が空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, address: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.address).to eq "東京都渋谷区道玄坂２丁目１"
      end

      it "電話番号が空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, telephone_number: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.telephone_number).to eq "00011112222"
      end

      it "電話番号が空の場合更新できない" do
        customer_params = FactoryBot.attributes_for(:customer, email: nil)
        sign_in @customer
        patch :update, params: { id: @customer.id, customer: customer_params }
        expect(@customer.reload.email).to eq "tester@example.com"
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

  describe "ubsubscribeアクションのテスト" do
    context "認証済みユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "正常にレスポンスを返す" do
        sign_in @customer
        get :unsubscribe
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in @customer
        get :unsubscribe
        expect(response).to have_http_status "200"
      end
    end

    context "ゲストとして" do
      it "302レスポンスを返す" do
        get :unsubscribe
        expect(response).to have_http_status "302"
      end

      it "サインインページにリダイレクトする" do
        get :unsubscribe
        expect(response).to redirect_to "/customers/sign_in"
      end
    end
  end

  describe "withdrawアクションのテスト" do
    context "認証済みユーザーとして" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      it "退会ができるか" do
        sign_in @customer
        patch :withdraw
        expect(@customer.reload.is_deleted).to be_truthy
      end

      it "ルートページにリダイレクトする" do
        sign_in @customer
        patch :withdraw
        expect(response).to redirect_to "/"
      end

      # it "ログアウトされているか" do
      #   sign_in @customer
      #   # patch :withdraw
        
      # end
    end
  end
  
  describe "guest_updateアクションのテスト" do
    context "ゲストログインしている" do
      before do
        @customer = Customer.guest
      end
      
      it "マイページにリダイレクトされる" do
        sign_in @customer
        patch :update
        expect(response).to redirect_to "/customers/my_page"
      end
    end
  end
  
  describe "guest_withdrawアクションのテスト" do
    context "ゲストログインしている" do
      before do
        @customer = Customer.guest
      end
      
      it "ルートページにリダイレクトされる" do
        sign_in @customer
        patch :withdraw
        expect(response).to redirect_to "/"
      end
    end
  end
end
