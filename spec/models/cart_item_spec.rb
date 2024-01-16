require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "バリデーション" do
    context "有効のテスト" do
      before do
        @customer = FactoryBot.create(:customer)
        genre = Genre.create(name: "ケーキ")
        @item = Item.create(
          genre_id: genre.id,
          name: "ショートケーキ",
          introduction: "おいしいケーキ",
          price: 600,
          is_active: true,
        )
      end
      
      it "customer_id, item_id, 数量があれば有効" do
        expect(FactoryBot.build(:cart_item, customer: @customer, item: @item)).to be_valid
      end
      
    end
  end
end
