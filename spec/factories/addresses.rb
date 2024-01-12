FactoryBot.define do
  factory :address do
    association :customer
    postal_code { "1112222" }
    address { "京都府" }
    name { "加藤" }
    
    trait :other_address do
      postal_code { "3334444" }
      address { "大阪府" }
      name { "鈴木" }
    end
  end
end
