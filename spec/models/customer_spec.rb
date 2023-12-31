require 'rails_helper'

RSpec.describe "Customerモデルのテスト", type: :model do
  describe "バリデーション" do
    context "有効のテスト" do
      # 姓、名、姓カナ、名カナ、郵便番号、住所、電話番号、メール、パスワードがあれば有効な状態であること
      it "姓、名、姓カナ、名カナ、郵便番号、住所、電話番号、メール、パスワードがあれば有効であるか？" do
        expect(FactoryBot.build(:customer)).to be_valid
      end

      it "メールが重複していないと有効であるか？" do
        FactoryBot.create(:customer, :sequence_email)
        expect(FactoryBot.build(:customer, :sequence_email)).to be_valid
      end

      it "パスワードが6文字以上(6文字)であれば有効であるか？" do
        expect(FactoryBot.build(:customer, password: "testab")).to be_valid
      end

      it "パスワードが6文字以上(7文字)であれば有効であるか？" do
        expect(FactoryBot.build(:customer, password: "testabc")).to be_valid
      end

      it "パスワードが6文字以上(8文字)であれば有効であるか？" do
        expect(FactoryBot.build(:customer, password: "testabcd")).to be_valid
      end
    end

    context "無効のテスト" do
      # 姓がなければ無効な状態であること
      it "姓がないと無効であるか？" do
        customer = FactoryBot.build(:customer, last_name: nil)
        customer.valid?
        expect(customer.errors[:last_name]).to include("が入力されていません。")
      end

      # 名がなければ無効な状態であること
      it "名がないと無効であるか？" do
        customer = FactoryBot.build(:customer, first_name: nil)
        customer.valid?
        expect(customer.errors[:first_name]).to include("が入力されていません。")
      end

      # 姓カナがなければ無効な状態であること
      it "姓カナがないと無効であるか？" do
        customer = FactoryBot.build(:customer, last_name_kana: nil)
        customer.valid?
        expect(customer.errors[:last_name_kana]).to include("が入力されていません。")
      end

      # 名カナがなければ無効な状態であること
      it "名カナがない場合とであるか？" do
        customer = FactoryBot.build(:customer, first_name_kana: nil)
        customer.valid?
        expect(customer.errors[:first_name_kana]).to include("が入力されていません。")
      end

      # 郵便番号がなければ無効な状態であること
      it "郵便番号がないと無効であるか？" do
        customer = FactoryBot.build(:customer, postal_code: nil)
        customer.valid?
        expect(customer.errors[:postal_code]).to include("が入力されていません。")
      end

      # 住所がなければ無効な状態であること
      it "住所がない場合とであるか？" do
        customer = FactoryBot.build(:customer, address: nil)
        customer.valid?
        expect(customer.errors[:address]).to include("が入力されていません。")
      end

      # 電話番号がなければ無効な状態であること
      it "電話番号がないと無効であるか？" do
        customer = FactoryBot.build(:customer, telephone_number: nil)
        customer.valid?
        expect(customer.errors[:telephone_number]).to include("が入力されていません。")
      end

      # メールがなければ無効な状態であること
      it "メールアドレスがないと無効であるか？" do
        customer = FactoryBot.build(:customer, email: nil)
        customer.valid?
        expect(customer.errors[:email]).to include("が入力されていません。")
      end

      # 重複したメールアドレスなら無効な状態であること
      it "メールが重複していると無効であるか？" do
        FactoryBot.create(:customer)
        customer = FactoryBot.build(:customer)
        customer.valid?
        expect(customer.errors[:email]).to include("は既に使用されています。")
      end

      # パスワードがなければ無効な状態であること
      it "パスワードがないと無効であるか？" do
        customer = FactoryBot.build(:customer, password: nil)
        customer.valid?
        expect(customer.errors[:password]).to include("が入力されていません。")
      end

      # パスワードが6文字以下(5文字)であれば無効な状態であること
      it "パスワードが6文字以下(5文字)であれば無効であるか？" do
        customer = FactoryBot.build(:customer, password: "testa")
        customer.valid?
        expect(customer.errors[:password]).to include("は6文字以上に設定して下さい。")
      end

      it "パスワードが6文字以下(4文字)であれば無効であるか？" do
        customer = FactoryBot.build(:customer, password: "test")
        customer.valid?
        expect(customer.errors[:password]).to include("は6文字以上に設定して下さい。")
      end

      it "パスワードが6文字以下(3文字)であれば無効であるか？" do
        customer = FactoryBot.build(:customer, password: "tes")
        customer.valid?
        expect(customer.errors[:password]).to include("は6文字以上に設定して下さい。")
      end
    end

  end

  describe "メソッドのテスト" do
    context "正常のテスト" do
      # 顧客のフルネームを文字列として返すこと
      it "顧客のフルネームを文字列として返すか？" do
        expect(FactoryBot.build(:customer).full_name).to eq "田中 太郎"
      end

      # 顧客のフルアドレスを文字列として返すこと
      it "顧客のフルアドレスを文字列として返すか？" do
        expect(FactoryBot.build(:customer).full_address).to eq "〒1500043 東京都渋谷区道玄坂２丁目１"
      end
    end

    context "異常のテスト" do
      it "フルネームメソッドで姓がnilの場合エラーが起きるか？" do
        expect{FactoryBot.build(:customer, last_name: nil).full_name}.to raise_error(NoMethodError)
      end

      it "フルネームメソッドで名がnilの場合エラーが起きるか？" do
        expect{FactoryBot.build(:customer, first_name: nil).full_name}.to raise_error(TypeError)
      end

      it "顧客のフルアドレスメソッドで郵便番号がnilの場合エラーが起きるか？" do
        expect{FactoryBot.build(:customer, postal_code: nil).full_address}.to raise_error(TypeError)
      end

      it "顧客のフルアドレスメソッドで住所がnilの場合エラーが起きるか？" do
        expect{FactoryBot.build(:customer, address: nil).full_address}.to raise_error(TypeError)
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "正常のテスト" do

    end

    context "異常のテスト" do

    end
  end

end
