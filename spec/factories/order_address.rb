FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    building { 'スカイマンション' }
    city { '東京市' }
    address { '1-2-3' }
    phone_number { '09012345678' }
  end
end
