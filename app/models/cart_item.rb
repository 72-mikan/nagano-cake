class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  validates :custoer_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true

  # 税込価格
  def subtotal
    item.with_tax_price * amount
  end

  # 商品個数更新処理
  def item_amount_update(amount)
    amount = self.amount + amount.to_i
    if amount <= 9 # 個数上限判定
      self.update(amount: amount)
    else
      self.update(amount: 9)
    end
  end

end
