FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { Faker::Japanese::Name.last_name }
    first_name            { Faker::Japanese::Name.first_name }
    last_name_kana        { Faker::Japanese::Name.last_name.yomi }
    first_name_kana       { Faker::Japanese::Name.first_name.yomi }
    birthdate             { Faker::Date.birthday(min_age: 18, max_age: 65) }
    # transient do
    #   confirmation { true }
    # end

    # after(:build) do |user, evaluator|
    #   user.password_confirmation = user.password if evaluator.confirmation
    # end

    # factory :invalid_user do
    #   last_name { 'invalid' }
    #   first_name { 'invalid' }
    # end
  end
end
