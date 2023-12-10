class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  # 税込価格
  def subtotal
    item.with_tax_price * amount
  end

end
