FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthdate { Faker::Date.birthday }
  end
end
