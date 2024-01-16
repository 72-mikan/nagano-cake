require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "バリデーション" do
    context "有効のテスト" do
      it "郵便番号、住所、宛名があれば有効" do
        expect(FactoryBot.build(:address)).to be_valid
      end

      it "郵便番号が7文字であれば有効" do
        expect(FactoryBot.build(:address, postal_code: "3334444")).to be_valid
      end
    end

    context "異常のテスト" do
      it "郵便番号がないと無効" do
        expect(FactoryBot.build(:address, postal_code: nil)).to_not be_valid
      end

      it "郵便番号が6文字であれば無効" do
        expect(FactoryBot.build(:address, postal_code: "111222")).to_not be_valid
      end

      it "郵便番号が8文字であれば無効" do
        expect(FactoryBot.build(:address, postal_code: "11122223")).to_not be_valid
      end

      it "住所がないと無効" do
        expect(FactoryBot.build(:address, address: nil)).to_not be_valid
      end

      it "宛名がないと無効" do
        expect(FactoryBot.build(:address, name: nil)).to_not be_valid
      end
    end
  end

  describe "メソッドのテスト" do
    context "正常のテスト" do
      it "配送先をフルアドレスとして返す" do
        expect(FactoryBot.build(:address).address_display).to eq "〒1112222 京都府 加藤"
      end
    end

    context "異常のテスト" do
      it "配送先をフルアドレスとして返す時、郵便番号がnilの場合エラー" do
        expect{FactoryBot.build(:address, postal_code: nil).address_display}.to raise_error(TypeError)
      end

      it "配送先をフルアドレスとして返す時、住所がnilの場合エラー" do
        expect{FactoryBot.build(:address, address: nil).address_display}.to raise_error(TypeError)
      end
      
      it "配送先をフルアドレスとして返す時、宛名がnilの場合エラー" do
        expect{FactoryBot.build(:address, name: nil).address_display}.to raise_error(TypeError)
      end
    end
  end
end
