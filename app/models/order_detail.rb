class OrderDetail < ApplicationRecord
  enum status: { pending: 0, wating: 1, working: 2, completed: 3 }
  
  belongs_to :order
  belongs_to :item
  
  def total_payment
    item.price * amount
  end
end
