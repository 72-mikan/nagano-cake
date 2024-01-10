FactoryBot.define do
  factory :customer do
    last_name { "田中" }
    first_name { "太郎" }
    last_name_kana { "タナカ" }
    first_name_kana { "タロウ" }
    postal_code { "1500043" }
    address { "東京都渋谷区道玄坂２丁目１" }
    telephone_number { "00011112222" }
    email { "tester@example.com" }
    password { "testabcd" }

    trait :other_customer do
      sequence(:email) { |n| "tester#{n}@example.com"}
    end

    # シーケンスメールアドレス
    trait :sequence_email do
      sequence(:email) { |n| "tester#{n}@example.com"}
    end

    # 編集データ
    trait :edit_customer do
      last_name { "鈴木" }
      first_name { "一郎" }
      last_name_kana { "スズキ" }
      first_name_kana { "イチロウ" }
      postal_code { "5428503" }
      address { "大阪府大阪市中央区難波５丁目1番60号" }
      telephone_number { "33344445555" }
      email { "testeredit@example.com" }
    end

    # trait :with_addresses do
    #   after(:create) { |customer| create_list{:address, 5, }}
    # end

  end
end
