class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def with_tax_price
    (price * Constants::CONSUMPTION_TAX_RATE).floor
  end
end
