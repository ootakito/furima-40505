FactoryBot.define do
  factory :item do
    name                  { 'Example Item Name' }
    description           { 'Example description of the item.' }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_cost_burden_id { 2 }
    prefecture_id         { 2 }
    shipping_duration_id  { 2 }
    association :user

    transient do
      price { 500 }
    end

    after(:build) do |item, evaluator|
      item.price = evaluator.price
    end

    trait :with_valid_price do
      price { 300 }
    end

    trait :with_invalid_low_price do
      price { 299 }
    end

    trait :with_invalid_high_price do
      price { 10_000_000 }
    end
    # 以下、画像に関する設定例
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
