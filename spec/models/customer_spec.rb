require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validate test" do
    # 姓、名、姓カナ、名カナ、郵便番号、住所、電話番号、メール、パスワードがあれば有効な状態であること
    it "is valid with a last name, first name, last name kana, first name kana, postal code, address, telephone number, email and password" do
      customer = Customer.new(
        last_name: "田中",
        first_name: "太郎",
        last_name_kana: "タナカ",
        first_name_kana: "タロウ",
        postal_code: "1500043",
        address: "東京都渋谷区道玄坂２丁目１",
        telephone_number: "00011112222",
        email: "tester@example.com",
        password: "testabcd",
      )
      expect(customer).to be_valid
    end

    # 姓がなければ無効な状態であること
    it "is invalid with a last name" do
      customer = Customer.new(last_name: nil)
      customer.valid?
      expect(customer.errors[:last_name]).to include("が入力されていません。")
    end

    # 名がなければ無効な状態であること
    it "is invalid with a first name" do
      customer = Customer.new(first_name: nil)
      customer.valid?
      expect(customer.errors[:first_name]).to include("が入力されていません。")
    end

    # 姓カナがなければ無効な状態であること
    it "is invalid with a last name kana" do
      customer = Customer.new(last_name_kana: nil)
      customer.valid?
      expect(customer.errors[:last_name_kana]).to include("が入力されていません。")
    end

    # 名カナがなければ無効な状態であること
    it "is invalid with a first name kana" do
      customer = Customer.new(first_name_kana: nil)
      customer.valid?
      expect(customer.errors[:first_name_kana]).to include("が入力されていません。")
    end

    # 郵便番号がなければ無効な状態であること
    it "is invalid with a postal code" do
      customer = Customer.new(postal_code: nil)
      customer.valid?
      expect(customer.errors[:postal_code]).to include("が入力されていません。")
    end

    # 住所がなければ無効な状態であること
    it "is invalid with a address" do
      customer = Customer.new(address: nil)
      customer.valid?
      expect(customer.errors[:address]).to include("が入力されていません。")
    end

    # 電話番号がなければ無効な状態であること
    it "is invalid with a telephon number" do
      customer = Customer.new(telephone_number: nil)
      customer.valid?
      expect(customer.errors[:telephone_number]).to include("が入力されていません。")
    end

    # メールがなければ無効な状態であること
    it "is invalid with a email address" do
      customer = Customer.new(email: nil)
      customer.valid?
      expect(customer.errors[:email]).to include("が入力されていません。")
    end

    # 重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email address" do
      Customer.create(
        last_name: "田中",
        first_name: "太郎",
        last_name_kana: "タナカ",
        first_name_kana: "タロウ",
        postal_code: "1500043",
        address: "東京都渋谷区道玄坂２丁目１",
        telephone_number: "00011112222",
        email: "tester@example.com",
        password: "testabcd",
      )
      customer = Customer.new(
        last_name: "田中",
        first_name: "太郎",
        last_name_kana: "タナカ",
        first_name_kana: "タロウ",
        postal_code: "1500043",
        address: "東京都渋谷区道玄坂２丁目１",
        telephone_number: "00011112222",
        email: "tester@example.com",
        password: "testabcd",
      )
      customer.valid?
      expect(customer.errors[:email]).to include("は既に使用されています。")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid with a password" do
      customer = Customer.new(password: nil)
      customer.valid?
      expect(customer.errors[:password]).to include("が入力されていません。")
    end

    # パスワードが6文字以下(5文字)であれば無効な状態であること
    it " is invalid with a password is 6 character less" do
      customer = Customer.new(password: "test")
      customer.valid?
      expect(customer.errors[:password]).to include("は6文字以上に設定して下さい。")
    end
  end

  describe "method test" do
    context "normal test" do
      # 顧客のフルネームを文字列として返すこと
      it "is returns a customer's full name as a string" do
        customer = Customer.new(
          last_name: "田中",
          first_name: "太郎",
          last_name_kana: "タナカ",
          first_name_kana: "タロウ",
          postal_code: "1500043",
          address: "東京都渋谷区道玄坂２丁目１",
          telephone_number: "00011112222",
          email: "tester@example.com",
          password: "testabcd",
        )
        expect(customer.full_name).to eq "田中 太郎"
      end

      # 顧客のフルアドレスを文字列として返すこと
      it "is returns a customer's full address as a string" do
        customer = Customer.new(
          last_name: "田中",
          first_name: "太郎",
          last_name_kana: "タナカ",
          first_name_kana: "タロウ",
          postal_code: "1500043",
          address: "東京都渋谷区道玄坂２丁目１",
          telephone_number: "00011112222",
          email: "tester@example.com",
          password: "testabcd",
        )
        expect(customer.full_address).to eq "〒1500043 東京都渋谷区道玄坂２丁目１"
      end
    end

    context "abnormal test" do

    end
  end

end
