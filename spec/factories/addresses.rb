FactoryBot.define do
  factory :address do
    association :customer
    postal_code { "1112222" }
    address { "京都府" }
    name { "加藤" }
  end
end
