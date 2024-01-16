class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  # フルネーム
  def full_name
    self.last_name + ' ' + self.first_name
  end

  # フルアドレス
  def full_address
    '〒' + self.postal_code + ' ' + self.address
  end

  # 商品合計金額算出
  def cart_item_total_payment
    total = 0
    self.cart_items.each do |cart_item|
      total += (cart_item.item.with_tax_price * cart_item.amount)
    end
    return total
  end
  
  def self.guest
    self.find_or_create_by!(email: "customer.guest@example.com") do |customer|
      customer.last_name = 'guest'
      customer.first_name = 'customer'
      customer.last_name_kana = 'ゲスト'
      customer.first_name_kana = 'カスタマー'
      customer.postal_code = '1112222'
      customer.address = 'guest address'
      customer.telephone_number = '00011112222'
      customer.password = SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
    end
  end

end
