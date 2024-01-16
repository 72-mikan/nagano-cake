FactoryBot.define do
  factory :cart_item do
    association :customer
    association :item
    sequence(:amount) { |n| n * 2 }
  end
end
