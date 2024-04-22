FactoryBot.define do
  factory :item do
    name                  { 'Example Item Name' }
    description           { 'Example description of the item.' }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_cost_burden_id { 2 }
    prefecture_id         { 2 }
    shipping_duration_id  { 2 }
    price                 { 500 }
    user                  { association :user }
    # 以下、画像に関する設定例
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
