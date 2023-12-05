class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waitin_payment: 0, confirmed_payment: 1, under_construction: 2, shipping_prepraration: 3, shipped: 4}
  
  has_many :order_details, dependent: :destroy
  
  def total_amount
    total = 0
    order_details.each do |order_detail|
      total = total + order_detail.amount
    end
    return total
  end
  
  def total_payment
    total = 0
    order_details.each do |order_detail|
      total = total + order_detail.price * order_detail.amount
    end
    return total
  end
end
